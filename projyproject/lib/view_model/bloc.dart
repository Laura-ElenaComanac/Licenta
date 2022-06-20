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
import 'package:projyproject/model/userpost.dart';
import 'package:projyproject/repository/database.dart';
import 'package:projyproject/model/user.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../model/post.dart';

class Bloc {
  late final Stream<List<UserEntry>> _users;
  late final Stream<List<PostEntry>> _posts;
  late final Stream<List<LoggedUserEntry>> _logged_user;
  late final Stream<List<PostEntry>> _userposts;

  late PostEntry _post;

  PostEntry get post {
    return _post;
  }

  void setPost(PostEntry post) {
    _post = post;
  }

  //Stream<List<UserEntry>> get homeScreenEntries => _users;
  Stream<List<PostEntry>> get homeScreenEntries => _posts;
  Stream<List<LoggedUserEntry>> get loggedUserEntry => _logged_user;
  Stream<List<PostEntry>> get userPosts => _userposts;

  //String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  late HttpHelper h = HttpHelper();
  var logger = Logger();
  final Database db;

  Bloc() : db = Database() {
    //db.deleteAllUsers();
    _posts = db.watchPosts();
    _users = db.watchUsers();
    _logged_user = db.watchLoggedUser();
    updateUsersDB();
    updatePostsDB();
  }

  Future<void> _updatePostConnectionStatus(
      ConnectivityResult result, LocalPostsCompanion post) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        {
          logger.d('status: online... adding: ' + post.toString());
          Post mypost = Post(
              id: '',
              title: post.title.value,
              description: post.description.value,
              date: post.date.value,
              userid: post.userid.value);

          _logged_user.first.then((value) {
            h.addPost(mypost, value.first.id).then((value) {
              if (value != null) {
                logger.d('Added post to server: ' + mypost.toString());
                db.deletePost(PostEntry(
                    id: post.id.value,
                    title: post.title.value,
                    description: post.description.value,
                    date: post.date.value,
                    userid: post.userid.value));
                db.insertPost(LocalPostsCompanion.insert(
                    id: value.id,
                    title: value.title,
                    description: value.description,
                    date: value.date,
                    userid: value.userid));
              } else {
                logger.d('failed to send post to server');
              }
            });
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

  Future<bool> addPostEntry(LocalPostsCompanion post) async {
    try {
      logger.d('Adding given post: ' + post.toString());

      Post mypost = Post(
          id: '',
          title: post.title.value,
          description: post.description.value,
          date: post.date.value,
          userid: post.userid.value);

      LocalPostsCompanion postt;

      _logged_user.first.then((value) {
        h.addPost(mypost, value.first.id).then((value) => {
              if (value != null)
                {
                  logger.d('Added post to server: ' + mypost.toString()),
                }
              else
                {
                  postt = LocalPostsCompanion.insert(
                      id: 'str' + Random().nextInt(1000000).toString(),
                      title: post.title.value,
                      description: post.description.value,
                      date: post.date.value,
                      userid: post.userid.value),
                  db.insertPost(postt),
                  logger.d('Added fake post in local db: ' + postt.toString()),
                  _connectivitySubscription = _connectivity
                      .onConnectivityChanged
                      .listen((ConnectivityResult result) {
                    _updatePostConnectionStatus(result, postt);
                  }),
                }
            });
      });
    } catch (error) {
      logger.d('Error Adding given post: ' + error.toString());
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

  Future<void> _updateUserConnectionStatus(
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

  Future<bool> addUserEntry(LocalUsersCompanion user) async {
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
                addLoggedUser(LoggedUserCompanion.insert(
                    id: value.id,
                    username: value.username,
                    password: value.password,
                    firstname: value.firstname,
                    lastname: value.lastname,
                    gender: value.gender,
                    email: value.email,
                    birthday: value.birthday,
                    location: value.location)),
                logger.d('Added logged user in Register!'),
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
                LoggedUserCompanion.insert(
                    id: userr.id.value,
                    username: userr.username.value,
                    password: userr.password.value,
                    firstname: userr.firstname.value,
                    lastname: userr.lastname.value,
                    gender: userr.gender.value,
                    email: userr.email.value,
                    birthday: userr.birthday.value,
                    location: userr.location.value),
                logger.d('Added logged user in fake db Register!'),
                _connectivitySubscription = _connectivity.onConnectivityChanged
                    .listen((ConnectivityResult result) {
                  _updateUserConnectionStatus(result, userr);
                }),
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

  void updatePostsDB() async {
    logger.d("updatePostsDB");

    List<Post> posts = await h.getPosts();
    List<PostEntry> localPosts = await db.getPosts();

    for (var post in posts) {
      bool found = false;

      for (var localpost in localPosts) {
        if (post.id == localpost.id) found = true;
      }

      if (!found) {
        logger.d('Getting post: ' + post.toString());

        final postC = LocalPostsCompanion.insert(
            id: post.id,
            title: post.title,
            description: post.description,
            date: post.date,
            userid: post.userid);

        db.insertPost(postC);

        logger.d('Inserted post: ' + postC.toString());
      }
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

  void addDBPostEntry(LocalPostsCompanion post) {
    try {
      db.insertPost(post);
      logger.d('Added post in local db: ' + post.toString());
    } catch (error) {
      logger.d('Error Adding db post: ' + error.toString());
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

  // Future<LoggedUserEntry> getLoggedUser(LoggedUserCompanion user) {
  //   return _logged_user.first.then((value) => value.first);
  // }

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
                addLoggedUser(LoggedUserCompanion.insert(
                    id: value.id,
                    username: value.username,
                    password: value.password,
                    firstname: value.firstname,
                    lastname: value.lastname,
                    gender: value.gender,
                    email: value.email,
                    birthday: value.birthday,
                    location: value.location)),
                logger.d('Added logged user in Update!'),
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

  void deleteDBPostEntry(String id) {
    try {
      logger.d('Deleting post with the given id: ' + id);
      db.deletePostById(id);
    } catch (error) {
      logger.d('Error Deleting db post: ' + error.toString());
      throw Failure(error.toString());
    }
  }

  Future<List<UserEntry>> getEntries() {
    return db.getUsers();
  }

  Future<List<UserPost>?> getUserPosts() async {
    try {
      String id = await getLoggedUserId();
      return await h.getUserPosts(id);
    } catch (error) {
      logger.d('getUserPosts error ' + error.toString());
      return null;
    }
  }

  Future<LoggedUserEntry> getLoggedUser() {
    return db.getLoggedUser().then((value) => value.first);
  }

  Future<String> getLoggedUserId() {
    return db.getLoggedUser().then((value) => value.first.id);
  }

  Future<User?> getUserByUsernameAndPassword(
      String username, String password) async {
    try {
      //return db.userByUsernameAndPassword(username, password);
      return h.getUserByUsernameAndPassword(username, password);
    } catch (error) {
      return null;
    }
  }

  Future<String> getUsernamePostByUserId(String id) async {
    try {
      return db.usernamePostByUserId(id);
    } catch (error) {
      logger.d('getUsernamePostByUserId error ' + error.toString());
      return 'null';
    }
  }

  void close() {
    db.close();
    //_connectivitySubscription!.cancel();
  }
}

class Failure extends IOException {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
