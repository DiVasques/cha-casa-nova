import 'package:cha_casa_nova/repository/models/cart_item.dart';
import 'package:cha_casa_nova/repository/models/item.dart';
import 'package:cha_casa_nova/services/firestore_handler.dart';
import 'package:cha_casa_nova/services/models/result.dart';
import 'package:cha_casa_nova/services/utils/database_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopRepository {
  List<Item> items = <Item>[];

  Future<Result> getItems() async {
    Result result = Result(status: true);
    items = <Item>[];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirestoreHandler.getDocuments(
        collection: DatabaseCollection.items,
      );

      for (QueryDocumentSnapshot<Map<String, dynamic>> document in querySnapshot.docs) {
        Item item = Item(
          id: document.id,
          name: document.get('name'),
          totalPrice: document.get('totalPrice'),
          piecePrice: document.get('piecePrice'),
          totalPieces: document.get('totalPieces'),
          availablePieces: document.get('availablePieces'),
        );
        items.add(item);
      }
    } on FirebaseException catch (error) {
      result.errorCode = error.code;
      result.errorMessage = error.message;
      result.status = false;
    } catch (error) {
      result.errorCode = '503';
      result.errorMessage = error.toString();
      result.status = false;
    }
    items.sort((Item a, Item b) => a.name.compareTo(b.name));
    return result;
  }

  Future<Result> saveCartHistory({required String email, required List<CartItem> items}) async {
    Result result = Result(status: true);
    try {
      for (CartItem item in items) {
        DocumentSnapshot<Map<String, dynamic>> document =
            await FirestoreHandler.getDocument(id: item.id, collection: DatabaseCollection.items);
        if ((document.get('availablePieces') as int) < item.quantity) {
          throw Exception('Not enough available pieces (${item.quantity}) for ${item.name}');
        }
        await FirestoreHandler.updateDocument(
          id: item.id,
          collection: DatabaseCollection.items,
          params: <String, dynamic>{
            'availablePieces': FieldValue.increment(-item.quantity),
          },
        );
      }
      await FirestoreHandler.addDocumentNewId(
        collection: DatabaseCollection.shop,
        data: <String, dynamic>{
          'email': email,
          'items': items
              .map(
                (CartItem item) => <String, Object>{
                  'name': item.name,
                  'quantity': item.quantity,
                },
              )
              .toList()
        },
      );
      return result;
    } on FirebaseException catch (error) {
      result.errorCode = error.code;
      result.errorMessage = error.message;
      result.status = false;
      return result;
    } catch (error) {
      result.errorCode = '503';
      result.errorMessage = error.toString();
      result.status = false;
      return result;
    }
  }
}
