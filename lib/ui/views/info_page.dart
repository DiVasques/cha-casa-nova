import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:cha_casa_nova/ui/widgets/base_scaffold.dart';
import 'package:cha_casa_nova/ui/widgets/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoPage extends StatelessWidget {
  final bool authenticated;
  final GlobalKey _scaffoldkey = GlobalKey();
  InfoPage({Key? key, required this.authenticated}) : super(key: key);
  final GoogleMapsPlugin _googleMapsPlugin = GoogleMapsPlugin();

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
                              text: 'Necessário:',
                              style: TextStyle(
                                color: AppColors.appDarkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' Trazer sua bebida e copo ♥',
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
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 500, maxWidth: 500),
                    child: _googleMapsPlugin.buildViewWithConfiguration(
                      2243,
                      (int id) {},
                      mapConfiguration: const MapConfiguration(
                        compassEnabled: true,
                        mapToolbarEnabled: true,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                      ),
                      mapObjects: MapObjects(
                        markers: <Marker>{
                          const Marker(
                            infoWindow: InfoWindow(
                              title: 'Casa Diogo e Bebel',
                              snippet: 'Rua Lincoln Neves Pinto, 140',
                            ),
                            markerId: MarkerId('home'),
                            position: LatLng(
                              -22.916805367375932,
                              -43.556920343049455,
                            ),
                          )
                        },
                      ),
                      widgetConfiguration: const MapWidgetConfiguration(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            -22.916805367375932,
                            -43.556920343049455,
                          ),
                          zoom: 20,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconTextButton(
                    icon: FontAwesomeIcons.mapLocation,
                    text: 'Abrir no Maps',
                    onPressed: () {
                      launchUrlString('https://goo.gl/maps/jfx6LxSCzttXQ9uz5');
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
              ));
        },
      ),
    );
  }
}
