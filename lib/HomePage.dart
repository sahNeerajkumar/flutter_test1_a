import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test1/DatabaseService.dart';
import 'package:flutter_test1/Model_Page.dart';
import 'package:flutter_test1/Store_DataPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  File? _galleryFile;
  final picker = ImagePicker();
  final dbService = DatabaseServices();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  
  void userDetailsAdd() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: [
              const Center(
                  child: Text(
                'UserDetailsAdd',
                style: TextStyle(fontSize: 20),
              )),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _pickImageFromGallery();
                },
                child: CircleAvatar(
                  radius: 60,
                  child: ClipOval(
                    child: _galleryFile != null
                        ? Image.file(
                            _galleryFile!,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          )
                        : Text('No image select'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Email..'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: contactNumberController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'ContactNum..'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: subjectController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'subject'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: schoolController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'School..'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  onPressed: () {
                    var userModels = UserModel(
                        id: Uuid().v4(),
                        name: nameController.text,
                        email: emailController.text,
                        contactNum: contactNumberController.text,
                        subject: subjectController.text,
                        school: schoolController.text,
                        image: _galleryFile!.path);
                    dbService.insertDate(userModels);
                    setState(() {});
                    nameController.clear();
                    emailController.clear();
                    contactNumberController.clear();
                    subjectController.clear();
                    schoolController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('insert'))
            ],
          ),
        );
      },
    );
  }

  void userDetailsUpdate(UserModel userUpdate) {

    nameController.text = userUpdate.name;
    emailController.text = userUpdate.email;
    contactNumberController.text = userUpdate.contactNum;
    subjectController.text = userUpdate.subject;
    schoolController.text = userUpdate.school;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: [
              Center(
                  child: Text(
                'UserDetailsUpdate',
                style: TextStyle(fontSize: 20),
              )),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _pickImageFromGallery();
                },
                child: CircleAvatar(
                  radius: 60,
                  child: ClipOval(
                    child: _galleryFile != null
                        ? Image.file(
                      _galleryFile!,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    )
                        : Text('No image select'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Email..'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: contactNumberController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'ContactNum..'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: subjectController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'subject'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: schoolController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'School..'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel')),
                    Spacer(),
                    OutlinedButton(
                        onPressed: () {
                          var userModel = UserModel(
                              id: userUpdate.id,
                              name: nameController.text,
                              email: emailController.text,
                              contactNum: contactNumberController.text,
                              subject: subjectController.text,
                              school: schoolController.text,
                              image: _galleryFile!.path);
                          dbService.updateData(userModel).then((_) {
                            setState(() {});
                            nameController.clear();
                            emailController.clear();
                            contactNumberController.clear();
                            subjectController.clear();
                            schoolController.clear();

                            Navigator.pop(context);
                          });
                        },
                        child: Text('Update'))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void deleteMovie(String id) {
    dbService.deleteMovie(id);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Center(
              child: Text(
            'SQFLITE HOMEPASE',
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: FutureBuilder<List<UserModel>>(
            future: dbService.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Movies found'),
                  );
                }
                return
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Card(
                          color: Colors.blueAccent,
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StoreDatapage(),
                                    ));
                              },
                              leading: CircleAvatar(
                                  maxRadius: 30,
                                  backgroundColor: Colors.cyanAccent,
                                  child: InkWell(
                                    child: ClipOval(
                                      child: Image.file(
                                        File(snapshot.data![index].image),
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                              title: Text(snapshot.data![index].name),
                              subtitle: Text(snapshot.data![index].subject),
                              trailing: PopupMenuButton(
                                iconColor: Colors.white,
                                iconSize: 30,
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      onTap: () {
                                        userDetailsUpdate(
                                            snapshot.data![index]);
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.edit),
                                        title: Text('edit'),
                                      )),
                                  PopupMenuItem(
                                      onTap: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Delete documents'),
                                              content: Text(
                                                  'the select documents will be delete'),
                                              actions: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 70, 0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('cancel'),
                                                  ),
                                                ),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    deleteMovie(snapshot
                                                        .data![index].id);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Delete'),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        title: Text('delete'),
                                        leading: Icon(Icons.delete),
                                      )),
                                ],
                              )),
                        ));
              }
              return const Center(
                child: Text('No Movies found'),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            userDetailsAdd();
            nameController.clear();
            subjectController.clear();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
  Future<void> _pickImageFromGallery() async {
    final ImagePicker _pickel = ImagePicker();
    final XFile? image = await _pickel.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _galleryFile = File(image.path);
      });
    }
  }
}
