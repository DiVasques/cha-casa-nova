import 'package:cha_casa_nova/ui/controllers/home_controller.dart';
import 'package:cha_casa_nova/ui/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
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
                  Text(homeController.email),
                ],
              ));
        },
      ),
    );
  }
}
