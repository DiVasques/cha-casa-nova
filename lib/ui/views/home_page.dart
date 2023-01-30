import 'package:cha_casa_nova/ui/controllers/home_controller.dart';
import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:cha_casa_nova/ui/widgets/base_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final UserCredential userCredential;
  final GlobalKey _scaffoldkey = GlobalKey();
  HomePage({Key? key, required this.userCredential}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(userCredential: userCredential),
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController homeController, _) {
          return BaseScaffold(
              key: _scaffoldkey,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Home',
                    style: TextStyle(
                      color: AppColors.appDarkGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    userCredential.user!.email!,
                    style: TextStyle(
                      color: AppColors.appDarkGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
