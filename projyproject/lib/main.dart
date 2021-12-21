import 'package:flutter/material.dart';
import 'package:projyproject/screens/intro_screen.dart';
import 'package:projyproject/screens/login_screen.dart';
import 'package:projyproject/screens/register_screen.dart';
import 'package:projyproject/screens/update_screen.dart';
import 'package:projyproject/view_model/bloc.dart';
import 'package:projyproject/view_model/user_list_view_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(const ProjyApp());

class ProjyApp extends StatelessWidget {
  const ProjyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<Bloc>(
        create: (_) => Bloc(),
        dispose: (_, bloc) => bloc.close(),
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
