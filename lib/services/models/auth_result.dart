import 'package:cha_casa_nova/services/models/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthResult extends Result {
  late UserCredential? userCredential;
  AuthResult(
      {required super.status,
      super.errorCode,
      super.errorMessage,
      this.userCredential});
}
