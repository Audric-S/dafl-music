import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../main.dart';
import '../sign_up/p_sign_up.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var boxColor = Colors.white;

  bool isChecked = false;
  final userNameTextField = TextEditingController();
  final passwordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF141414),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Image.asset(
            'assets/images/background.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/Logo.png',
                width: 250,
              ),
              const SizedBox(
                height: 80,
              ),
              const Text(
                "SE CONNECTER",
                style: TextStyle(
                    fontFamily: 'DMSans',
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: 500,
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 0),
                  child: Stack(
                    children: [
                      Container(
                        height: 43,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
                        child: TextField(
                          keyboardAppearance: Brightness.dark,
                          controller: userNameTextField,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.purple,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 12, 0, 0),
                        child: Image.asset(
                          'assets/images/profil_logo.png',
                          height: 16,
                          width: 16,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: 500,
                  padding: const EdgeInsets.fromLTRB(45, 10, 45, 0),
                  child: Stack(
                    children: [
                      Container(
                        height: 43,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
                        child: TextField(
                          keyboardAppearance: Brightness.dark,
                          controller: passwordTextField,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.purple,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 12, 0, 0),
                        child: Image.asset(
                          'assets/images/password_logo.png',
                          height: 16,
                          width: 16,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: const Color(0xFF951DDE),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    const Text(
                      "se souvenir de moi",
                      style: TextStyle(
                          fontFamily: 'DMSans',
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Material(
                      child: InkWell(
                          highlightColor: Colors.grey.shade100,
                          splashColor: const Color(0xFF406DE1),
                          onTap: () {
                            checkInformations(
                                userNameTextField.text, passwordTextField.text);
                          },
                          child: Ink(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              width: 83,
                              height: 83,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // Set rounded corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.check,
                                    color: Color(0xFF406DE1),
                                    size: 60.0,
                                  )))))),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tu n’as pas de compte ?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 17)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageTransition(
                            type: PageTransitionType.fade,
                            childCurrent: widget,
                            child: const SignUpPage()),
                      );
                    },
                    child: const Text(
                      ' s’inscrire',
                      style: TextStyle(
                          color: Color(0xFF406DE1),
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void checkInformations(String username, String password) async {
    if (username == "") {
      notify(2, context);
    } else if (password == "") {
      notify(4, context);
    } else if (await MyApp.controller
        .load(userNameTextField.text, passwordTextField.text)) {
      MyApp.controller.initUser();
      Navigator.of(context).push(
        PageTransition(
            type: PageTransitionType.fade,
            childCurrent: widget,
            child: const Splash()),
      );
    } else {
      notify(2, context);
    }
  }
}
