import 'package:cha_casa_nova/repository/home_repository.dart';
import 'package:cha_casa_nova/services/authentication_services.dart';
import 'package:cha_casa_nova/services/models/result.dart';
import 'package:cha_casa_nova/repository/models/user.dart';
import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';

class HomeController extends BaseController {
  final firebase_auth.UserCredential userCredential;
  HomeController({required this.userCredential}) {
    setState(ViewState.busy);
    getUser();
  }

  final HomeRepository _homeRepository = HomeRepository();
  User get user => _homeRepository.user;

  Future<void> getUser() async {
    debugPrint('$runtimeType.state: getUser');
    setState(ViewState.busy);
    Result result = await _homeRepository.getUser(
      email: userCredential.user!.email!,
      name: userCredential.user!.displayName!,
    );

    if (result.status) {
      setState(ViewState.idle);
    } else {
      setErrorMessage(result.errorMessage ?? '');
      setState(ViewState.error);
    }
  }

  Future<Result> signOut() async {
    setState(ViewState.busy);
    Result result = Result(status: true);
    try {
      await AuthenticationServices.userLogout();
      setState(ViewState.idle);
      return result;
    } on FirebaseException catch (error) {
      debugPrint('firebase error create user: $error');
      setState(ViewState.error);
      result.errorCode = error.code;
      result.errorMessage = error.message;
      result.status = false;
      return result;
    } catch (error) {
      debugPrint('generic error create user: $error');
      setState(ViewState.error);
      result.errorCode = '503';
      result.errorMessage = error.toString();
      result.status = false;
      return result;
    }
  }
}
