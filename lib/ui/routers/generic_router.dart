import 'package:cha_casa_nova/ui/views/home_page.dart';
import 'package:cha_casa_nova/ui/views/info_page.dart';
import 'package:cha_casa_nova/ui/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GenericRouter {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String infoRoute = '/info';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case loginRoute:
        builder = (BuildContext _) => LoginPage();
        break;
      case homeRoute:
        builder = (BuildContext _) =>
            HomePage(userCredential: settings.arguments as UserCredential);
        break;
      case infoRoute:
        builder = (BuildContext _) =>
            InfoPage(authenticated: settings.arguments as bool);
        break;
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('Rota não definida para ${settings.name}'),
              ),
            );
          },
        );
    }
    return MaterialPageRoute<dynamic>(builder: builder, settings: settings);
  }
}
