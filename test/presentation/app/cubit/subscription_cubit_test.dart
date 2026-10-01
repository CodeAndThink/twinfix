import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/services/iap_service.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import '../../../support/iap_fixtures.dart';

class RecordingProfiles implements AuthRepository {
  final writes = <bool>[];
  final users = <String?>[];
  bool fail = false;
  @override
  Future<void> updateProStatus({required bool isPro, String? userId}) async {
    if (fail) throw StateError('Profile unavailable');
    writes.add(isPro);
    users.add(userId);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('purchases_flutter');
  late RecordingProfiles profiles;
  late SubscriptionCubit cubit;
  bool readFails = false;
  String? purchaseError;
  Completer<Map<String, dynamic>>? restoreResult;
  var restoreCalls = 0;
  late Map<String, Future<dynamic> Function(MethodCall)> overrides;
  var rcUser = r'$RCAnonymousID:test';
  var premium = true;
  var purchaseCalls = 0;
  var readCalls = 0;

  setUp(() async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    dotenv.loadFromString(envString: 'REVENUECAT_ANDROID_KEY=goog_test');
    await S.load(const Locale('en'));
    profiles = RecordingProfiles();
    readFails = false;
    purchaseError = null;
    restoreResult = null;
    restoreCalls = 0;
    overrides = {};
    rcUser = r'$RCAnonymousID:test';
    premium = true;
    purchaseCalls = 0;
    readCalls = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          if (overrides.containsKey(call.method)) {
            return overrides[call.method]!(call);
          }
          switch (call.method) {
            case 'getCustomerInfo':
              readCalls++;
              if (readFails) throw PlatformException(code: '10');
              return customerJson(premium: premium);
            case 'isAnonymous':
              return rcUser.startsWith(r'$RCAnonymousID:');
            case 'getAppUserID':
              return rcUser;
            case 'logIn':
              rcUser = call.arguments['appUserID'] as String;
              return {
                'customerInfo': customerJson(premium: premium),
                'created': false,
              };
            case 'logOut':
              rcUser = r'$RCAnonymousID:next';
              return customerJson(premium: false, subscriptions: []);
            case 'getOfferings':
              return {'all': {}, 'current': null};
            case 'purchasePackage':
              purchaseCalls++;
              if (purchaseError != null) {
                throw PlatformException(code: purchaseError!);
              }
              return {
                'customerInfo': customerJson(),
                'transaction': {
                  'transactionIdentifier': 'tx-1',
                  'productIdentifier': 'lifetime',
                  'purchaseDate': '2026-10-01T00:00:00Z',
                },
              };
            case 'restorePurchases':
              restoreCalls++;
              return restoreResult == null
                  ? customerJson()
                  : await restoreResult!.future;
            default:
              return null;
          }
        });
    cubit = SubscriptionCubit(IapService(), profiles);
  });
  tearDown(() async {
    await cubit.close();
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('failed refresh preserves premium and does not persist false', () async {
    await cubit.init();
    expect(cubit.state.isPremium, isTrue);
    readFails = true;
    await cubit.refreshStatus();
    expect(cubit.state.isPremium, isTrue);
    expect(profiles.writes, isNot(contains(false)));
    expect(cubit.state.refreshStatus, LoadStatus.failure);
  });

  test('cancellation leaves no purchase error', () async {
    await cubit.init();
    purchaseError = '1';
    await cubit.purchase(package: lifetimePackage);
    expect(cubit.state.purchaseStatus, LoadStatus.initial);
    expect(cubit.state.errorMessage, isNull);
  });

  test('repeated restore invokes the store once', () async {
    await cubit.init();
    restoreResult = Completer();
    final first = cubit.restore();
    final second = cubit.restore();
    await Future<void>.delayed(Duration.zero);
    expect(restoreCalls, 1);
    restoreResult!.complete(customerJson());
    await Future.wait([first, second]);
  });

  test('profile failure does not leave initialization loading', () async {
    profiles.fail = true;
    await cubit.init();
    expect(cubit.state.isPremium, isTrue);
    expect(cubit.state.initStatus.isLoading, isFalse);
  });

  test('pending does not grant premium or report purchase failure', () async {
    premium = false;
    await cubit.init();
    purchaseError = '${PurchasesErrorCode.paymentPendingError.index}';
    await cubit.purchase(package: lifetimePackage);
    expect(cubit.state.purchaseOutcome, PurchaseOutcome.pending);
    expect(cubit.state.isPremium, isFalse);
    expect(cubit.state.isBusy, isFalse);
    expect(cubit.state.purchaseStatus, LoadStatus.initial);
    expect(profiles.writes, [false]);
  });

  test('store failures terminate loading and allow another attempt', () async {
    premium = false;
    await cubit.init();
    purchaseError = 'STORE_UNAVAILABLE';
    await cubit.purchase(package: lifetimePackage);
    expect(cubit.state.purchaseStatus, LoadStatus.failure);
    purchaseError = null;
    await cubit.purchase(package: lifetimePackage);
    expect(cubit.state.purchaseStatus, LoadStatus.success);
    expect(cubit.state.isPremium, isTrue);
    expect(purchaseCalls, 2);
  });

  test('profile sync failure cannot fail a completed purchase', () async {
    premium = false;
    await cubit.init();
    profiles.fail = true;
    await cubit.purchase(package: lifetimePackage);
    expect(cubit.state.purchaseStatus, LoadStatus.success);
    expect(cubit.state.isPremium, isTrue);
  });

  test('purchase is blocked while restore is in flight', () async {
    await cubit.init();
    restoreResult = Completer();
    final restore = cubit.restore();
    await cubit.purchase(package: lifetimePackage);
    expect(purchaseCalls, 0);
    restoreResult!.complete(customerJson());
    await restore;
  });

  test(
    'failed login clears old access and cannot purchase as the old user',
    () async {
      await cubit.setUser('user-a');
      expect(cubit.state.isPremium, isTrue);
      overrides['logIn'] = (_) async => throw PlatformException(code: '10');
      await cubit.setUser('user-b');
      expect(cubit.state.isPremium, isFalse);
      expect(cubit.state.isReady, isFalse);
      expect(profiles.users, ['user-a']);
      await cubit.purchase(package: lifetimePackage);
      expect(purchaseCalls, 0);
    },
  );

  test(
    'late login result cannot grant or mirror access to a new account',
    () async {
      final loginStarted = Completer<void>();
      final firstLogin = Completer<Map<String, dynamic>>();
      overrides['logIn'] = (call) async {
        final user = call.arguments['appUserID'] as String;
        if (user == 'user-a') {
          loginStarted.complete();
          return firstLogin.future;
        }
        rcUser = user;
        return {'customerInfo': customerJson(premium: false), 'created': false};
      };
      final a = cubit.setUser('user-a');
      await loginStarted.future;
      final b = cubit.setUser('user-b');
      expect(cubit.state.isPremium, isFalse);
      firstLogin.complete({'customerInfo': customerJson(), 'created': false});
      await Future.wait([a, b]);
      expect(cubit.state.isPremium, isFalse);
      expect(profiles.writes, [false]);
      expect(profiles.users, ['user-b']);
    },
  );

  test('late purchase is ignored after account changes', () async {
    premium = false;
    await cubit.setUser('user-a');
    final started = Completer<void>();
    final result = Completer<Map<String, dynamic>>();
    overrides['purchasePackage'] = (_) {
      started.complete();
      return result.future;
    };
    final purchase = cubit.purchase(package: lifetimePackage);
    await started.future;
    final switchUser = cubit.setUser('user-b');
    expect(cubit.state.isReady, isFalse);
    result.complete({
      'customerInfo': customerJson(),
      'transaction': {
        'transactionIdentifier': 'late-tx',
        'productIdentifier': 'lifetime',
        'purchaseDate': '2026-10-01T00:00:00Z',
      },
    });
    await Future.wait([purchase, switchUser]);
    expect(cubit.state.isPremium, isFalse);
    expect(cubit.state.purchaseStatus, LoadStatus.initial);
    expect(profiles.writes, [false, false]);
    expect(profiles.users, ['user-a', 'user-b']);
  });

  test('resume refreshes confirmed expiration', () async {
    await cubit.init();
    premium = false;
    cubit.didChangeAppLifecycleState(AppLifecycleState.resumed);
    await cubit.stream.firstWhere((state) => !state.isPremium);
    await cubit.refreshStatus();
    expect(cubit.state.isPremium, isFalse);
    expect(readCalls, greaterThan(1));
  });

  test(
    'listener rereads current identity instead of trusting stale event payload',
    () async {
      await cubit.setUser('user-b');
      final readsBefore = readCalls;
      final delivered = Completer<void>();
      // The old account's expired payload must not revoke the current account.
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .handlePlatformMessage(
            'purchases_flutter',
            const StandardMethodCodec().encodeMethodCall(
              MethodCall(
                'Purchases-CustomerInfoUpdated',
                customerJson(premium: false),
              ),
            ),
            (_) => delivered.complete(),
          );
      await delivered.future;
      await pumpEventQueue();
      expect(cubit.state.isPremium, isTrue);
      expect(readCalls, readsBefore + 1);
      expect(rcUser, 'user-b');
    },
  );

  test(
    'empty offerings reports retryable failure without revoking access',
    () async {
      await cubit.init();
      expect(cubit.state.initStatus, LoadStatus.failure);
      expect(cubit.state.isPremium, isTrue);
      expect(cubit.state.isReady, isTrue);
    },
  );

  test(
    'initial read failure recovers on app resume without a manual retry',
    () async {
      readFails = true;
      await cubit.init();
      expect(cubit.state.isReady, isFalse);
      readFails = false;
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await pumpEventQueue();
      expect(cubit.state.isReady, isTrue);
      expect(cubit.state.isPremium, isTrue);
    },
  );

  test('approval during offerings fetch triggers a trailing refresh', () async {
    premium = false;
    final fetching = Completer<void>();
    final offerings = Completer<Map<String, dynamic>>();
    overrides['getOfferings'] = (_) {
      if (!fetching.isCompleted) fetching.complete();
      return offerings.future;
    };
    final init = cubit.init();
    await fetching.future;
    premium = true;
    final delivered = Completer<void>();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
          'purchases_flutter',
          const StandardMethodCodec().encodeMethodCall(
            MethodCall('Purchases-CustomerInfoUpdated', customerJson()),
          ),
          (_) => delivered.complete(),
        );
    await delivered.future;
    offerings.complete({'all': {}, 'current': null});
    await init;
    await pumpEventQueue();
    expect(cubit.state.isPremium, isTrue);
    expect(readCalls, 2);
  });
}
