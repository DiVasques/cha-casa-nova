import 'package:cha_casa_nova/repository/models/user.dart';
import 'package:cha_casa_nova/services/firestore_handler.dart';
import 'package:cha_casa_nova/services/models/confirm_presence_recipient.dart';
import 'package:cha_casa_nova/services/models/result.dart';
import 'package:cha_casa_nova/services/utils/database_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRepository {
  late User user;

  Future<Result> getUser({required String email, required String name}) async {
    Result result = Result(status: true);

    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirestoreHandler.getDocument(
        id: email,
        collection: DatabaseCollection.users,
      );
      if (!userSnapshot.exists) {
        Result createUserResult = await createUserInfo(email: email, name: name);
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
      user = User(
        name: userSnapshot.get('name'),
        email: userSnapshot.get('email'),
        confirmed: userSnapshot.get('confirmed'),
        admin: userSnapshot.data()?['admin'],
        receivedConfirmationEmail: userSnapshot.data()?['receivedConfirmationEmail'],
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

  Future<List<ConfirmPresenceRecipient>> getUsersToConfirmPresence() async {
    List<ConfirmPresenceRecipient> users = <ConfirmPresenceRecipient>[];
    QuerySnapshot<Map<String, dynamic>> usersQuerySnapshot = await FirestoreHandler.getDocuments(
      collection: DatabaseCollection.users,
    );
    for (QueryDocumentSnapshot<Map<String, dynamic>> document in usersQuerySnapshot.docs) {
      if (!document.get('confirmed') && document.data()['receivedConfirmationEmail'] != true) {
        ConfirmPresenceRecipient item = ConfirmPresenceRecipient(
          name: document.get('name'),
          email: document.get('email'),
        );
        users.add(item);
      }
    }

    return users;
  }

  Future<Result> createUserInfo({required String email, required String name}) async {
    Result result = Result(status: true);
    try {
      await FirestoreHandler.addDocument(
        id: email,
        collection: DatabaseCollection.users,
        params: <String, dynamic>{
          'name': name,
          'email': email,
          'confirmed': false,
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

  Future<Result> confirmPresence({required String email, required bool confirmed}) async {
    Result result = Result(status: true);
    try {
      await FirestoreHandler.updateDocument(
        id: email,
        collection: DatabaseCollection.users,
        params: <String, dynamic>{
          'confirmed': confirmed,
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

  Future<Result> updateEmailReceived({required String email}) async {
    Result result = Result(status: true);
    try {
      await FirestoreHandler.updateDocument(
        id: email,
        collection: DatabaseCollection.users,
        params: <String, dynamic>{
          'receivedConfirmationEmail': true,
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
