// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lab2/model/liked.dart';
import 'package:lab2/screens/post_page.dart';
import 'package:lab2/screens/profile/profile.dart';
import 'package:provider/provider.dart';

import 'model/post_data.dart';
import 'model/theme_model.dart';
import 'screens/feed.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => LikedModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeModel(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 4;

  List<PostData> savedPosts = [];

  late PageController pageController;


  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 4);
  }

  void toggleSavedPost(PostData post) {
    setState(() {
      if (!savedPosts.contains(post)) {
        savedPosts.add(post);
      } else {
        savedPosts.remove(post);
      }
    });
  }

  void onTap(int i) {
    setState(() {
      index = i;

      pageController.animateToPage(index,
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select<ThemeModel, ThemeMode>((theme) => theme.themeMode);

    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/postPage': (context) => PostPage(),
      },
      darkTheme: ThemeData(
        // ignore: deprecated_member_use
        //primarySwatch: Colors.grey,
        accentColor: Colors.grey,
        brightness: Brightness.dark,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: Colors.white,
              side: const BorderSide(width: 0.5, color: Colors.white)),
        ),
      ),
      theme: ThemeData(
        //accentColor: Colors.blueGrey,
        primarySwatch: Colors.grey,
        brightness: Brightness.light,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: Colors.black,
              side: const BorderSide(width: 0.5, color: Colors.grey)),
        ),
      ),
      themeMode: themeMode,
      home: Scaffold(
        key: _scaffoldKey,
        body: SizedBox.expand(
          child: PageView(
            controller: pageController,
            onPageChanged: (i) {
              setState(() => index = i);
            },
            children: [
              Feed(
                  postsData: postsData,
                  addPost: toggleSavedPost,
                  savedPosts: savedPosts),
              Center(child: Text('Search')),
              Center(child: Text('Add new post')),
              Center(child: Text('Liked posts')),
              ProfilePage(savedPosts: savedPosts, addPost: toggleSavedPost),
            ],
          ),
        ),
        floatingActionButton: index == 3
            ? FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).textTheme.bodyText1!.color,
          currentIndex: index,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'home_filled',
                tooltip: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'search', tooltip: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined), label: 'add', tooltip: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: 'like', tooltip: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'account',
                tooltip: ''),
          ],
        ),
      ),
    );
  }
}
