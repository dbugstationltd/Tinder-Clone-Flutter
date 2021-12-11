import 'package:firebase_database/firebase_database.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/utils/helpers/helpers.dart';

class MessageDao {
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.ref().child(fChat);

  void saveMessage(Message message) {
    _messagesRef.push().set(message.toJson());
  }

  Query getMessageQuery() {
    return _messagesRef;
  }
}
