import 'package:flutter/material.dart';
import 'package:projectalpha/screens/auth_screens/login_page.dart';
import 'package:projectalpha/screens/auth_screens/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
        ? LoginPage(onClickedSignUp: toggle)
        : SignUp(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
