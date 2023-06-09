import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectalpha/constants.dart';
import 'package:projectalpha/screens/auth_screens/login_page.dart';
import 'package:projectalpha/screens/auth_screens/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  Future resetPassword() async {
  await FirebaseAuth.instance
  .sendPasswordResetEmail(email: emailController.text.toLowerCase());
  Utils.showSnackBar("Password reset mail has been sent.");
  }

  bool isLogin = true;
  void toggle() => setState(() => isLogin = !isLogin);

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
                                    'Forgot Password',
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
                              width: MediaQuery.of(context).size.width,
                              height: 85,
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              child: Text(
                                "Please enter the registered email for your AgroGuard account. A link will be sent to this email, open that link to reset your password. Check your spam mail in case you don't see the mail",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 13),
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: const EdgeInsets.only(
                                  top: 25, left: 20, right: 20),
                              child: const TextField(
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
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
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              margin: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: ElevatedButton(
                                onPressed: resetPassword,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: themeColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(50),
                                            right: Radius.circular(50)))),
                                child: const Text(
                                  'Reset Password',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.only(
                                  top: 0, left: 20, right: 20),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                             LoginPage(onClickedSignUp: toggle)),
                                    );
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(color: themeColor),
                                  )),
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
