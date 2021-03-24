import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:draw/draw.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart';
import 'dart:convert';
import 'package:releave_app/models/PostModel.dart';



Future<List<Post>> LeavesPosts(int numPosts) async{
  final userAgent = 'releave';
  final reddit = await Reddit.createScriptInstance(
    clientId: "UmwvVZB9ixzDEA",
    clientSecret: "2wgOJI0RW_RWAF72dBzblJ7mNLUNDw",
    userAgent:  userAgent,
    username: "releave-dev",
    password: "EzgWf7Ym7d!@rX",
  );

  List<Post> postRet = [];
  await reddit.subreddit("leaves").newest(limit:numPosts).toList().then((posts) {
    if(posts != null){
        for(UserContent post in posts){
          postRet.add(new Post.fromJson(json.decode(post.toString())));
        }
      }
    });
  return postRet;
}