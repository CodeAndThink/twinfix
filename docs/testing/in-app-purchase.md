# In-app purchase verification

The app uses RevenueCat entitlement `twinfix_premium`. Its current offering must
contain Monthly and Lifetime packages. Access is determined from CustomerInfo;
Supabase `user_profiles.is_pro` is currently a client-maintained mirror.

## Automated checks

Use Flutter 3.41.6 / Dart 3.11.4 or a compatible SDK, and resolve the committed
lockfile with `flutter pub get --enforce-lockfile`.

Run the entire unit test suite without building unrelated OpenCV native assets:

```sh
FLUTTER_NATIVE_ASSETS=false FLUTTER_DART_DATA_ASSETS=true \
  flutter test --no-pub --no-test-assets --reporter expanded
flutter analyze --no-pub
```

The tests simulate the RevenueCat native channel and profile persistence. They
cover read failures, initialization deduplication, Monthly plus Lifetime,
cancellation, pending payments, store errors/retries, concurrent restore/purchase,
profile sync failure, failed login, stale login/purchase results, listener identity
safety, expiration on resume, recovery after an initial failure, and approval
while offerings are still loading. These tests do not charge a store account or
validate Apple/Google receipts end to end.

Provide the project's real `.env` configuration before building/running the app.
The filename must include the leading dot; it is excluded by `.gitignore`.
Do not commit credentials. Unit tests use synthetic configuration and do not
contact the RevenueCat or Supabase services.

## Sandbox/device checks

Run on both Android (Play internal testing/license tester) and iOS (Sandbox or
TestFlight) with the correct RevenueCat public SDK key for that platform.

| Scenario | Expected result |
| --- | --- |
| Launch with an existing signed-in subscriber | RevenueCat identifies the Supabase user before access is mirrored. |
| Buy Monthly or Lifetime | Store confirmation unlocks Premium; no second purchase starts while busy. |
| Cancel the store sheet | Loading closes without a purchase-error message. |
| Pending payment / Ask to Buy | Pending message, no premature Premium; approval updates access via listener/resume. |
| Restore valid purchases | Premium unlocks; repeated taps do not start duplicate restores. |
| Restore with no entitlement | No Premium is granted; restore feedback is displayed. |
| Buy Lifetime while Monthly remains active | Both products are recognized; cancellation guidance appears before the paywall closes. Buying Lifetime does not cancel Monthly. |
| Network error reading CustomerInfo | Previously confirmed access for the same in-memory identity remains; no false revocation is mirrored. |
| Network/configuration error during initial setup | Retry is available; resume retries even if the first read failed. |
| Empty/unavailable offering | Retry control appears; confirmed Premium is retained. |
| Sign out or switch A → B during a request/purchase | A's late result never grants B access or updates B's profile. |
| Refund or expiration | Once the SDK returns updated CustomerInfo, the app updates access and the profile mirror. |
| Supabase unavailable after a confirmed purchase | Purchase remains successful; mirroring is retried on a later refresh. |

CustomerInfo may be cached by the SDK. A callback signals that the app should
read the current identity, rather than trusting the callback's account. Repeated
callbacks with unchanged access do not initiate recursive refresh loops.

On a cold start with no successful SDK read, the app does not trust a cached
Supabase boolean to grant Premium. Anonymous purchase transfer/restore behavior
also depends on the RevenueCat project's restore settings and must be tested
with the actual project.

## Server-side follow-up

No Supabase SQL policies, Edge Functions, or RevenueCat webhook configuration are
present in this repository. This change guards the client mirror against account
races, but does **not** establish server-authoritative subscription access.

Before using `is_pro` to authorize backend features, verify deployed policies and
move subscription writes to a trusted server that verifies RevenueCat events or
queries RevenueCat. The deployed design must cover authenticated webhooks,
idempotency/out-of-order events, expiration/refund/transfer handling, and denying
client updates to the entitlement field. Also remove `is_pro` from generic client
profile merge/update payloads when migrating. Do not apply an unverified policy
change blindly: the current client mirror relies on the existing schema.

References: [CustomerInfo](https://www.revenuecat.com/docs/customers/customer-info),
[Entitlements](https://www.revenuecat.com/docs/getting-started/entitlements).
