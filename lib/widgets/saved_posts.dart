import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2/widgets/post.dart';
import 'package:lab2/model/post_data.dart';

class SavedPosts extends StatefulWidget {
  final List<PostData> savedPosts;
  final Function addPost;

  const SavedPosts({
    Key? key,
    required this.savedPosts,
    required this.addPost,
  }) : super(key: key);

  @override
  State<SavedPosts> createState() => _SavedPostsState();
}

class _SavedPostsState extends State<SavedPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Posts'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Post(
            postData: widget.savedPosts[index],
            savedPosts: widget.savedPosts,
            addPost: widget.addPost,
          );
        },
        itemCount: widget.savedPosts.length,
      ),
    );
  }
}
