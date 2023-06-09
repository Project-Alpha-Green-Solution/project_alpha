import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectalpha/constants.dart';
import 'package:projectalpha/screens/auth_screens/forgot_password.dart';
import 'package:projectalpha/screens/auth_screens/signup_page.dart';
import 'package:projectalpha/screens/auth_screens/utils.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  final Function() onClickedSignUp;
  const LoginPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

  

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      //print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  bool isLogin = true;
  void toggle() => setState(() => isLogin = !isLogin);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/authBg.jpeg'),
                      fit: BoxFit.cover)),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: const Color.fromARGB(146, 0, 0, 0),
              child: Stack(children: [
                Positioned(
                    top: 90,
                    right: 75,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/agroLogo.png'),
                    )),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 360,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(239, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 25, right: 25),
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: themeColor),
                                  ),
                                  SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Image.asset(
                                        'assets/agroLogo.png',
                                        fit: BoxFit.cover,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              height: 55,
                              margin: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                controller: emailController,
                                decoration: const InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: themeColor,
                                    ),
                                    label: Text('Your email...'),
                                    focusColor: themeColor,
                                    floatingLabelStyle:
                                        TextStyle(color: themeColor),
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.center,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: themeColor),
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(50),
                                            right: Radius.circular(50))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(50),
                                            right: Radius.circular(50)))),
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                obscureText: _isHidden,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: themeColor,
                                    ),
                                    suffixIcon: _isHidden
                                        ? TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _isHidden = !_isHidden;
                                              });
                                            },
                                            child: const Text(
                                              'show',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ))
                                        : TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _isHidden = !_isHidden;
                                              });
                                            },
                                            child: const Text('hide',
                                                style: TextStyle(
                                                    color: Colors.grey))),
                                    suffixStyle:
                                        const TextStyle(color: Colors.grey),
                                    label: const Text('Your password...'),
                                    focusColor: themeColor,
                                    floatingLabelStyle:
                                        const TextStyle(color: themeColor),
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.center,
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: themeColor),
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(50),
                                            right: Radius.circular(50))),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(50),
                                            right: Radius.circular(50)))),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              margin: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: ElevatedButton(
                                onPressed: signIn,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: themeColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(50),
                                            right: Radius.circular(50)))),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              margin: const EdgeInsets.only(
                                  top: 0, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               SignUp(onClickedSignIn: toggle)),
                                    );
                                      },
                                      child: const Text(
                                        'Sign up',
                                        style: TextStyle(color: themeColor),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPassword()),
                                    );
                                      },
                                      child: const Text(
                                        'Forgot password?',
                                        style: TextStyle(color: themeColor),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
