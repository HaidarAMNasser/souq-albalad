import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future<String> signInAndGetIdToken() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        throw Exception('Google sign-in aborted');
      }
      final authentication = await account.authentication;
      final idToken = authentication.idToken;

      if (idToken == null) {
        throw Exception('Failed to get idToken');
      }
      return idToken;
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }
}
