import 'package:covid19india/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome() {
    Future.delayed(
        Duration(
          seconds: 2,
        ), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 96.0,
                    height: 96.0,
                    child: Image.asset('assets/logo.png'),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Covid-19 India',
                      style: GoogleFonts.nunito(
                        textStyle:
                            Theme.of(context).textTheme.headline.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Developed by ',
                    style: GoogleFonts.nunito(
                      textStyle: Theme.of(context).textTheme.subtitle.copyWith(
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Text(
                    'Ketul Rastogi',
                    style: GoogleFonts.nunito(
                      textStyle: Theme.of(context).textTheme.subtitle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
