import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:portfolio/firebase_options.dart';
import 'package:portfolio/view/screens/loginScreen/Providers/loginProvider.dart';
import 'package:portfolio/view/screens/loginScreen/Providers/signupProvider.dart';
import 'package:portfolio/view/screens/onboardingScreen/checkOnboarding.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //to use firebase and other services
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => SignupProvider()),
        ], //we add multiple provider over here
        child: MaterialApp(
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
              )),
          debugShowCheckedModeBanner: false,
          home:
              //we are using Animated splash screen to show the logo when the app is runing
              AnimatedSplashScreen(
                  animationDuration: const Duration(milliseconds: 400),
                  splash: Image.asset(
                      'lib/assets/images/ic_launcherCircular.png',
                      scale: 1),
                  nextScreen:
                      const CheckOnBoarding(), //this page decides if the user is new or not
                  // if new than the onboarding screen is shown whhen its run for the first time
                  backgroundColor: Colors.black,
                  pageTransitionType: PageTransitionType.fade,
                  duration: 1500),
          //onboarding screen only open when the user is logout
        ));
  }
}
