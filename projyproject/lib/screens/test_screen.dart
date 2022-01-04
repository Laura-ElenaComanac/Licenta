// import 'package:flutter/material.dart';
// import 'package:projyproject/model/user.dart';
// import '../data/http_helper.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   _TestScreenState createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   String result = '';

//   HttpHelper h = HttpHelper();

//   // User user = User(
//   //   id: "",
//   //   username: "",
//   //   password: "",
//   //   firstname: "",
//   //   lastname: "",
//   //   gender: "");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Test'),
//         ),
//         body: StreamBuilder(
//           stream: h.channel.stream,
//           builder: (context, snapshot) {
//             return Text(snapshot.hasData ? '${snapshot.data}' : 'none');
//           },
//         ));
//   }
// }
