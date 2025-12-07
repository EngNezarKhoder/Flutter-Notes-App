import 'package:appnote/app/auth/login_page.dart';
import 'package:appnote/app/auth/sign_up_page.dart';
import 'package:appnote/app/home_page.dart';
import 'package:appnote/cubit/category_cubit.dart';
import 'package:appnote/cubit/login_cubit.dart';
import 'package:appnote/cubit/note_cubit.dart';
import 'package:appnote/cubit/password_login_cubit.dart';
import 'package:appnote/cubit/password_sign_up_cubit.dart';
import 'package:appnote/cubit/sign_out_cubit.dart';
import 'package:appnote/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PasswordSignUpCubit()),
          BlocProvider(create: (context) => PasswordLoginCubit()),
          BlocProvider(create: (context) => SignUpCubit()),
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => SignOutCubit()),
          BlocProvider(create: (context) => CategoryCubit()),
          BlocProvider(create: (context) => NoteCubit()),
        ],
        child: MaterialApp(
          theme: ThemeData(
              appBarTheme:
                  AppBarTheme(iconTheme: IconThemeData(color: Colors.white))),
          debugShowCheckedModeBanner: false,
          initialRoute:
              sharedPref.getString("id") == null ? "loginPage" : "homePage",
          routes: {
            "loginPage": (context) => const LoginPage(
                  status: false,
                ),
            "signUpPage": (context) => const SignUpPage(),
            "homePage": (context) => const HomePage(),
          },
        ));
  }
}
// flutter.compileSdkVersion