import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2/widgets/post.dart';
import 'package:lab2/model/post_data.dart';


// class ExtractFeed extends StatelessWidget {
//   const ExtractFeed({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)!.settings.arguments as ProfileArguments;
//     return ProfilePage(savedPosts: args.savedPosts, addPost: args.addPost);
//   }
// }


class Feed extends StatefulWidget {
  final Function addPost;
  final List postsData;
  final List<PostData> savedPosts;

  const Feed({
    Key? key,
    required this.postsData,
    required this.addPost,
    required this.savedPosts,
  }) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Instagram feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Post(
                postData: widget.postsData[index],
                addPost: widget.addPost,
                savedPosts: widget.savedPosts);
          }, childCount: widget.postsData.length))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
