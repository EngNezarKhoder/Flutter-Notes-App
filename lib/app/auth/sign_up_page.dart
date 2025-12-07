import 'package:appnote/app/auth/login_page.dart';
import 'package:appnote/widgets/my_dialog.dart';
import 'package:appnote/widgets/my_indicator.dart';
import 'package:appnote/widgets/valid.dart';
import 'package:appnote/cubit/password_sign_up_cubit.dart';
import 'package:appnote/cubit/password_sign_up_state.dart';
import 'package:appnote/cubit/sign_up_cubit.dart';
import 'package:appnote/cubit/sign_up_state.dart';
import 'package:appnote/widgets/my_button.dart';
import 'package:appnote/widgets/my_logo.dart';
import 'package:appnote/widgets/my_text_form_field_email.dart';
import 'package:appnote/widgets/my_text_form_field_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              const SizedBox(
                height: 130,
              ),
              MyLogo(),
              const SizedBox(
                height: 50,
              ),
              MyTextFormFieldEmail(
                  hintText: "nezar",
                  icon: Icons.person,
                  controller: username,
                  validator: validateUserName),
              const SizedBox(
                height: 15,
              ),
              MyTextFormFieldEmail(
                  hintText: "x@gmail.com",
                  icon: Icons.email,
                  controller: email,
                  validator: validateEmail),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<PasswordSignUpCubit, PasswordSignUpState>(
                  builder: (context, state) {
                return MyTextFormFieldPassword(
                    obscureText: state.obscure,
                    onPressed: () {
                      context.read<PasswordSignUpCubit>().toggle();
                    },
                    controller: password,
                    validator: validatePassword,
                    hintText: "Nea@12",
                    icon: Icons.lock);
              }),
              const SizedBox(
                height: 15,
              ),
              BlocConsumer<SignUpCubit, SignUpState>(builder: (context, state) {
                if (state.isLoading) {
                  return MyIndicator();
                }
                return MyButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_globalKey.currentState?.validate() ?? false) {
                        context
                            .read<SignUpCubit>()
                            .signUp(username.text, email.text, password.text);
                      }
                    },
                    title: "Sign Up");
              }, listener: (context, state) {
                switch (state.message) {
                  case 'done':
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage(status: true)));
                    break;
                  case 'email_exist':
                    showCustomDialog(context,
                        icon: Icons.error,
                        color: Colors.red,
                        title: "Error",
                        content: "The email is already registered");
                    break;
                  case 'error':
                    showCustomDialog(context,
                        icon: Icons.error,
                        color: Colors.red,
                        title: "Error",
                        content: "An unknown error occurred. Please try again");
                    break;
                  case 'error_connect':
                    showCustomDialog(context,
                        icon: Icons.error,
                        color: Colors.red,
                        title: "Error",
                        content: "Failed to connect. Please try again later");
                    break;
                  default:
                    break;
                }
              }),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have An Account?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).pushReplacementNamed("loginPage");
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 41, 120, 185),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
