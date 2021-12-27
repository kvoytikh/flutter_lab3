import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2/model/liked.dart';
import 'package:lab2/model/post_data.dart';
import 'package:lab2/widgets/post.dart';
import 'package:provider/provider.dart';

class LikedPosts extends StatefulWidget {
  final Function addPost;
  final List<PostData> savedPosts;

  const LikedPosts({
    Key? key,
    required this.savedPosts,
    required this.addPost,
  }) : super(key: key);

  @override
  _LikedPostsState createState() => _LikedPostsState();
}

class _LikedPostsState extends State<LikedPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Posts'),
      ),
      body: Consumer<LikedModel>(
        builder: (context, liked, child) => ListView.builder(
          itemBuilder: (context, index) {
            return Post(
              postData: liked.likedPosts[index],
              savedPosts: widget.savedPosts,
              addPost: widget.addPost,
            );
          },
          itemCount: liked.likedPosts.length,
        ),
      ),
    );
  }
}
