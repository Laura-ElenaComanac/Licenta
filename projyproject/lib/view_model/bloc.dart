import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:projyproject/data/http_helper.dart';
import 'package:projyproject/data/websocket_helper_widget.dart';
import 'package:projyproject/repository/database.dart';
import 'package:projyproject/model/user.dart';

class Bloc {
  final Database db;

  late final Stream<List<UserEntry>> _users;

  late UserEntry _user;

  HttpHelper h = HttpHelper();

  Stream<List<UserEntry>> get homeScreenEntries => _users;

  var logger = Logger();

  //WebSocketHelper webSocketHelper = const WebSocketHelper();

  Bloc() : db = Database() {
    updateUsersDB();
    _users = db.watchUsers();
  }

  void setUsers(List<User> users) async {
    List<UserEntry> localUsers = await db.getUsers();

    for (var user in users) {
      bool found = false;

      for (var localuser in localUsers) {
        if (user.id == localuser.id) found = true;
      }

      if (!found) {
        logger.d('Getting user: ' + user.toString());

        final userC = LocalUsersCompanion.insert(
            id: user.id,
            username: user.username,
            password: user.password,
            firstname: user.firstname,
            lastname: user.lastname,
            gender: user.gender);

        db.insertUser(userC);

        logger.d('Inserted user: ' + userC.toString());
      }
    }
  }

  void updateUsersDB() async {
    logger.d("updateUsersDB");

    List<User> users = await h.getUsers();
    List<UserEntry> localUsers = await db.getUsers();

    for (var user in users) {
      bool found = false;

      for (var localuser in localUsers) {
        if (user.id == localuser.id) found = true;
      }

      if (!found) {
        logger.d('Getting user: ' + user.toString());

        final userC = LocalUsersCompanion.insert(
            id: user.id,
            username: user.username,
            password: user.password,
            firstname: user.firstname,
            lastname: user.lastname,
            gender: user.gender);

        db.insertUser(userC);

        logger.d('Inserted user: ' + userC.toString());
      }
    }
  }

  UserEntry get user {
    return _user;
  }

  void setUser(UserEntry user) {
    _user = user;
  }

  void addEntry(LocalUsersCompanion user) {
    try {
      logger.d('Adding given user: ' + user.toString());

      User myuser = User(
          id: '',
          username: user.username.value,
          password: user.password.value,
          firstname: user.firstname.value,
          lastname: user.lastname.value,
          gender: user.gender.value);

      h.addUser(myuser).then((value) => {
            if (value != null)
              {
                logger.d('Added user to server: ' + myuser.toString()),
                // db.insertUser(LocalUsersCompanion.insert(
                //     id: value.id,
                //     username: value.username,
                //     password: value.password,
                //     firstname: value.firstname,
                //     lastname: value.lastname,
                //     gender: value.gender)),
                //logger.d('Added user in local db: ' + value.toString())
              }
          });
    } catch (error) {
      throw Failure(error.toString());
    }
  }

  void addDBEntry(LocalUsersCompanion user) {
    try {
      db.insertUser(user);
      logger.d('Added user in local db: ' + user.toString());
    } catch (error) {
      throw Failure(error.toString());
    }
  }

  void updateEntry(UserEntry entry) async {
    try {
      logger.d('Updating given user: ' + entry.toString());

      User myuser = User(
          id: entry.id.toString(),
          username: entry.username,
          password: entry.password,
          firstname: entry.firstname,
          lastname: entry.lastname,
          gender: entry.gender);

      h.updateUser(myuser).then((value) => {
            logger.d('Updated user to server: ' + myuser.toString()),
            db.updateUserById(UserEntry(
                id: value.id,
                username: value.username,
                password: value.password,
                firstname: value.firstname,
                lastname: value.lastname,
                gender: value.gender)),
            logger.d('Updated user in local db: ' + value.toString())
          });
    } catch (error) {
      // logger.d('Error Updating given user: ' + error.toString());
      // throw Failure(error.toString());
      print(error);
    }
  }

  void deleteEntry(String id) {
    try {
      logger.d('Deleting user with the given id: ' + id);

      // h.deleteUser(id).then((value) => {
      //       db.deleteUserById(value),
      //       logger.d('Deleted user with the given id: ' + value)
      //     });
      db.deleteUserById(id);
    } catch (error) {
      throw Failure(error.toString());
    }
  }

  Future<List<UserEntry>> getEntries() {
    return db.getUsers();
  }

  void close() {
    db.close();
  }
}

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
