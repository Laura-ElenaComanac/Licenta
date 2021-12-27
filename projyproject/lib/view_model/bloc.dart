import 'package:flutter/cupertino.dart';
import 'package:projyproject/data/http_helper.dart';
import 'package:projyproject/repository/database.dart';
import 'package:projyproject/model/user.dart';
import 'package:projyproject/repository/fake_repo.dart';

class Bloc {
  final Database db;

  late final Stream<List<UserEntry>> _users;

  late UserEntry _user;

  Stream<List<UserEntry>> get homeScreenEntries => _users;

  Bloc() : db = Database() {
    updateUsersDB();
    _users = db.watchUsers();
  }

  void updateUsersDB() async {
    HttpHelper h = HttpHelper();
    List<User> users = await h.getUsers();

    for (var user in users) {
      if (db.entryById(int.parse(user.id)) == null) {
        final userC = LocalUsersCompanion.insert(
            username: user.username,
            password: user.password,
            firstname: user.firstname,
            lastname: user.lastname,
            gender: user.gender);

        addEntry(userC);
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
      db.insertUser(user);
    } catch (error) {
      throw Failure(error.toString());
    }
  }

  void updateEntry(UserEntry entry) {
    try {
      db.updateUser(entry);
    } catch (error) {
      throw Failure(error.toString());
    }
  }

  void deleteEntry(int id) {
    try {
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
