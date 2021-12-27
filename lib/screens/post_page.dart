import 'package:flutter/material.dart';
import 'package:lab2/model/post_data.dart';
import 'package:lab2/widgets/post.dart';

class PostPageArguments {
  final PostData postData;
  PostPageArguments(this.postData);
}

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PostPageArguments?;

    if (args != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Post page'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Post(
              postData: args.postData,
            ),
          ),
        ),
      );
    }

    return Container();
  }
}

