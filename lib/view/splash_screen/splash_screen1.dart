
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import"dart:async";

import "package:myparaconnect/view/login.dart";





class SplashScreen extends StatefulWidget{
  SplashScreen({ Key? key}): super (key:key);

  @override
  _SplashScreenState createState()=> _SplashScreenState();

}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds:3), ()=> Navigator.pushReplacement(context , MaterialPageRoute(builder:(context)=>LoginPage())));
  }


  @override
  Widget build (BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight= MediaQuery.of(context).size.height;

    double width = screenWidth;
    double height = screenheight;

    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child:Container(
            width: width*0.88,
              height: height*0.13,

              child:  Center(
                  child:Container(


                    height:height,
                    width:width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/img.png'),
                        fit: BoxFit.cover,
                      ),

                    ),
                  )
                /////Rive

              )
          ),
        ));
  }

}