import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../main.dart';
import '../sign_up/p_sign_up.dart';

class MainSignInPage extends StatefulWidget {
  const MainSignInPage({Key? key}) : super(key: key);

  @override
  State<MainSignInPage> createState() => _MainSignInPageState();
}

class _MainSignInPageState extends State<MainSignInPage> {
  var boxColor = Colors.white;

  @override
  bool isChecked = false;
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF141414),
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
              SizedBox(height: 80,),
              Text(
                "SE CONNECTER",
                style: TextStyle(fontFamily: 'DMSans', color: Colors.white ,fontSize: 23, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Container(
                width: 500,
                padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: Stack(
                  children: [
                    Container(
                      height: 43,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(50, 0, 20, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.purple,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 12, 0, 0),
                      child: Image.asset(
                        'assets/images/profil_logo.png',
                        height: 16,
                        width: 16,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )
              ),
              Container(
                  width: 500,
                  padding: EdgeInsets.fromLTRB(45, 10, 45, 0),
                  child: Stack(
                    children: [
                      Container(
                        height: 43,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],

                        ),

                      ),Padding(padding: EdgeInsets.fromLTRB(50, 0, 20, 0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.purple,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 12, 0, 0),
                        child: Image.asset(
                          'assets/images/password_logo.png',
                          height: 16,
                          width: 16,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Color(0xFF951DDE),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      "se souvenir de moi",
                      style: TextStyle(fontFamily: 'DMSans', color: Colors.white ,fontSize: 17, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              ClipRRect(
                borderRadius: BorderRadius.circular(22),

                child: Material(

                  child: InkWell(
                    highlightColor: Colors.grey.shade100,
                    splashColor: Color(0xFF406DE1),
                    onTap: (){
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.fade,
                            childCurrent: widget,
                            child: Splash()),
                      );
                    },
                    child:Ink(
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/valid_logo.png',
                          width: 40,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: 83,
                      height: 83,
                      decoration: BoxDecoration(
                        color: Colors.white,// Set rounded corner radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),

                    ),
                  ),
                ),
              ),
              SizedBox(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tu n’as pas de compte?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 17)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                              type: PageTransitionType.fade,
                              childCurrent: widget,
                              child: MainSignUpPage()),
                        );
                      },
                      child: Text(' s’inscrire', style: TextStyle(color: Color(0xFF406DE1), fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    ),
                  ],
                ),
              SizedBox(height: 60,),
            ],
          ),
          Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: Text("v1.0",
                  style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.5) ,fontSize: 17, fontWeight: FontWeight.w700),
                ),
              )
          ),

        ],
      ),
    );
  }
}