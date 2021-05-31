
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/screens/details-screen.dart';
import 'package:foody_app/screens/splash-screen.dart';
import 'package:foody_app/screens/home-screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393,760),

      builder:() => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme:  GoogleFonts.montserratAlternatesTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'launch_screen',
        routes: {
          'launch_screen' : (context) => SplashScreen(),
          'welcome_screen' : (context) => WelcomeScreen(),
          // 'sign_up_screen' : (context) => SignUpScreen(),
          // 'home_screen' : (context) => HomeScreen(),
          // 'verify_screen' : (context) => VerifyAccount(),

        },
      ),
    );

  }
}

