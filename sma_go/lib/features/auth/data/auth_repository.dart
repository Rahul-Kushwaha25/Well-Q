class AuthException implements Exception {
  const AuthException(this.message);

  final String message;
}

abstract interface class AuthRepository {
  /// Throws [AuthException] with a user-readable message on failure.
  Future<void> login({required String loginId, required String password});

  /// Throws [AuthException] when the OTP is wrong or expired.
  Future<void> verifyOtp({required String loginId, required String otp});

  Future<void> resendOtp({required String loginId});
}

/// Stand-in so the screens run end to end. Replace with the real API calls.
class FakeAuthRepository implements AuthRepository {
  const FakeAuthRepository();

  static const Duration _latency = Duration(milliseconds: 1000);

  @override
  Future<void> login({
    required String loginId,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
  }

  @override
  Future<void> verifyOtp({
    required String loginId,
    required String otp,
  }) async {
    await Future<void>.delayed(_latency);
  }

  @override
  Future<void> resendOtp({required String loginId}) async {
    await Future<void>.delayed(_latency);
  }
}
