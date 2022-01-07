import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:projyproject/model/user.dart';
import 'package:projyproject/repository/database.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HttpHelper {
  // http://localhost:8080/users

  final String authority = 'localhost:8080';
  final String path = 'users';
  final String addpath = 'user/add';
  final String updatepath = 'user/update';
  final String deletepath = 'user/delete';

  late final Database db;

  var logger = Logger();

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
      print(e);
    }

    // http.Response response = await http.get(uri, headers: {
    //   "Accept": "application/json",
    //   "Access-Control_Allow_Origin": "*"
    // });

    return users;
  }

  Future<User?> addUser(User usera) async {
    Map<String, dynamic> parameters = {
      'id': usera.id,
      'username': usera.username,
      'password': usera.password,
      'firstName': usera.firstname,
      'lastName': usera.lastname,
      'gender': usera.gender
    };

    User? myuser;

    try {
      Uri uri = Uri.http(authority, addpath, parameters);
      http.Response result = await http.post(uri);

      var data = json.decode(result.body);
      myuser = User.fromJson(data);
    } catch (e) {
      var rng = Random();

      db.insertUser(LocalUsersCompanion.insert(
          id: 'str' + rng.nextInt(1000000).toString(),
          username: usera.username,
          password: usera.password,
          firstname: usera.firstname,
          lastname: usera.lastname,
          gender: usera.gender));

      logger.d('Added fake user in local db: ' + myuser.toString());

      //thread
      print(e);
    }

    return myuser;
  }

  Future<User> updateUser(User usera) async {
    Map<String, dynamic> parameters = {
      'id': usera.id,
      'username': usera.username,
      'password': usera.password,
      'firstName': usera.firstname,
      'lastName': usera.lastname,
      'gender': usera.gender
    };

    Uri uri = Uri.http(authority, updatepath, parameters);
    http.Response result = await http.put(uri);

    var data = json.decode(result.body);
    User myuser = User.fromJson(data);

    return myuser;
  }

  Future<String> deleteUser(String id) async {
    Map<String, dynamic> parameters = {'id': id};

    Uri uri = Uri.http(authority, deletepath, parameters);
    http.Response result = await http.delete(uri);

    return result.body;
  }
}
