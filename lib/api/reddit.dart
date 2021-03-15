import 'dart:async';
import 'package:dio/dio.dart';
import 'package:draw/draw.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart';



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



}