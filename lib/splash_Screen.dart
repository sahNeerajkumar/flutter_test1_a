import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test1/DatabaseService.dart';
import 'package:flutter_test1/singUp/singUp_Page.dart';

import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var dbServes = DatabaseServices();
  List<Map<String, dynamic>> userList =[];
  int? isLogin;

  @override
  void initState() {
    super.initState();
    feachData();
    splace();

  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(title: Center(child: Text('Splash Screen')),),
        backgroundColor: Colors.blueAccent,
                  ),
      );
  }
  void feachData() async{
    var user =await dbServes.getAuthData();
    setState(() {
      userList = user;
      isLogin = userList[0]['isLogin'];
    });

  }
  void splace(){
    Timer(Duration(seconds: 2),(){
      if(isLogin == 1 && isLogin != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(),));
    }
      else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SingUpPage(),));
    }
    });
  }
}
