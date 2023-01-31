import 'package:cha_casa_nova/services/models/auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  static String failedToCreateUserCode = 'ERROR_FAILED_TO_CREATE_USER';
  static String failedToCreateUserMessage = 'Falha ao criar usuário. Codigo: ';

  static firebase_auth.User? isUserAuthenticated() {
    firebase_auth.User? firebaseUser =
        firebase_auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    return firebaseUser;
  }

  static Future<AuthResult> googleSingIn() async {
    AuthResult authResult = AuthResult(status: true);

    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider.addScope('https://www.googleapis.com/auth/userinfo.email');
      googleProvider
          .addScope('https://www.googleapis.com/auth/userinfo.profile');
      googleProvider.setCustomParameters(
          <dynamic, dynamic>{'login_hint': 'user@example.com'});

      authResult.userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } on FirebaseException catch (error) {
      authResult.errorCode = error.code;
      authResult.errorMessage = error.message;
      authResult.status = false;
    } catch (error) {
      authResult.errorCode = '503';
      authResult.errorMessage = error.toString();
      authResult.status = false;
    }

    return authResult;
  }

  static Future<void> userLogout() async {
    await firebase_auth.FirebaseAuth.instance.signOut();
  }
}
