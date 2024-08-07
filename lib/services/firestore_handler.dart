import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHandler {
  ///Retorna documentos [List[DocumentSnapshot]] da coleção selecionada
  static Future<QuerySnapshot<Map<String, dynamic>>> getDocuments({
    required String collection,
  }) async {
    QuerySnapshot<Map<String, dynamic>> document =
        await FirebaseFirestore.instance.collection(collection).get();
    return document;
  }

  ///Retorna documento [DocumentSnapshot] da coleção selecionada
  static Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String id,
    required String collection,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await FirebaseFirestore.instance.collection(collection).doc(id).get();
    return document;
  }

  ///Adiciona documento ao banco de dados
  static Future<void> addDocumentNewId({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    await FirebaseFirestore.instance.collection(collection).add(data);
  }

  ///Adiciona documento ao banco de dados
  static Future<void> addDocument({
    required String id,
    required String collection,
    required Map<String, dynamic> params,
  }) async {
    await FirebaseFirestore.instance.collection(collection).doc(id).set(params);
  }

  ///Atualiza documento ao banco de dados
  static Future<void> updateDocument({
    required String id,
    required String collection,
    required Map<String, dynamic> params,
  }) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .update(params);
  }

  ///Adiciona item a um array de documento do banco de dados
  static Future<void> addOnArray({
    required String id,
    required String collection,
    required String field,
    required dynamic param,
  }) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .update(<String, Object?>{
      field: FieldValue.arrayUnion(<dynamic>[param])
    });
  }

  ///Remove item de um array de documento do banco de dados
  static Future<void> deleteFromArray({
    required String identifier,
    required String collection,
    required String field,
    required dynamic param,
  }) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(identifier)
        .update(<String, Object?>{
      field: FieldValue.arrayRemove(<dynamic>[param])
    });
  }
}
