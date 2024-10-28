import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import '../DatabaseService.dart';
import 'Login_Page.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingUpPage> {
  // var index = 0;
  File? _galleryFile;
  final picker = ImagePicker();
  TextEditingController userName = TextEditingController();
TextEditingController userEmail = TextEditingController();
TextEditingController userPassword = TextEditingController();
  var dbServes = DatabaseServices();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(child: Text('SingUpPage')),
        ),
        body: Column(
          children: [


            SizedBox(
              height: 50,
            ),
            InkWell(
             onTap: () {
               _pickImageFromGallery();
             },
             child:  CircleAvatar(
               radius: 60,
               child: ClipOval(
                 child: _galleryFile != null? Image.file(_galleryFile!,height:120,width:120,fit: BoxFit.cover,):Text('No image select'),
               ),
             ),
           ),
            SizedBox(
              height: 50,
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: userName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Name'),
              ),
            ),
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
            OutlinedButton(
                onPressed: () {
                  register();

                },
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
                child: const Text('Register')),



            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            }, child: Text("LoginPage"))
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery()async{
    final ImagePicker _pickel = ImagePicker();
    final XFile? image = await _pickel.pickImage(source: ImageSource.gallery);
    if(image !=null){
      setState(() {
        _galleryFile = File(image.path);
      });
    }
  }


  void register() async {
    var name = userName.text;
    var email = userEmail.text;
    var password = userPassword.text;

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      var uuid = const Uuid().v4();
      Map<String, dynamic> user = {
        'id': uuid,
        'userName' :name,
        'userEmail' :email,
        'userPassword' :password,
      };

      await dbServes.insertAuthData(user);
      Fluttertoast.showToast(msg: 'User Registered Successfully');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Fluttertoast.showToast(msg: 'Please fill all fields');
    }
  }
}
