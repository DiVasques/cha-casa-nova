import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends BaseController {
  final UserCredential userCredential;
  HomeController({required this.userCredential});
}
