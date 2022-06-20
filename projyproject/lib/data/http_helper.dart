import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:projyproject/model/user.dart';
import 'package:projyproject/model/userpost.dart';
import 'package:projyproject/repository/database.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../model/post.dart';

class HttpHelper {
  // http://localhost:8080/users

  var logger = Logger();

  //final String authority = 'http://localhost:8080'; // obtain
  final String authority =
      '192.168.0.118:8080'; // system prefereneces -> network -> ip adress
  final String path = 'users';
  final String addpath = 'user/add';
  final String updatepath = 'user/update';
  final String deletepath = 'user/delete';

  final String post_path = 'posts';
  final String post_addpath = 'post/add';
  final String post_filter = 'post/filter';

  // final channel = WebSocketChannel.connect(
  //   Uri.parse('ws://localhost:8080/topic/destination'),
  // );

  void readUsers() async {
    Uri uri = Uri.http(authority, path);
    var contents = await http.read(uri);
    print(contents);
  }

  Future<List<User>> getUsers() async {
    logger.d('Getting users from the server');

    List<User> users = [];

    try {
      Uri uri = Uri.http(authority, path);
      http.Response result = await http.get(uri);

      var data = json.decode(result.body) as List;

      for (var user in data) {
        User myuser = User.fromJson(user);
        users.add(myuser);
      }

      logger.d('Got users from the server: ' + data.toString());
    } catch (e) {
      logger.d("http helper getUsers error: " + e.toString());
    }

    // http.Response response = await http.get(uri, headers: {
    //   "Accept": "application/json",
    //   "Access-Control_Allow_Origin": "*"
    // });

    return users;
  }

  Future<List<Post>> getPosts() async {
    logger.d('Getting posts from the server');

    List<Post> posts = [];

    try {
      Uri uri = Uri.http(authority, post_path);
      http.Response result = await http.get(uri);

      logger.d('getPosts !!! http result:' + result.toString());

      var data = json.decode(result.body) as List;

      logger.d('getPosts !!! http data:' + data.toString());

      for (var post in data) {
        Post mypost = Post.fromJson(post);
        posts.add(mypost);
      }

      logger.d('Got posts from the server: ' + data.toString());
    } catch (e) {
      logger.d("http helper getPosts error: " + e.toString());
    }

    return posts;
  }

  Future<List<UserPost>> getUserPosts(String userid) async {
    Map<String, dynamic> parameters = {
      'userid': userid.toString(),
    };

    logger.d('Getting user posts from the server ');

    List<UserPost> posts = [];

    try {
      Uri uri = Uri.http(authority, post_filter, parameters);
      http.Response result = await http.get(uri);

      logger.d('getUserPosts !!! http result:' + result.toString());

      var data = json.decode(result.body) as List;

      logger.d('getUserPosts !!! http data:' + data.toString());

      for (var post in data) {
        UserPost mypost = UserPost.fromJson(post);
        posts.add(mypost);
      }

      logger.d('Got user posts from the server: ' + data.toString());
    } catch (e) {
      logger.d("http helper getUserPosts error: " + e.toString());
    }

    return posts;
  }

  Future<User?> getUserByUsernameAndPassword(
      String username, String password) async {
    Map<String, dynamic> parameters = {
      'username': username,
      'password': password,
    };
    logger.d('Getting user from the server');

    User? user;

    try {
      Uri uri = Uri.http(authority, 'user/pass', parameters);
      http.Response result = await http.get(uri);

      var data = json.decode(result.body);
      user = User.fromJson(data);

      logger.d('Got user from the server: ' + data.toString());
    } catch (e) {
      logger.d("http helper getUsers error: " + e.toString());
    }

    // http.Response response = await http.get(uri, headers: {
    //   "Accept": "application/json",
    //   "Access-Control_Allow_Origin": "*"
    // });

    return user;
  }

  Future<User?> addUser(User usera) async {
    Map<String, dynamic> parameters = {
      'id': usera.id,
      'username': usera.username,
      'password': usera.password,
      'firstName': usera.firstname,
      'lastName': usera.lastname,
      'gender': usera.gender,
      'email': usera.email,
      'birthday': usera.birthday,
      'location': usera.location
    };

    User? myuser;
    try {
      Uri uri = Uri.http(authority, addpath, parameters);
      http.Response result = await http.post(uri);

      var data = json.decode(result.body);
      myuser = User.fromJson(data);
    } catch (error) {
      logger.d("http helper addUser error: " + error.toString());
      return null;
    }

    logger.d("added http helper user: " + myuser.toString());
    return myuser;
  }

  Future<Post?> addPost(Post posta, String userid) async {
    Map<String, dynamic> parameters = {
      'id': posta.id,
      'userid': userid,
      'title': posta.title,
      'description': posta.description,
      'date': posta.date
    };

    Post? mypost;
    try {
      logger.d('Parameters in addPost: ' + parameters.toString());

      Uri uri = Uri.http(authority, post_addpath, parameters);
      http.Response result = await http.post(uri);

      logger.d('addPost !!! http result:' + result.toString());

      var data = json.decode(result.body);

      logger.d('addPost !!! http data:' + data.toString());

      mypost = Post.fromJson(data);
    } catch (error) {
      logger.d("http helper addPost error: " + error.toString());
      return null;
    }

    logger.d("added http helper post: " + mypost.toString());
    return mypost;
  }

  Future<User?> updateUser(User usera) async {
    Map<String, dynamic> parameters = {
      'id': usera.id,
      'username': usera.username,
      'password': usera.password,
      'firstName': usera.firstname,
      'lastName': usera.lastname,
      'gender': usera.gender,
      'email': usera.email,
      'birthday': usera.birthday,
      'location': usera.location
    };

    logger.d(usera);

    User? myuser;
    try {
      Uri uri = Uri.http(authority, updatepath, parameters);
      http.Response result = await http.put(uri);

      logger.d('result!!! ' + result.body.toString());

      var data = json.decode(result.body);
      myuser = User.fromJson(data);
    } catch (error) {
      logger.d("http helper updateUser error: " + error.toString());
      return null;
    }

    logger.d("updated http helper user: " + myuser.toString());
    return myuser;
  }

  Future<String> deleteUser(String id) async {
    Map<String, dynamic> parameters = {'id': id};

    Uri uri = Uri.http(authority, deletepath, parameters);
    http.Response result = await http.delete(uri);

    return result.body;
  }
}
