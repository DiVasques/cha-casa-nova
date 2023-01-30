import 'package:cha_casa_nova/repository/models/user.dart';
import 'package:cha_casa_nova/services/firestore_handler.dart';
import 'package:cha_casa_nova/services/models/result.dart';
import 'package:cha_casa_nova/services/utils/database_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HomeRepository {
  late User user;

  Future<Result> getUser({required String email, required String name}) async {
    debugPrint('state: repository');
    Result result = Result(status: true);

    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirestoreHandler.getDocument(
        id: email,
        collection: DatabaseCollection.users,
      );
      if (!userSnapshot.exists) {
        Result createUserResult =
            await createUserInfo(email: email, name: name);
        if (!createUserResult.status) {
          result.status = false;
          result.errorCode = '404';
          result.errorMessage = 'Usuário não encontrado';
          return result;
        }
        userSnapshot = await FirestoreHandler.getDocument(
          id: email,
          collection: DatabaseCollection.users,
        );
      }
      debugPrint(userSnapshot.data().toString());
      user = User(
        name: userSnapshot.get('name'),
        email: userSnapshot.get('email'),
      );
    } on FirebaseException catch (error) {
      result.errorCode = error.code;
      result.errorMessage = error.message;
      result.status = false;
    } catch (error) {
      result.errorCode = '999';
      result.errorMessage = error.toString();
      result.status = false;
    }

    return result;
  }

  Future<Result> createUserInfo(
      {required String email, required String name}) async {
    Result result = Result(status: true);
    try {
      await FirestoreHandler.addDocument(
        id: email,
        collection: DatabaseCollection.users,
        params: <String, dynamic>{
          'name': name,
          'email': email,
        },
      );
      return result;
    } on FirebaseException catch (error) {
      debugPrint('firebase error create user: $error');
      result.errorCode = error.code;
      result.errorMessage = error.message;
      result.status = false;
      return result;
    } catch (error) {
      debugPrint('generic error create user: $error');
      result.errorCode = '503';
      result.errorMessage = error.toString();
      result.status = false;
      return result;
    }
  }
}