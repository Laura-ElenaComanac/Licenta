import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projyproject/model/user.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HttpHelper {
  // http://localhost:8080/users

  final String authority = 'localhost:8080';
  final String path = 'users';

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://localhost:8080/app/destination'),
  );

  void readUsers() async {
    Uri uri = Uri.http(authority, path);
    var contents = await http.read(uri);
    print(contents);
  }

  Future<List<User>> getUsers() async {
    Uri uri = Uri.http(authority, path);
    http.Response result = await http.get(uri);

    var data = json.decode(result.body) as List;
    List<User> users = data.map((e) => User.fromJson(e)).toList();

    return users;
  }
}
