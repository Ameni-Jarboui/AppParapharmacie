import 'package:flutter/material.dart';
import 'package:myparaconnect/view/Admin/homeAdmin.dart';
import 'package:myparaconnect/view/home/homeUser.dart';
import 'package:myparaconnect/view/listData/userList.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width = screenWidth;
    double height = screenHeight;
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Container(
          height: height,
          width: width,
          color: Colors.red,
          child: Text("Hello User"),
        ),
      ),
    );
  }
}
