import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twinfix/core/services/iap_service.dart';
import '../../support/iap_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('purchases_flutter');
  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    dotenv.loadFromString(envString: 'REVENUECAT_ANDROID_KEY=goog_test');
  });
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('a failed entitlement read is not evidence of no premium', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          if (call.method == 'getCustomerInfo') {
            throw PlatformException(code: '10', message: 'Network unavailable');
          }
          return null;
        });
    await expectLater(
      IapService().checkPremium(),
      throwsA(isA<PlatformException>()),
    );
  });

  test(
    'monthly remains visible when lifetime unlocks the same entitlement',
    () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (call) async =>
                call.method == 'getCustomerInfo' ? customerJson() : null,
          );
      expect(
        await IapService().getActiveProductIdentifiers(),
        containsAll(['monthly', 'lifetime']),
      );
    },
  );

  test(
    'concurrent initialization configures RevenueCat exactly once',
    () async {
      var configurations = 0;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
            if (call.method == 'setupPurchases') configurations++;
            return null;
          });
      final service = IapService();
      await Future.wait([service.init(), service.init(), service.init()]);
      expect(configurations, 1);
    },
  );
}
