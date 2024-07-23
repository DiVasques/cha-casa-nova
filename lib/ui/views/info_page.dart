import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:cha_casa_nova/ui/widgets/base_scaffold.dart';
import 'package:cha_casa_nova/ui/widgets/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoPage extends StatelessWidget {
  final bool authenticated;
  final GlobalKey _scaffoldkey = GlobalKey();
  InfoPage({Key? key, required this.authenticated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseController>(
      create: (_) => BaseController(),
      child: Consumer<BaseController>(
        builder: (BuildContext context, BaseController baseController, _) {
          return BaseScaffold(
            key: _scaffoldkey,
            body: Column(
              mainAxisAlignment:
                  baseController.state != ViewState.idle ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Informações',
                  style: TextStyle(
                    color: AppColors.appDarkGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Entrega das Chaves:',
                            style: TextStyle(
                              color: AppColors.appDarkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' 27 de Julho',
                            style: TextStyle(
                              color: AppColors.appDarkGreen,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Endereço:',
                            style: TextStyle(
                              color: AppColors.appDarkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '',
                            style: TextStyle(
                              color: AppColors.appDarkGreen,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                IconTextButton(
                  icon: FontAwesomeIcons.mapLocation,
                  text: 'Abrir no Maps',
                  onPressed: () {
                    launchUrlString('');
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                IconTextButton(
                  icon: Icons.arrow_back,
                  text: 'Voltar',
                  dense: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
