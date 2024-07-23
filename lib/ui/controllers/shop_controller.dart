import 'package:cha_casa_nova/repository/models/cart_item.dart';
import 'package:cha_casa_nova/repository/models/item.dart';
import 'package:cha_casa_nova/repository/shop_repository.dart';
import 'package:cha_casa_nova/services/models/result.dart';
import 'package:cha_casa_nova/ui/controllers/base_controller.dart';

class ShopController extends BaseController {
  final ShopRepository _shopRepository = ShopRepository();
  List<Item> get items => _shopRepository.items;
  ShopController() {
    setState(ViewState.busy);
    getItems();
  }

  final List<CartItem> _cartItems = List<CartItem>.empty(growable: true);
  List<CartItem> get cartItems => _cartItems;
  void addToCart(Item item, double newValue) {
    removeFromCart(item.id);
    int quantity = (newValue - (item.totalPieces - item.availablePieces)).round();
    if (quantity != 0) {
      cartItems.add(CartItem(
        id: item.id,
        name: item.name,
        piecePrice: item.piecePrice,
        quantity: quantity,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItems.removeWhere((CartItem item) => item.id == id);
    notifyListeners();
  }

  final Map<String, double> _sliderValues = <String, double>{};
  Map<String, double> get sliderValues => _sliderValues;
  void updateSliderValue(String id, double newValue){
    _sliderValues[id] = newValue;
    notifyListeners();
  }

  Future<void> getItems() async {
    setState(ViewState.busy);
    Result result = await _shopRepository.getItems();

    if (result.status) {
      setState(ViewState.idle);
      return;
    }
    setErrorMessage(result.errorMessage ?? '');
    setState(ViewState.error);
  }
}
