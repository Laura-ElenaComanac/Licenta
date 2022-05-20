import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:projyproject/data/http_helper.dart';
import 'package:projyproject/data/websocket_helper_widget.dart';
import 'package:projyproject/repository/database.dart';
import 'package:projyproject/model/user.dart';

class Bloc {
  late final Stream<List<UserEntry>> _users;
  late final Stream<List<LoggedUserEntry>> _logged_user;

  Stream<List<UserEntry>> get homeScreenEntries => _users;
  Stream<List<LoggedUserEntry>> get loggedUserEntry => _logged_user;
  late UserEntry _user;

  //String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late HttpHelper h = HttpHelper();
  var logger = Logger();
  final Database db;

  Bloc() : db = Database() {
    //db.deleteAllUsers();
    _logged_user = db.watchLoggedUser();
    _users = db.watchUsers();
    updateUsersDB();
  }

  Future<void> _updateConnectionStatus(
      ConnectivityResult result, LocalUsersCompanion user) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        {
          logger.d('status: online... adding: ' + user.toString());
          User myuser = User(
              id: '',
              username: user.username.value,
              password: user.password.value,
              firstname: user.firstname.value,
              lastname: user.lastname.value,
              gender: user.gender.value,
              location: user.location.value,
              birthday: user.birthday.value,
              email: user.email.value);

          h.addUser(myuser).then((value) {
            if (value != null) {
              logger.d('Added user to server: ' + myuser.toString());
              db.deleteUser(UserEntry(
                  id: user.id.value,
                  username: user.username.value,
                  password: user.password.value,
                  firstname: user.firstname.value,
                  lastname: user.lastname.value,
                  gender: user.gender.value,
                  location: user.location.value,
                  birthday: user.birthday.value,
                  email: user.email.value));
              db.insertUser(LocalUsersCompanion.insert(
                  id: value.id,
                  username: value.username,
                  password: value.password,
                  firstname: value.firstname,
                  lastname: value.lastname,
                  gender: value.gender.toString(),
                  location: value.location.toString(),
                  birthday: value.birthday.toString(),
                  email: value.email.toString()));
            } else {
              logger.d('failed to send user to server');
            }
          });
          break;
        }
      case ConnectivityResult.none:
        {
          logger.d('status: offline');
          break;
        }
      default:
        logger.d('Failed to get connectivity.');
        break;
    }
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
            gender: user.gender.toString(),
            location: user.location.toString(),
            birthday: user.birthday.toString(),
            email: user.email);

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
            gender: user.gender.toString(),
            location: user.location.toString(),
            birthday: user.birthday.toString(),
            email: user.email.toString());

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

  Future<bool> addEntry(LocalUsersCompanion user) async {
    try {
      logger.d('Adding given user: ' + user.toString());

      User myuser = User(
          id: '',
          username: user.username.value,
          password: user.password.value,
          firstname: user.firstname.value,
          lastname: user.lastname.value,
          gender: user.gender.value,
          email: user.email.value,
          birthday: user.birthday.value,
          location: user.location.value);

      LocalUsersCompanion userr;

      h.addUser(myuser).then((value) => {
            if (value != null)
              {
                logger.d('Added user to server: ' + myuser.toString()),
                //print(_connectionStatus)
                // db.insertUser(LocalUsersCompanion.insert(
                //     id: value.id,
                //     username: value.username,
                //     password: value.password,
                //     firstname: value.firstname,
                //     lastname: value.lastname,
                //     gender: value.gender)),
                //
                //logger.d('Added user in local db: ' + value.toString())
              }
            else
              {
                userr = LocalUsersCompanion.insert(
                    id: 'str' + Random().nextInt(1000000).toString(),
                    username: user.username.value,
                    password: user.password.value,
                    firstname: user.firstname.value,
                    lastname: user.lastname.value,
                    gender: user.gender.value,
                    email: user.email.value,
                    birthday: user.birthday.value,
                    location: user.location.value),
                db.insertUser(userr),
                logger.d('Added fake user in local db: ' + userr.toString()),
                _connectivitySubscription = _connectivity.onConnectivityChanged
                    .listen((ConnectivityResult result) {
                  _updateConnectionStatus(result, userr);
                }),
                _logged_user = db.watchLoggedUser()
              }
          });
    } catch (error) {
      logger.d('Error Adding given user: ' + error.toString());
      throw Failure(error.toString());
    }

    var connectivityResult = await (Connectivity().checkConnectivity());
    logger.d('Connectivity: ' + connectivityResult.toString());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  void addDBEntry(LocalUsersCompanion user) {
    try {
      db.insertUser(user);
      logger.d('Added user in local db: ' + user.toString());
    } catch (error) {
      logger.d('Error Adding db user: ' + error.toString());
      throw Failure(error.toString());
    }
  }

  void addLoggedUser(LoggedUserCompanion user) {
    try {
      db.insertLoggedUser(user);
      logger.d('Added logged user in local db: ' + user.toString());
    } catch (error) {
      logger.d('Error Adding logged db user: ' + error.toString());
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
          gender: entry.gender,
          location: entry.location,
          birthday: entry.birthday,
          email: entry.email);

      h.updateUser(myuser).then((value) => {
            if (value != null)
              {
                logger.d('Updated user to server: ' + myuser.toString()),
                //print(_connectionStatus)
                // db.insertUser(LocalUsersCompanion.insert(
                //     id: value.id,
                //     username: value.username,
                //     password: value.password,
                //     firstname: value.firstname,
                //     lastname: value.lastname,
                //     gender: value.gender)),
                //
                //logger.d('Added user in local db: ' + value.toString())
              }
            else
              {
                db.updateUserById(UserEntry(
                    id: value!.id,
                    username: value.username,
                    password: value.password,
                    firstname: value.firstname,
                    lastname: value.lastname,
                    gender: value.gender.toString(),
                    location: entry.location,
                    birthday: entry.birthday,
                    email: entry.email)),
                logger.d('Updated user in local db: ' + value.toString())
              }
          });
    } catch (error) {
      logger.d('Error Updating given user: ' + error.toString());
      throw Failure(error.toString());
      //print(error);
    }
  }

  void updateDBEntry(LocalUsersCompanion user) {
    try {
      db.updateUser(UserEntry(
          id: user.id.value,
          username: user.username.value,
          password: user.password.value,
          firstname: user.firstname.value,
          lastname: user.lastname.value,
          gender: user.gender.toString(),
          location: user.location.value,
          birthday: user.birthday.value,
          email: user.email.value));
      logger.d('Updated user in local db: ' + user.toString());
    } catch (error) {
      logger.d('Error Updating db user: ' + error.toString());
      throw Failure(error.toString());
    }
  }

  void deleteEntry(String id) {
    try {
      logger.d('Deleting user with the given id: ' + id);

      h.deleteUser(id).then((value) => {
            db.deleteUserById(value),
            logger.d('Deleted user with the given id: ' + value)
          });
      // db.deleteUserById(id);
    } catch (error) {
      logger.d('Error Deleting given user: ' + error.toString());
      throw Failure(error.toString());
    }
  }

  void deleteDBEntry(String id) {
    try {
      logger.d('Deleting user with the given id: ' + id);
      db.deleteUserById(id);
    } catch (error) {
      logger.d('Error Deleting db user: ' + error.toString());
      throw Failure(error.toString());
    }
  }

  Future<List<UserEntry>> getEntries() {
    return db.getUsers();
  }

  Future<LoggedUserEntry> getLoggedUser() {
    return db.getLoggedUser().then((value) => value.first);
  }

  Future<List<UserEntry>?> getUserByUsernameAndPassword(
      String username, String password) async {
    try {
      return db.userByUsernameAndPassword(username, password);
    } catch (error) {
      return null;
    }
  }

  void close() {
    db.close();
    _connectivitySubscription.cancel();
  }
}

class Failure extends IOException {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
