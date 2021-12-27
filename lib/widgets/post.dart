import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2/model/liked.dart';
import 'package:provider/provider.dart';

import '../model/post_data.dart';

class Post extends StatelessWidget {
  final Function? addPost;
  final PostData postData;
  final List<PostData>? savedPosts;

  const Post({
    Key? key,
    required this.postData,
    this.savedPosts,
    this.addPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PostHeader(
            username: postData.username,
            userImagePath: postData.userImagePath,
            location: postData.location,
          ),
          PostPhoto(image: postData.imagePath),
          PostBottom(
            likesNumber: postData.likesNumber,
            time: postData.postingTime,
            addPost: addPost,
            postData: postData,
            savedPosts: savedPosts,
          ),
        ],
      ),
    );
  }
}

class PostPhoto extends StatelessWidget {
  final String image;

  const PostPhoto({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image.startsWith('https://')
          ? NetworkImage(image)
          : AssetImage(image) as ImageProvider,
      height: 500,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class PostBottom extends StatelessWidget {
  final int likesNumber;
  final int time;
  final Function? addPost;
  final PostData postData;
  final List<PostData>? savedPosts;

  const PostBottom({
    Key? key,
    required this.likesNumber,
    required this.time,
    this.addPost,
    required this.postData,
    this.savedPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              LikeButton(
                postData: postData,
              ),
              IconButton(
                  onPressed: () => {}, icon: Icon(Icons.mode_comment_outlined)),
              IconButton(onPressed: () => {}, icon: Icon(Icons.send_outlined)),
              Spacer(),
              SaveButton(
                addPost: addPost,
                postData: postData,
                savedPosts: savedPosts,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${likesNumber} likes',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.1,
                ),
                Text(
                  '${time} days ago',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SaveButton extends StatefulWidget {
  final Function? addPost;
  final PostData postData;
  final List<PostData>? savedPosts;

  const SaveButton({
    Key? key,
    this.addPost,
    required this.postData,
    this.savedPosts,
  }) : super(key: key);

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    bool isSaved = widget.savedPosts?.contains.call(widget.postData) ?? false;
    return IconButton(
        onPressed: () => widget.addPost?.call(widget.postData),
        icon:
            Icon(isSaved ? Icons.bookmark_sharp : Icons.bookmark_border_sharp));
  }
}

class LikeButton extends StatefulWidget {
  final PostData postData;

  const LikeButton({
    Key? key,
    required this.postData,
  }) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    var isLiked = context.select<LikedModel, bool>(
        (liked) => liked.likedPosts.contains(widget.postData));

    return IconButton(
        onPressed: () {
          context.read<LikedModel>().toggleLikedPost(widget.postData);
        },
        icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline));
  }
}

class PostHeader extends StatelessWidget {
  final String username;
  final String userImagePath;
  final String location;

  const PostHeader({
    Key? key,
    required this.username,
    required this.userImagePath,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        //backgroundColor: Colors.pink,
        backgroundImage: userImagePath.startsWith('https://')
            ? NetworkImage(userImagePath)
            : AssetImage(userImagePath) as ImageProvider,
      ),
      title: Text('${username}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          )),
      subtitle: Text('${location}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          )),
      trailing: const Icon(
        Icons.more_horiz,
        color: Colors.white,
      ),
    );
  }
}
