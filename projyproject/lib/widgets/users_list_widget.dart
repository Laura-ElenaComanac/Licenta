import 'package:flutter/material.dart';
import 'package:projyproject/data/websocket_helper.dart';
import 'package:projyproject/model/post.dart';
import 'package:projyproject/repository/database.dart';
import 'package:projyproject/model/user.dart';
import 'package:projyproject/view_model/bloc.dart';
import 'package:projyproject/view_model/user_list_view_model.dart';
import 'package:provider/provider.dart';

class UsersListWidget extends StatefulWidget {
  //final UserEntry entry;
  final List<PostEntry> posts;
  final Function deleteFunction;
  const UsersListWidget(this.posts, this.deleteFunction, {Key? key})
      : super(key: key);

  @override
  _UsersListWidgetState createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  Bloc get bloc => Provider.of<Bloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        clipBehavior: Clip.antiAlias,
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          final mypost = Post(
              id: widget.posts[index].id.toString(),
              title: widget.posts[index].title,
              description: widget.posts[index].description,
              date: widget.posts[index].date,
              userid: widget.posts[index].userid);

          return Dismissible(
              key: UniqueKey(),
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text(
                          "Are you sure you wish to delete this item?"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("DELETE")),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("CANCEL"),
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (direction) {
                widget.deleteFunction(index);
              },
              background: Container(color: Colors.red),
              child: StreamBuilder(builder: (context, snapshot) {
                return Card(
                    shadowColor: Colors.black,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Color.fromARGB(255, 102, 59, 223),
                              Color.fromARGB(255, 135, 134, 231),
                              Color.fromARGB(255, 135, 134, 231),
                              (Colors.white),
                              //Color.fromARGB(255, 135, 134, 231),
                              //Color.fromARGB(255, 102, 59, 223)
                            ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                textColor: Colors.white,
                                //Color.fromARGB(255, 102, 59, 223),
                                title: Text(
                                  widget.posts[index].title,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ListTile(
                                textColor: Colors.white,
                                title: Text(
                                  widget.posts[index].description,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Row(
                                  //mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: ListTile(
                                          textColor: Colors.white,
                                          title: FutureBuilder<String>(
                                              future:
                                                  bloc.getUsernamePostByUserId(
                                                      widget
                                                          .posts[index].userid),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    //widget.posts[index].username,
                                                    snapshot.data!,
                                                    textAlign: TextAlign.left,
                                                  );
                                                } else {
                                                  return Text('anonymous');
                                                }
                                              })),
                                    ),
                                    Expanded(
                                        child: ListTile(
                                      textColor: Colors.white,
                                      title: Text(
                                        widget.posts[index].date,
                                        textAlign: TextAlign.right,
                                      ),
                                    ))
                                  ])
                            ],
                          ),
                        )));
              }));
        });
  }
}
