import 'dart:convert';
import 'dart:io';

import 'package:frazex_task/models/post.dart';
import 'package:http/http.dart';

import '../models/http_response.dart';

class APIHelper {
  static Future<HTTPResponse<List<Post>>> getPosts() async {
    try {
      var url = 'https://jsonplaceholder.typicode.com/posts';
      var response = await get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Post> posts = [];
        body.forEach((e) {
          Post post = Post.fromJson(e);
          posts.add(post);
        });
        return HTTPResponse<List<Post>>(
          true,
          posts,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<Post>>(
          false,
          null,
          message: 'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<Post>>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<Post>>(
        false,
        null,
        message: 'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<Post>>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }
}
