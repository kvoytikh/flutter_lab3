// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lab2/model/post_data.dart';
import 'package:lab2/model/theme_model.dart';
import 'package:lab2/screens/profile/posts.dart';
import 'package:lab2/widgets/saved_posts.dart';
import 'package:provider/src/provider.dart';

import '../../widgets/liked_posts.dart';
import '../insights.dart';
import '../post_page.dart';

class ProfilePage extends StatelessWidget {
  final List<PostData> savedPosts;
  final ValueChanged<PostData> addPost;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProfilePage({
    Key? key,
    required this.savedPosts,
    required this.addPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('kvoytikh'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_box_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              ),
            ],
          ),
          endDrawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.symmetric(vertical: 25),
              children: [
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Archive'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.bookmark_border_sharp),
                  title: const Text('Saved'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedPosts(
                          savedPosts: savedPosts,
                          addPost: addPost,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text('Liked'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LikedPosts(
                          savedPosts: savedPosts,
                          addPost: addPost,
                        ),
                      ),
                    );
                  },
                ),
                ToggleThemeButton(),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Hero(
                          tag: "avatar",
                          child: ProfileAvatar(),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return StoryScreen();
                              },
                            ),
                          );
                        },
                      ),
                      Statistics(),
                    ],
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: ProfileDescription(),
                ),
                ProfileButtons(),
                Stories(),
                const TabBar(tabs: [
                  Tab(
                    icon: Icon(Icons.grid_on),
                  ),
                  Tab(
                    icon: Icon(Icons.portrait_outlined),
                  )
                ]),
                Posts(),
              ],
            ),
          )),
    );
  }
}

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeMode =
        context.select<ThemeModel, ThemeMode>((theme) => theme.themeMode);

    return SwitchListTile(
      title: Text("Dark Mode"),
      onChanged: (value) {
        context.read<ThemeModel>().changeThemeMode(value);
      },
      value: themeMode == ThemeMode.dark,
    );
  }
}

class Stories extends StatelessWidget {
  const Stories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Row(
        children: const [
          StoryWidget(image: 'images/foto2.jpg', storyName: 'kyiv'),
          StoryWidget(image: 'images/foto3.jpg', storyName: 'moments'),
        ],
      ),
    );
  }
}

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              ProfileButton(name: 'Edit profile'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: const [
              ProfileButton(name: 'Promotions'),
              //ProfileButton(name: 'Insights'),
              InsightsButton(),
              ProfileButton(name: 'Email'),
            ],
          ),
        ),
      ],
    );
  }
}

class Statistics extends StatelessWidget {
  const Statistics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: const [
              Text('125',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text('Posts')
            ],
          ),
          Column(
            children: const [
              Text('235',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text('Followers')
            ],
          ),
          Column(
            children: const [
              Text('112',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text('Following')
            ],
          ),
        ],
      ),
    );
  }
}

class StoryScreen extends StatelessWidget {
  const StoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "images/foto5.jpg",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Container(
              height: 80,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(220),
                    Colors.black.withAlpha(10),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Hero(
                        tag: 'avatar',
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('images/foto1.jpg'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        'kvoytikh',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: Text('5h')),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3)
        ],
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('images/story.png'),
        child: CircleAvatar(
          radius: 44,
          backgroundImage: AssetImage('images/foto1.jpg'),
        ),
      ),
    );
  }
}



class ProfileDescription extends StatelessWidget {
  const ProfileDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            'Kristina Voytikh',
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.1,
          ),
        ),
        const Text(
          'Personal blog',
          style: TextStyle(color: Colors.grey),
        ),
        const Text(
          'Student of NTUU KPI',
        ),
        Text(
          'kvoytikh.com',
          style: TextStyle(color: Colors.blueGrey),
        ),
        const Text(
          'view translation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class StoryWidget extends StatelessWidget {
  final String image;
  final String storyName;

  const StoryWidget({
    Key? key,
    required this.image,
    required this.storyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 10),
          Text(storyName),
        ],
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String name;

  const ProfileButton({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: OutlinedButton(
          onPressed: () {},
          child: Text(name),
        ),
      ),
    );
  }
}

class InsightsButton extends StatelessWidget {
  const InsightsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Insights(
                          userName: 'kvoytikh',
                        )));
          },
          child: Text('Insights'),
        ),
      ),
    );
  }
}
