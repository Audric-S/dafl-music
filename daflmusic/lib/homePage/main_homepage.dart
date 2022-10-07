import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePage();
}

class _MainHomePage extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Image.asset(
            'assets/images/background_blur.png',
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
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("CONTINUER AVEC SPOTIFY",
                    style: TextStyle(color: Colors.white ,fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                margin: EdgeInsets.fromLTRB(60, 40, 60, 0),
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xFF24CF5F),
                  borderRadius: BorderRadius.all(
                      Radius.circular(15)),
                  border: Border.all(
                    width: 1.5,
                    color: Color(0xFF68F097),
                  ),// Set rounded corner radius

                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("S’INSCRIRE MAINTENANT",
                    style: TextStyle(fontFamily: 'DMSans', color: Colors.white ,fontSize: 17, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                margin: EdgeInsets.fromLTRB(60, 10, 60, 0),
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xFF951DDE),
                  borderRadius: BorderRadius.all(
                      Radius.circular(15)),
                  border: Border.all(
                    width: 1.5,
                    color: Color(0xFFC656ED),
                  ),// Set rounded corner radius

                ),
              ),
              SizedBox(height: 220,),
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("SE CONNECTER",
                    style: TextStyle(color: Colors.white ,fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFF232123),
                  border: Border(
                    top: BorderSide(width: 1.5, color: Color(0xFF3C3C3C)),
                  ),// Set rounded corner radius

                ),
              ),


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


