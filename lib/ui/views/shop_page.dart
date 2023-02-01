import 'package:cha_casa_nova/repository/models/item.dart';
import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:cha_casa_nova/ui/controllers/shop_controller.dart';
import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:cha_casa_nova/ui/widgets/base_scaffold.dart';
import 'package:cha_casa_nova/ui/widgets/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ShopPage extends StatefulWidget {
  final bool authenticated;
  final String pixCode =
      '00020126360014BR.GOV.BCB.PIX0114+55219805189005204000053039865802BR5913Diogo Vasques6014Rio de Janeiro62070503***630416F8';
  const ShopPage({Key? key, required this.authenticated}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // final bool authenticated;
  final GlobalKey _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShopController>(
      create: (_) => ShopController(),
      child: Consumer<ShopController>(
        builder: (BuildContext context, ShopController shopController, _) {
          return BaseScaffold(
            key: _scaffoldkey,
            body: Column(
              mainAxisAlignment: shopController.state != ViewState.idle
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Listinha',
                  style: TextStyle(
                    color: AppColors.appDarkGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ..._buildSliders(shopController),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Anota os pedacinhos que você quer, soma e me manda junto com o comprovante do pix',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Não esqueça de nos enviar quais pedacinhos você escolheu para atualizarmos a lista',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Era pra isso ser automático, mas não deu tempo de fazer. Foi mal 🤪',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
                ..._buildPixInformation(),
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

  List<Widget> _buildSliders(ShopController shopController) {
    if (shopController.state == ViewState.busy) {
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
    if (shopController.state == ViewState.error) {
      return <Widget>[
        const SizedBox(
          height: 10,
        ),
        Text(
          'Deu ruim na hora de ler os itens. Tenta de novo\n${shopController.errorMessage}',
          style: TextStyle(
            color: AppColors.appErrorRed,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        IconButton(
          onPressed: () {
            shopController.getItems();
          },
          icon: Icon(
            Icons.replay,
            color: AppColors.appDarkGreen,
          ),
        )
      ];
    }

    List<Widget> itemsSliders = <Widget>[];
    for (Item item in shopController.items) {
      double value = (item.totalPieces - item.availablePieces).toDouble();
      Widget itemSlider = Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('R\$${item.totalPrice.toStringAsFixed(2)}')
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 6,
            child: SfSliderTheme(
              data: SfSliderThemeData(
                disabledActiveTrackColor: AppColors.appDarkGreen,
                disabledActiveTickColor: AppColors.appDarkGreen,
                disabledInactiveTickColor: AppColors.appLightGreen,
                disabledActiveMinorTickColor: AppColors.appDarkGreen,
                disabledInactiveMinorTickColor: AppColors.appLightGreen,
                disabledThumbColor: AppColors.appDarkGreen,
              ),
              child: SfSlider(
                value: value,
                onChanged: null,
                interval: _getSliderInterval(item.totalPieces),
                showLabels: true,
                min: 0,
                max: item.totalPieces.toDouble(),
              ),
            ),
          ),
        ],
      );
      itemsSliders.add(itemSlider);
      itemsSliders.add(const SizedBox(height: 10));
    }
    return itemsSliders;
  }

  double _getSliderInterval(int totalPieces) {
    if (totalPieces % 5 == 0) {
      return totalPieces / 5;
    }
    if (totalPieces % 4 == 0) {
      return totalPieces / 4;
    }
    if (totalPieces % 3 == 0) {
      return totalPieces / 3;
    }
    if (totalPieces % 2 == 0) {
      return totalPieces / 2;
    }
    return totalPieces.toDouble();
  }

  List<Widget> _buildPixInformation() {
    return <Widget>[
      Image.asset('assets/images/qrcode_pix.png'),
      const SizedBox(height: 20),
      Text(
        'Pix Copia e Cola',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.appDarkGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        widget.pixCode,
        textAlign: TextAlign.center,
      ),
      IconButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: widget.pixCode)).then(
            (void result) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
                content: Text('Pix copiado.'),
              ),
            ),
          );
        },
        icon: Icon(
          Icons.copy,
          color: AppColors.appDarkGreen,
        ),
      ),
      const SizedBox(height: 20),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Beneficiário:',
              style: TextStyle(
                color: AppColors.appDarkGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(
              text: ' Diogo Vasques',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Chave Pix:',
              style: TextStyle(
                color: AppColors.appDarkGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(
              text: ' (21) 980518900',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
