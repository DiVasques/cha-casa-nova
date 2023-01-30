import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:cha_casa_nova/ui/widgets/base_scaffold.dart';
import 'package:cha_casa_nova/ui/widgets/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                mainAxisAlignment: baseController.state != ViewState.idle
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
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
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Data:',
                              style: TextStyle(
                                color: AppColors.appDarkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' 04 de Fevereiro, às 12:00h',
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
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Endereço:',
                              style: TextStyle(
                                color: AppColors.appDarkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' Rua Lincoln Neves Pinto, 140 - 23045-330',
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
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Regra Importante:',
                              style: TextStyle(
                                color: AppColors.appDarkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' NÃO MEXE COM O HENG. VOCÊ VAI PERDER UM PEDAÇO DO CORPO.',
                              style: TextStyle(
                                color: AppColors.appDarkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
              ));
        },
      ),
    );
  }
}
