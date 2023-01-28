import 'package:cha_casa_nova/ui/controllers/home_controller.dart';
import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:cha_casa_nova/ui/widgets/base_scaffold.dart';
import 'package:cha_casa_nova/ui/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String email;
  final GlobalKey _scaffoldkey = GlobalKey();
  Home({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(email: email),
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController homeController, _) {
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
                  SignInButton(
                    icon: FontAwesomeIcons.google,
                    text: 'Entrar com Google',
                    onPressed: () {
                      debugPrint('google');
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
                ],
              ));
        },
      ),
    );
  }
}
