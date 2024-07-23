import 'package:carousel_slider/carousel_slider.dart';
import 'package:cha_casa_nova/services/models/result.dart';
import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:cha_casa_nova/ui/controllers/home_controller.dart';
import 'package:cha_casa_nova/ui/routers/generic_router.dart';
import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:cha_casa_nova/ui/widgets/base_scaffold.dart';
import 'package:cha_casa_nova/ui/widgets/icon_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final firebase_auth.User firebaseUser;
  final GlobalKey _scaffoldkey = GlobalKey();
  HomePage({Key? key, required this.firebaseUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(firebaseUser: firebaseUser),
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController homeController, _) {
          return BaseScaffold(
              key: _scaffoldkey,
              body: Column(
                mainAxisAlignment:
                    homeController.state != ViewState.idle ? MainAxisAlignment.center : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ..._buildHomeBody(homeController, context),
                ],
              ));
        },
      ),
    );
  }

  List<Widget> _buildHomeBody(HomeController homeController, BuildContext context) {
    if (homeController.state == ViewState.busy) {
      return <Widget>[
        SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.appDarkGreen),
          ),
        ),
      ];
    }
    if (homeController.state == ViewState.error) {
      return <Widget>[
        const SizedBox(
          height: 10,
        ),
        Text(
          'Deu ruim na hora de pegar teus dados. Tenta de novo\n${homeController.errorMessage}',
          style: TextStyle(
            color: AppColors.appErrorRed,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        IconButton(
          onPressed: () {
            homeController.getUser();
          },
          icon: Icon(
            Icons.replay,
            color: AppColors.appDarkGreen,
          ),
        )
      ];
    }

    return <Widget>[
      Text(
        'Olá, ${homeController.user.name.split(' ')[0]}!!!',
        style: TextStyle(
          color: AppColors.appDarkGreen,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      Text(
        'Você foi convidado à contribuir com a nossa listinha',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.appDarkGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      IconTextButton(
        icon: FontAwesomeIcons.basketShopping,
        text: 'Listinha',
        onPressed: () {
          Navigator.pushNamed(context, GenericRouter.shopRoute, arguments: homeController.user.email);
        },
      ),
      const SizedBox(
        height: 50,
      ),
      Container(
        alignment: Alignment.center,
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1.5,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
          ),
          items: <Widget>[
            ClipOval(
              child: Image.asset(
                'assets/images/us_square_small.jpg',
                filterQuality: FilterQuality.medium,
              ),
            ),
            ClipOval(
              child: Image.asset(
                'assets/images/us_square_small_2.jpg',
                filterQuality: FilterQuality.medium,
              ),
            ),
            ClipOval(
              child: Image.asset(
                'assets/images/us_square_small_3.jpg',
                filterQuality: FilterQuality.medium,
              ),
            ),
            ClipOval(
              child: Image.asset(
                'assets/images/us_square_small_4.jpg',
                filterQuality: FilterQuality.medium,
              ),
            ),
            ClipOval(
              child: Image.asset(
                'assets/images/us_square_small_5.jpg',
                filterQuality: FilterQuality.medium,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 50,
      ),
      IconTextButton(
        icon: Icons.exit_to_app,
        text: 'Sair',
        dense: true,
        onPressed: () {
          homeController.signOut().then(
            (Result result) {
              if (result.status) {
                Navigator.pushNamedAndRemoveUntil(context, GenericRouter.loginRoute, (Route<dynamic> route) => false);
              }
            },
          );
        },
      ),
    ];
  }
}
