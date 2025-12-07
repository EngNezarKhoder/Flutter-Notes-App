import 'package:appnote/cubit/login_cubit.dart';
import 'package:appnote/cubit/login_state.dart';
import 'package:appnote/cubit/password_login_cubit.dart';
import 'package:appnote/cubit/password_login_state.dart';
import 'package:appnote/widgets/my_button.dart';
import 'package:appnote/widgets/my_dialog.dart';
import 'package:appnote/widgets/my_indicator.dart';
import 'package:appnote/widgets/my_logo.dart';
import 'package:appnote/widgets/my_text_form_field_email.dart';
import 'package:appnote/widgets/my_text_form_field_password.dart';
import 'package:appnote/widgets/valid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.status});
  final bool status;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.status) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCustomDialog(context,
            icon: Icons.warning_amber,
            color: Colors.green,
            title: "warning",
            content: "Please Sign In To Complete The Registration");
      });
    }
    super.initState();
  }

  @override
  void dispose() {
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
                height: 150,
              ),
              MyLogo(),
              const SizedBox(
                height: 50,
              ),
              MyTextFormFieldEmail(
                hintText: "x@gmail.com",
                icon: Icons.email,
                controller: email,
                validator: validateEmail,
              ),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<PasswordLoginCubit, PasswordLoginState>(
                  builder: (context, state) {
                return MyTextFormFieldPassword(
                    obscureText: state.obscure,
                    onPressed: () {
                      context.read<PasswordLoginCubit>().toggle();
                    },
                    controller: password,
                    validator: validatePassword,
                    hintText: "Nea@12",
                    icon: Icons.lock);
              }),
              const SizedBox(
                height: 15,
              ),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  switch (state.message) {
                    case 'done':
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("homePage", (route) => false);
                      break;
                    case 'password':
                      showCustomDialog(context,
                          icon: Icons.error,
                          color: Colors.red,
                          title: "Login Failed",
                          content:
                              "Wrong password, Please sure from it and try again.");
                      break;
                    case 'account':
                      showCustomDialog(context,
                          icon: Icons.error,
                          color: Colors.red,
                          title: "Error",
                          content: "No account found with this email address.");
                      break;
                    case 'error':
                      showCustomDialog(context,
                          icon: Icons.error,
                          color: Colors.red,
                          title: "Connection Error",
                          content:
                              "There was an issue connecting to the server. Please try again later.");
                      break;
                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return MyIndicator();
                  }
                  return MyButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_globalKey.currentState?.validate() ?? false) {
                          context
                              .read<LoginCubit>()
                              .login(email.text, password.text);
                        }
                      },
                      title: "Login");
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have An Account?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).pushNamed("signUpPage");
                      },
                      child: Text(
                        "Register",
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
