import 'package:covid19india/pages/splash_screen.dart';
import 'package:covid19india/services/api_data_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApiDataService>(
          create: (context) => ApiDataService.instance(),
        ),
      ],
      child: MaterialApp(
        title: 'Covid-19 India',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
