import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DatabaseService.dart';
import 'Model_Page.dart';

class StoreDatapage extends StatefulWidget {
  const StoreDatapage({super.key});

  @override
  State<StoreDatapage> createState() => _StoreDatapageState();
}

class _StoreDatapageState extends State<StoreDatapage> {
  final dbService = DatabaseServices();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
         appBar: AppBar(title:Text('Store') ,),
        body: FutureBuilder<List<UserModel>>(
            future: dbService.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return  const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Movies found'),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Card(
                          color: Colors.blueAccent,
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                              // title: Text(snapshot.data![index].name),
                              // subtitle: Text(snapshot.data![index].subject),
                            title: Column(children: [
                              Text(snapshot.data![index].name),
                              Text(snapshot.data![index].email),
                              Text(snapshot.data![index].contactNum),
                              Text(snapshot.data![index].subject),
                              Text(snapshot.data![index].school),
                            ],),
                          ),
                        ));
              }
              return const Center(
                child: Text('No Movies found'),
              );
            }),

      ),
    );
  }
}
