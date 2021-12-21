import 'package:flutter/cupertino.dart';
import 'package:projyproject/repository/database.dart';
import 'package:projyproject/model/user.dart';
import 'package:projyproject/repository/fake_repo.dart';

class Bloc {
  final Database db;

  late final Stream<List<UserEntry>> _users;

  late UserEntry _user;

  Stream<List<UserEntry>> get homeScreenEntries => _users;

  Bloc() : db = Database() {
    _users = db.watchUsers();
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
