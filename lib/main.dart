import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/view/screens/home_screen.dart';
import 'package:todo_app/view/screens/splash_screen.dart';
import 'package:todo_app/viewModel/task_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: TaskViewModel())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Constants.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Constants.skyBlue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/home': (context) => const HomeScreen(),
          },
        ));
  }
}
