import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:draw/draw.dart';


Future<void> main() async{
  final userAgent = 'releave-test';
  final configUri = Uri.parse('draw.ini');
  final reddit = Reddit.createInstalledFlowInstance(userAgent: userAgent,
      configUri: configUri);
  final auth_url = reddit.auth.url(['*'], 'foobar');
  print(auth_url);

try{
  await reddit.auth.authorize("Y7zUyKlP6u6_T1PZdEJ89d0rVffm3Q");
}catch(e){
  print(e.toString());
}

  print(await reddit.user.me());
}