import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectalpha/constants.dart';
import 'package:projectalpha/mongo_schema/schema.dart';
import 'package:projectalpha/mongodb.dart';
import 'package:projectalpha/screens/auth_screens/login_page.dart';
import 'package:projectalpha/screens/auth_screens/utils.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import '../../main.dart';

class SignUp extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUp({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
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
                      height: 380,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(239, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
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
                                      'Sign up',
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
                                height: 50,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                child: TextField(
                                  controller: nameController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: themeColor,
                                      ),
                                      label: Text('Your full name...'),
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
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15.0),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15.0),
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
                                                style: TextStyle(
                                                    color: Colors.grey),
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
                                  onPressed: () async{
                                    await signUp();
                                    await insertFarmerData(
                                        nameController.text, emailController.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: themeColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(50),
                                              right: Radius.circular(50)))),
                                  child: const Text(
                                    'Sign up',
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
                                            builder: (context) => LoginPage(
                                                  onClickedSignUp: toggle,
                                                )),
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
                      ),
                    )),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> insertFarmerData(var myFarmerName, var myEmail) async {
    var _id = M.ObjectId();
    final data = Farmer(
      id: _id,
      farmerName: myFarmerName,
      email: myEmail,
    );

    var result = await MongoDatabase.insertFarmerData(data);
  }
}
