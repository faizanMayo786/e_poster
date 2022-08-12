import 'dart:convert';

// Blog Model
class Blog {
  Blog({
    required this.title,
    required this.description,
    required this.username,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
  });

  String description;
  String title;
  String username;
  String uid;
  String postId;
  final String datePublished;
  String postUrl;
  factory Blog.fromJson(String str) => Blog.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  factory Blog.fromMap(Map<String, dynamic> json) => Blog(
        title: json["title"],
        description: json["description"],
        username: json["username"],
        uid: json["uid"],
        postId: json["postId"],
        datePublished: json["datePublished"],
        postUrl: json["postUrl"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "username": username,
        "uid": uid,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
      };
}
