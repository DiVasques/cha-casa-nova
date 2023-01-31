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
