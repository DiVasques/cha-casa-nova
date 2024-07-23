import 'package:cha_casa_nova/repository/models/item.dart';
import 'package:cha_casa_nova/services/firestore_handler.dart';
import 'package:cha_casa_nova/services/models/result.dart';
import 'package:cha_casa_nova/services/utils/database_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopRepository {
  List<Item> items = <Item>[];

  Future<Result> getItems() async {
    Result result = Result(status: true);

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
}
