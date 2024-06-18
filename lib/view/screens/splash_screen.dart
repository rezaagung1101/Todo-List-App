import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/widgets/title_text.dart';
import '../../utils/constants.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    Timer(const Duration(seconds: 2), _navigateToHome);
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(CurveTween(curve: Curves.easeIn));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.skyBlue,
        body: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          child: Container(
            color: Constants.skyBlue,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    CupertinoIcons.doc_append,
                    color: Colors.white,
                    size: 100,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TitleText(
                      text: Constants.appName, size: 20, color: Colors.white)
                ],
              ),
            ),
          ),
        ));
  }
}
