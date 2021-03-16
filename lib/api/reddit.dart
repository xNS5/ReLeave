import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:draw/draw.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart';
import 'dart:convert';



Future<void> main() async{
  final userAgent = 'releave';
  final configUri = Uri.parse('draw.ini');
  final reddit = await Reddit.createScriptInstance(
    clientId: "UmwvVZB9ixzDEA",
    clientSecret: "	2wgOJI0RW_RWAF72dBzblJ7mNLUNDw",
    userAgent:  userAgent,
    username: "releave-dev",
    password: "EzgWf7Ym7d!@rX",
  );
  Redditor user = await reddit.user.me();

  print(user.displayName);
  await reddit.subreddit("leaves").newest(limit:2).toList().then((posts) {
    if(posts != null){
      UserContent post;
      for(post in posts){
        Map<String, dynamic> post_json = jsonDecode(post.toString());
        String title = post_json['title'], author = post_json['author'], selftext = post_json['selftext'];
        // ignore: unnecessary_statements
        print("Title: $title Author: $author\r\n$selftext");
      }
    }
  });
  return 0;

}