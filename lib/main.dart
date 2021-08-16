import 'package:example_http_request/post_model.dart';
import 'package:flutter/material.dart';

import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PostModel? postModel;
  User? user;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  String textData = 'data tidak ada';
  String userData = 'user tidak ada';
  String listUser = 'list user tidak ada';
  String avatar = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTTP Request Example'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(textData),
                Text(userData),
                Text(listUser),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: jobController,
                  decoration: InputDecoration(
                      hintText: 'job',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
                ElevatedButton(
                  child: Text('Post'),
                  onPressed: () {
                    PostModel.connectApi(nameController.text.toString(),
                            jobController.text.toString())
                        .then((value) {
                      postModel = value;
                      textData = '${postModel!.name} | ${postModel!.job}';

                      setState(() {});
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('Get'),
                  onPressed: () {
                    User.connectApi('2').then((value) {
                      setState(() {
                        user = value;
                        avatar = user!.avatar!;
                        userData =
                            '${user!.id} | ${user!.firstName} ${user!.lastName}';
                      });
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('Get List User'),
                  onPressed: () {
                    User.getUsers('2').then((value) {
                      for (var i = 0; i < value.length; i++) {
                        listUser = listUser + '${value[i].firstName!} | ';
                      }
                      setState(() {});
                    });
                  },
                ),
                Image.network(
                  avatar,
                  width: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
