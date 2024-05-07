import 'package:capstone_project/screen/SplashPage.dart';
import 'package:capstone_project/model/date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserInfo())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.white,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          )),
      home: SplashScreen(),
    );
  }
}
