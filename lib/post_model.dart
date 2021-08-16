import 'dart:convert';

import 'package:http/http.dart' as http;

class PostModel {
  String? id;
  String? name;
  String? job;
  String? created;

  PostModel({this.id, this.name, this.job, this.created});

  factory PostModel.createPostResult(Map<String, dynamic> object) {
    return PostModel(
        id: object['id'],
        name: object['name'],
        job: object['job'],
        created: object['createdAt']);
  }

  static Future<PostModel> connectApi(String name, String job) async {
    String apiUrl = 'https://reqres.in/api/users';

    var apiResult =
        await http.post(Uri.parse(apiUrl), body: {'name': name, 'job': job});

    var jsonObject = json.decode(apiResult.body);

    return PostModel.createPostResult(jsonObject);
  }
}
