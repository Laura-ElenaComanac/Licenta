import 'package:flutter/material.dart';
import 'package:projyproject/data/http_helper.dart';
import 'package:projyproject/data/websocket_helper.dart';
import 'package:projyproject/model/user.dart';
import 'package:projyproject/screens/intro_screen.dart';
import 'package:projyproject/screens/login_screen.dart';
import 'package:projyproject/screens/register_screen.dart';
import 'package:projyproject/screens/update_screen.dart';
import 'package:projyproject/view_model/bloc.dart';
import 'package:projyproject/view_model/user_list_view_model.dart';
import 'package:provider/provider.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const title = 'WebSocket Demo';
//     return const MaterialApp(
//       title: title,
//       home: MyHomePage(
//         title: title,
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _controller = TextEditingController();
//   final _channel = WebSocketChannel.connect(
//     Uri.parse('wss://localhost:8080'),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Form(
//               child: TextFormField(
//                 controller: _controller,
//                 decoration: const InputDecoration(labelText: 'Send a message'),
//               ),
//             ),
//             const SizedBox(height: 24),
//             StreamBuilder(
//               stream: _channel.stream,
//               builder: (context, snapshot) {
//                 return Text(snapshot.hasData ? '${snapshot.data}' : '');
//               },
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendMessage,
//         tooltip: 'Send message',
//         child: const Icon(Icons.send),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       _channel.sink.add(_controller.text);
//     }
//   }

//   @override
//   void dispose() {
//     _channel.sink.close();
//     super.dispose();
//   }
// }

////////////

void main() => runApp(const ProjyApp());

// void main() {
//   getUsers();
// }

// void getUsers() async {
//   HttpHelper h = HttpHelper();
//   List<User> users = await h.getUsers();

//   for (var item in users) {
//     print("User: ");
//     print(item);
//   }
// }

class ProjyApp extends StatelessWidget {
  const ProjyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late WebSocketHelper ws;
    return Provider<Bloc>(
        create: (_) {
          Bloc bloc = Bloc();
          ws = WebSocketHelper(bloc);
          return bloc;
        },
        dispose: (_, bloc) => {bloc.close(), ws.dispose()},
        //providers: [ChangeNotifierProvider.value(value: UserListViewModel())],
        child: MaterialApp(
          title: 'Projy',
          routes: {
            '/': (context) => LoginScreen(),
            '/intro': (context) => IntroScreen(),
            '/register': (context) => RegisterScreen(),
            '/update': (context) => UpdateScreen()
          },
          initialRoute: '/',
        ));
  }
}
