import 'package:cha_casa_nova/ui/views/home.dart';
import 'package:flutter/material.dart';

class GenericRouter {
  static const String homeRoute = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case homeRoute:
        builder = (BuildContext _) =>
            Home(email: settings.arguments as String? ?? 'teste@teste.com');
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
