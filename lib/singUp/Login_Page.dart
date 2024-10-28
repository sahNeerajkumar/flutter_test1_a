import 'package:flutter/material.dart';
import 'package:flutter_test1/HomePage.dart';
import 'package:flutter_test1/singUp/singUp_Page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../DatabaseService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var index = 0;
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  var dbServes = DatabaseServices();

  List<Map<String, dynamic>> userList = [];
  String? getId;
  String?getName;
  String?getEmail;
  String? getPassword;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('Login Page')),),
         body: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextField(
                 controller: userEmail,
                 decoration: InputDecoration(
                     border: OutlineInputBorder(), hintText: 'Enter Email'),
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextField(
                 controller: userPassword,
                 decoration: InputDecoration(
                     border: OutlineInputBorder(), hintText: 'Enter Password'),
               ),
             ),
             OutlinedButton(onPressed: () {
               logins();
             },style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent), child: const Text('Login')),

             TextButton(onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => SingUpPage(),));
             }, child: Text("signUp"))
           ],
         ),
      ),
    );
  }
  void fetchData()async{
    var data = await dbServes.getAuthData();
    setState(() {
      userList = data;
      if(userList.isNotEmpty){
        getId = userList[index]['id'];
        getName = userList[index]['userName'];
        getEmail = userList[index]['userEmail'];
        getPassword = userList[index]['userPassword'];
      }
    });
  }
  void logins(){
    var email = userEmail.text;
    var password = userPassword.text;
    if(email == getEmail && password == getPassword){
      addBool();
      Navigator.push(context, MaterialPageRoute(builder: (context) =>Homepage()));
    }else{
      Fluttertoast.showToast(msg: 'Wrong email or password');
    }
  }




  void addBool() async {
    setState(() {
      isLogin = true;
    });

    Map<String, dynamic> updatedUser  = {
      // 'userName': getName,
      // 'userEmail': getEmail,
      // 'userPassword': getPassword,
      'isLogin': isLogin
    };

    await dbServes.updateAuthData(getId, updatedUser);
  }
}
