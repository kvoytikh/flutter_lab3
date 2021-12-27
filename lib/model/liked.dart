import 'package:flutter/cupertino.dart';
import 'package:lab2/model/post_data.dart';

class LikedModel extends ChangeNotifier {
  List<PostData> likedPosts = [];

  void toggleLikedPost(PostData post) {
    if (likedPosts.contains(post)) {
      likedPosts.remove(post);
    } else {
      likedPosts.add(post);
    }

    notifyListeners();
  }
}
