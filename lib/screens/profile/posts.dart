import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2/model/post_data.dart';
import 'package:http/http.dart' as http;

import '../post_page.dart';

Future<List<PostData>> fetchPosts() async {
  final response = await http.get(Uri.parse(
      'https://raw.githubusercontent.com/kvoytikh/Flutter_lab2/master/data/posts.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var parsed = jsonDecode(response.body);
    return parsed.map<PostData>((json) => PostData.fromJson(json)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load posts');
  }
}

class Posts extends StatefulWidget {
  const Posts({
    Key? key,
  }) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  late Future<List<PostData>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostData>>(
      future: futurePosts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
            ),
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ProfilePost(postData: snapshot.data![index]);
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}

class ProfilePost extends StatelessWidget {
  final PostData postData;

  const ProfilePost({
    Key? key,
    required this.postData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/postPage',
              arguments: PostPageArguments(postData));
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(postData.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
