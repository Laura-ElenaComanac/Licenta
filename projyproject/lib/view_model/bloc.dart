import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:projyproject/data/http_helper.dart';
import 'package:projyproject/repository/database.dart';
import 'package:projyproject/model/user.dart';

class Bloc {
  final Database db;

  late final Stream<List<UserEntry>> _users;

  late UserEntry _user;

  HttpHelper h = HttpHelper();

  Stream<List<UserEntry>> get homeScreenEntries => _users;

  var logger = Logger();

  Bloc() : db = Database() {
    //ckeckConnection();
    updateUsersDB();
    _users = db.watchUsers();
  }

  // void ckeckConnection() async {
  //   try {
  //     final result = await InternetAddress.lookup('localhost:8080');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       print('connected');
  //     }
  //   } on SocketException catch (_) {
  //     print('not connected');
  //   }
  // }

  void updateUsersDB() async {
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

      logger.d('Added user to server: ' + myuser.toString());

      h.addUser(myuser).then((value) => {
            if (value != null)
              {
                db.insertUser(LocalUsersCompanion.insert(
                    id: value.id,
                    username: value.username,
                    password: value.password,
                    firstname: value.firstname,
                    lastname: value.lastname,
                    gender: value.gender)),
                logger.d('Added user in local db: ' + value.toString())
              }
          });
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

      logger.d('Updated user to server: ' + myuser.toString());

      h.updateUser(myuser).then((value) => {
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

      h.deleteUser(id).then((value) => {
            db.deleteUserById(value),
            logger.d('Deleted user with the given id: ' + value)
          });
      //db.deleteUserById(id);
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
