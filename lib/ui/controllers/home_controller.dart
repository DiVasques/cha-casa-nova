import 'package:cha_casa_nova/repository/home_repository.dart';
import 'package:cha_casa_nova/services/authentication_services.dart';
import 'package:cha_casa_nova/services/models/result.dart';
import 'package:cha_casa_nova/repository/models/user.dart';
import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class HomeController extends BaseController {
  final firebase_auth.User firebaseUser;
  HomeController({required this.firebaseUser}) {
    setState(ViewState.busy);
    getUser();
  }

  final HomeRepository _homeRepository = HomeRepository();
  User get user => _homeRepository.user;
  set userConfirmPresence(bool confirmed) {
    _homeRepository.user.confirmed = confirmed;
    notifyListeners();
  }

  Future<void> getUser() async {
    setState(ViewState.busy);
    Result result = await _homeRepository.getUser(
      email: firebaseUser.email!,
      name: firebaseUser.displayName!,
    );

    if (result.status) {
      setState(ViewState.idle);
    } else {
      setErrorMessage(result.errorMessage ?? '');
      setState(ViewState.error);
    }
  }

  Future<Result> confirmPresence(bool confirmed) async {
    Result result = await _homeRepository.confirmPresence(
      email: firebaseUser.email!,
      confirmed: !confirmed,
    );

    if (result.status) {
      userConfirmPresence = !confirmed;
    } else {
      setErrorMessage(result.errorMessage ?? '');
    }
    return result;
  }

  Future<Result> signOut() async {
    setState(ViewState.busy);
    Result result = Result(status: true);
    try {
      await AuthenticationServices.userLogout();
      setState(ViewState.idle);
      return result;
    } on FirebaseException catch (error) {
      setState(ViewState.error);
      result.errorCode = error.code;
      result.errorMessage = error.message;
      result.status = false;
      return result;
    } catch (error) {
      setState(ViewState.error);
      result.errorCode = '503';
      result.errorMessage = error.toString();
      result.status = false;
      return result;
    }
  }
}
