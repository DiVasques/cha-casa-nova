import 'package:cha_casa_nova/services/authentication_services.dart';
import 'package:cha_casa_nova/services/models/auth_result.dart';
import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends BaseController {
  LoginController();

  Future<AuthResult> googleSignIn() async {
    setState(ViewState.busy);
    AuthResult authResult = await AuthenticationServices.googleSingIn();

    if (!authResult.status) {
      setState(ViewState.error);
      return authResult;
    }
    return authResult;
  }

  User? isUserAuthenticated() {
    return AuthenticationServices.isUserAuthenticated();
  }
}
