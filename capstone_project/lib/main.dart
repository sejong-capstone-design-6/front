import 'package:capstone_project/provider/check_evaluation_done_provider.dart';
import 'package:capstone_project/provider/movie_scenario_provider.dart';
import 'package:capstone_project/provider/my_scenario_provider.dart';
import 'package:capstone_project/screen/MoviePracticePage1.dart';
import 'package:capstone_project/screen/MyScenarioPage.dart';
import 'package:capstone_project/screen/SplashPage.dart';
import 'package:capstone_project/model/date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserInfo()),
        ChangeNotifierProvider(create: (_) => CheckEvaluationDoneProvider()),
        ChangeNotifierProvider(create: (_) => MyScenarioProvider()),
        ChangeNotifierProvider(create: (_) => MovieScenarioProvider())
      ],
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
      routes: {
        '/my_scenario': (context) => MyScenarioPage(
            scenarioId: context.watch<MyScenarioProvider>().getScenarioId(), mode: context.watch<MyScenarioProvider>().getScenarioMode(),),
        '/movie_scenario': (context) => MoviePracticePage1(
            id: context.watch<MovieScenarioProvider>().getScenarioId(),
            title: context.watch<MovieScenarioProvider>().getTitle(),
            url: context.watch<MovieScenarioProvider>().getUrl())
      },
    );
  }
}
