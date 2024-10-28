import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_app/bloc/news_bloc.dart';
import 'package:flutter_news_app/bloc/theme_bloc.dart'; // Import ThemeBloc
import 'package:flutter_news_app/view/home/home_screen.dart';
import 'package:flutter_news_app/view/login_page.dart';
import 'package:flutter_news_app/view/splash_screen.dart';
import 'firebase_options.dart'; // Your Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(), // Provide the ThemeBloc here
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            theme: themeState.isDarkMode
                ? ThemeData.dark()
                : ThemeData.light(), // Switch theme based on ThemeBloc state
            home: AuthStateHandler(),
          );
        },
      ),
    );
  }
}

class AuthStateHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen(); // Show splash screen while checking auth state
        } else if (snapshot.hasData) {
          return HomeScreen(); // Navigate to HomeScreen if user is logged in
        } else {
          return LoginPage(); // Navigate to LoginPage if no user is logged in
        }
      },
    );
  }
}
