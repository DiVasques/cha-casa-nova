import 'package:cha_casa_nova/repository/models/cart_item.dart';
import 'package:cha_casa_nova/repository/models/item.dart';
import 'package:cha_casa_nova/services/models/result.dart';
import 'package:cha_casa_nova/ui/controllers/base_controller.dart';
import 'package:cha_casa_nova/ui/controllers/shop_controller.dart';
import 'package:cha_casa_nova/ui/utils/app_colors.dart';
import 'package:cha_casa_nova/ui/widgets/base_scaffold.dart';
import 'package:cha_casa_nova/ui/widgets/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_selector/number_selector.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  final String email;
  final String pixCode =
      '00020126360014BR.GOV.BCB.PIX0114+55219805189005204000053039865802BR5913Diogo Vasques6014Rio de Janeiro62070503***630416F8';
  const ShopPage({Key? key, required this.email}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final Map<String, int> _cartItemSelectedValues = <String, int>{};
  final GlobalKey _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShopController>(
      create: (_) => ShopController(),
      child: Consumer<ShopController>(
        builder: (BuildContext context, ShopController shopController, _) {
          return BaseScaffold(
            key: _scaffoldKey,
            body: Column(
              mainAxisAlignment:
                  shopController.state != ViewState.idle ? MainAxisAlignment.center : MainAxisAlignment.start,
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
                  height: 20,
                ),
                Text(
                  'Como funciona?',
                  style: TextStyle(
                    color: AppColors.appDarkGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Escolha os pedacinhos que você quer dar, e, ao finalizar a escolha, faça o Pix e clique em Finalizar.',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'As informações do Pix estão no final da página.',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Não esqueça de nos enviar o comprovante!',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                ..._buildMainBody(shopController),
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

  List<Widget> _buildMainBody(ShopController shopController) {
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

    List<Widget> mainBodySections = <Widget>[];
    mainBodySections.addAll(_buildLinearProgressIndicators(shopController));
    mainBodySections.add(const SizedBox(height: 20));
    mainBodySections.addAll(_buildItemSelectors(shopController));
    mainBodySections.add(const SizedBox(height: 20));
    mainBodySections.add(_buildCartSection(shopController));
    mainBodySections.add(const SizedBox(height: 20));
    return mainBodySections;
  }

  List<Widget> _buildLinearProgressIndicators(ShopController shopController) {
    List<Widget> itemsProgressIndicators = <Widget>[];
    itemsProgressIndicators.add(
      Text(
        'Andamento',
        style: TextStyle(
          color: AppColors.appDarkGreen,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
    for (Item item in shopController.items) {
      double progressValue = (item.totalPieces - item.availablePieces) / item.totalPieces;
      Widget itemProgressIndicator = Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 5,
            child: LinearProgressIndicator(
              value: progressValue,
            ),
          ),
        ],
      );
      itemsProgressIndicators.add(itemProgressIndicator);
      itemsProgressIndicators.add(const SizedBox(height: 10));
    }
    return itemsProgressIndicators;
  }

  List<Widget> _buildItemSelectors(ShopController shopController) {
    List<Widget> itemsQuantitySelectors = <Widget>[];
    for (Item item in shopController.items) {
      _cartItemSelectedValues[item.id] = _cartItemSelectedValues[item.id] ??= 0;
      List<Widget> itemDetailsAndSelectorWidgets = <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'R\$${item.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text.rich(
              style: const TextStyle(
                fontSize: 12,
              ),
              TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Pedacinho:',
                  ),
                  TextSpan(
                    text: ' R\$${item.piecePrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text.rich(
              style: const TextStyle(
                fontSize: 12,
              ),
              TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Quantidade restante:',
                  ),
                  TextSpan(
                    text: ' ${item.availablePieces}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        NumberSelector(
          incrementTooltip: 'Adicionar',
          decrementTooltip: 'Remover',
          borderRadius: 10,
          contentPadding: 10,
          incrementIcon: Icons.add,
          decrementIcon: Icons.remove,
          current: _cartItemSelectedValues[item.id]!,
          min: 0,
          width: 200,
          max: item.availablePieces,
          showSuffix: false,
          showMinMax: false,
          hasCenteredText: true,
          onUpdate: (int newValue) {
            shopController.addToCart(item, newValue);
            setState(() {
              _cartItemSelectedValues[item.id] = newValue;
            });
          },
        )
      ];
      double screenWidth = MediaQuery.of(context).size.width;
      Widget itemQuantitySelectorColumn = Align(
        alignment: Alignment.centerLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: itemDetailsAndSelectorWidgets),
      );
      Widget itemQuantitySelectorFlex = Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: itemDetailsAndSelectorWidgets);
      itemsQuantitySelectors.add(screenWidth > 500 ? itemQuantitySelectorFlex : itemQuantitySelectorColumn);
      itemsQuantitySelectors.add(const SizedBox(height: 10));
    }
    return itemsQuantitySelectors;
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
      SelectableText(
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
      Text.rich(
        TextSpan(
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
      Text.rich(
        TextSpan(
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

  Widget _buildCartSection(ShopController shopController) {
    List<Widget> cartItemsTiles = <Widget>[];
    for (CartItem item in shopController.cartItems) {
      Widget cartItemTile = ListTile(
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text('Quantidade: ${item.quantity}'),
        visualDensity: VisualDensity.compact,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'R\$${(item.quantity * item.piecePrice).toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
                onPressed: () {
                  shopController.removeFromCart(item.id);
                  setState(() {
                    _cartItemSelectedValues[item.id] = 0;
                  });
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      );
      cartItemsTiles.add(cartItemTile);
      cartItemsTiles.add(const SizedBox(height: 10));
    }
    if (shopController.cartItems.isNotEmpty) {
      cartItemsTiles.insert(
        0,
        Text(
          'Resumo',
          style: TextStyle(
            color: AppColors.appDarkGreen,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
      cartItemsTiles.add(
        ListTile(
          title: Text(
            'Total',
            style: TextStyle(
              color: AppColors.appDarkGreen,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          trailing: Text(
            'R\$${(shopController.cartItems.fold(
              0,
              (int totalPrice, CartItem item) => totalPrice + (item.piecePrice * item.quantity).round(),
            )).toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
      cartItemsTiles.add(
        IconTextButton(
          icon: Icons.shopping_bag_outlined,
          text: 'Finalizar',
          dense: true,
          onPressed: () {
            shopController.confirmPurchase(email: widget.email).then(
              (Result result) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 3),
                    content: Text(result.status ? 'Escolhas confirmadas com sucesso.' : 'Erro ao confirmar escolhas.'),
                  ),
                );
                setState(() {
                  _cartItemSelectedValues.clear();
                  shopController.getItems();
                });
              },
            );
          },
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: cartItemsTiles,
    );
  }
}
