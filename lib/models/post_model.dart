// To parse this JSON data, do
//
//     final blog = blogFromMap(jsonString);

import 'dart:convert';

List<PostModel> blogFromMap(String str) => List<PostModel>.from(
      json.decode(str).map(
            (x) => PostModel.fromMap(x),
          ),
    );

String blogToMap(List<PostModel> data) => json.encode(
      List<dynamic>.from(
        data.map((x) => x.toMap()),
      ),
    );

class PostModel {
  final int id;
  final String title;
  final String body;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "body": body,
      };
}
