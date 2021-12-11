import 'package:firebase_database/firebase_database.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/utils/helpers/helpers.dart';

class LikedDao {
  final DatabaseReference _likedRef =
      FirebaseDatabase.instance.ref().child(fLiked);

  void saveLikes(Liked like) {
    _likedRef.push().set(like.toJson());
  }

  Query getLikesQuery() {
    return _likedRef;
  }
}
