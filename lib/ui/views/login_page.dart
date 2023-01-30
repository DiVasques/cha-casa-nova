import 'package:cha_casa_nova/services/models/auth_result.dart';
import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:cha_casa_nova/ui/controllers/login_controller.dart';
import 'package:cha_casa_nova/ui/routers/generic_router.dart';
import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:cha_casa_nova/ui/widgets/base_scaffold.dart';
import 'package:cha_casa_nova/ui/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey _scaffoldkey = GlobalKey();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>(
      create: (_) => LoginController(),
      child: Consumer<LoginController>(
        builder: (BuildContext context, LoginController loginController, _) {
          return BaseScaffold(
              key: _scaffoldkey,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Entrar',
                    style: TextStyle(
                      color: AppColors.appDarkGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ..._buildButtons(loginController, context),
                ],
              ));
        },
      ),
    );
  }

  List<Widget> _buildButtons(
      LoginController loginController, BuildContext context) {
    if (loginController.state == ViewState.busy) {
      return <Widget>[
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.appDarkGreen),
          ),
        ),
      ];
    }

    return <Widget>[
      SignInButton(
        icon: FontAwesomeIcons.google,
        text: 'Entrar com Google',
        onPressed: () {
          debugPrint('google');
          loginController.googleSignIn().then((AuthResult result) {
            if (result.status) {
              Navigator.pushNamedAndRemoveUntil(context,
                  GenericRouter.homeRoute, (Route<dynamic> route) => false,
                  arguments: result.userCredential);
            }
          });
        },
      ),
      const SizedBox(
        height: 20,
      ),
      SignInButton(
        icon: FontAwesomeIcons.facebook,
        text: 'Entrar com Facebook',
        onPressed: () {
          debugPrint('facebook');
        },
      ),
      const SizedBox(
        height: 20,
      ),
      loginController.state == ViewState.error
          ? Text(
              'Deu ruim no login. Tenta de novo',
              style: TextStyle(
                color: AppColors.appErrorRed,
              ),
            )
          : Container(),
    ];
  }
}
