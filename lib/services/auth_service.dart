import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:traveller/main.dart';
import 'package:traveller/models/user.dart';

abstract class BaseAuthService {
  Future<String> loginWithEmailPassword({
    required Map<String, dynamic> creds,
  });
  Future<String?> signUpWithEmail({
    required Map<String, dynamic> creds,
  });

  Future<User> getUser();

  Future<void> signOut();
  Future<void> forgetPassword({required String email});
}

final Provider<AuthService> authServiceProvider = Provider<AuthService>(
  (ProviderRef<AuthService> ref) => AuthService(ref),
);

final googleSignInProvider = Provider((ref) => GoogleSignIn());

class AuthService extends BaseAuthService {
  AuthService(this.ref);
  final Ref ref;

  @override
  Future<String> signUpWithEmail({
    required Map<String, dynamic> creds,
  }) async {
    try {
      final response = await ref.read(httpClientProvider).post(
            '/register',
            data: creds,
          );
      return response.data.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUser() async {
    final response = await ref.read(httpClientProvider).get('/user');
    final user = User.fromJson(response.data);
    return user;
  }

  @override
  Future<void> signOut() async {
    await ref.read(httpClientProvider).get('/user/revoke');
  }

  @override
  Future<String> loginWithEmailPassword({
    required Map<String, dynamic> creds,
  }) async {
    final response = await ref.read(httpClientProvider).post(
          '/sanctum/token',
          data: creds,
        );
    return response.data.toString();
  }

  @override
  Future<void> forgetPassword({required String email}) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }
}
