import 'package:cha_casa_nova/ui/routers/generic_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cha_casa_nova/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChaDeCasaNova());
}

class ChaDeCasaNova extends StatelessWidget {
  const ChaDeCasaNova({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chá de Casa Nova',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: const MaterialColor(
          0xFF2D7565,
          <int, Color>{
            50: Color(0xFFaaf4e0),
            100: Color(0xFF7ec7b4),
            200: Color(0xFF61a997),
            300: Color(0xFF438b7a),
            400: Color(0xFF2D7565),
            500: Color(0xFF186555),
            600: Color(0xFF015848),
            700: Color(0xFF004d3f),
            800: Color(0xFF004436),
            900: Color(0xFF003225)
          },
        ),
      ),
      onGenerateRoute: GenericRouter.generateRoute,
      initialRoute: GenericRouter.loginRoute,
    );
  }
}
