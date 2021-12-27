import 'dart:math';

import 'package:flutter/material.dart';

var randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

class AnimatedBarChart extends AnimatedWidget {
  const AnimatedBarChart({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 1, end: 200);
  static final _colorTween =
      ColorTween(begin: Colors.deepPurple, end: randomColor);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 400,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(width: 70, child: const Text('Kyiv')),
                  Opacity(
                    opacity: _opacityTween.evaluate(animation),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.cyan,
                      height: 30,
                      width: _sizeTween.evaluate(animation),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(width: 70, child: const Text('Kharkiv')),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    //color: Colors.cyan,
                    color: _colorTween.evaluate(animation),
                    height: 15,
                    width: _sizeTween.evaluate(animation),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(width: 70, child: const Text('Irpen')),
                  Opacity(
                    opacity: _opacityTween.evaluate(animation),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.pink,
                      height: 20,
                      width: _sizeTween.evaluate(animation),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 70,
                      child: const Text(
                        'Dnipro',
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: _colorTween.evaluate(animation),
                    height: _sizeTween.evaluate(animation),
                    width: _sizeTween.evaluate(animation),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Insights extends StatefulWidget {
  final String userName;

  const Insights({Key? key, required this.userName}) : super(key: key);

  @override
  _InsightsState createState() => _InsightsState();
}

class _InsightsState extends State<Insights>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insights ${widget.userName}')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CreatePromotionButton(),
            const Text(
              'Subscribers',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            AnimatedBarChart(animation: animation),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CreatePromotionButton extends StatelessWidget {
  const CreatePromotionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueGrey,
          ),
          onPressed: () {
            _navigateAndDisplayPromotion(context);
          },
          child: Text('Create a promotion'),
        ),
      ),
    );
  }

  void _navigateAndDisplayPromotion(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePromotionScreen()),
    ) ?? 'You have not created a promotion!';

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}

class CreatePromotionScreen extends StatelessWidget {
  const CreatePromotionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose the option for promotion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.pop(context, 'Promotion with post was created!');
                },
                child: const Text('Create promotion with post'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.pop(context, 'Promotion with story was created!');
                },
                child: const Text('Create promotion with story'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
