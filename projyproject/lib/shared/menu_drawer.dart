import 'package:flutter/material.dart';
import 'package:projyproject/screens/intro_screen.dart';
import 'package:projyproject/screens/login_screen.dart';
import 'package:projyproject/data/websocket_helper_widget.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = ['Login', 'Home', 'Test'];
    List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
        decoration: BoxDecoration(color: Colors.purple),
        child:
            Text('Menu', style: TextStyle(color: Colors.white, fontSize: 28))));

    menuTitles.forEach((String element) {
      Widget screen = Container();
      menuItems.add(ListTile(
          title: Text(element, style: TextStyle(fontSize: 18)),
          onTap: () {
            switch (element) {
              case 'Home':
                screen = IntroScreen();
                break;
              case 'Login':
                screen = LoginScreen();
                break;
              case 'Test':
                //screen = WebSocketHelperWidget();
                break;
            }
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screen));
          }));
    });
    return menuItems;
  }
}
