import 'dart:async';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:projyproject/model/post.dart';
import 'package:projyproject/model/user.dart';

part 'database.g.dart';

@DataClassName('UserEntry')
class LocalUsers extends Table {
  //IntColumn get id => integer().autoIncrement()();
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get username => text().withLength(min: 1, max: 100)();
  TextColumn get password => text().withLength(min: 1, max: 100)();
  TextColumn get firstname => text().withLength(min: 1, max: 100)();
  TextColumn get lastname => text().withLength(min: 0, max: 100)();
  TextColumn get gender => text().withLength(min: 0, max: 100)();
  TextColumn get email => text().withLength(min: 1, max: 100)();
  TextColumn get birthday => text().withLength(min: 0, max: 100)();
  TextColumn get location => text().withLength(min: 0, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PostEntry')
class LocalPosts extends Table {
  //IntColumn get id => integer().autoIncrement()();
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get date => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withLength(min: 1, max: 1000)();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get userid => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LoggedUserEntry')
class LoggedUser extends Table {
  TextColumn get id => text().withLength(min: 1, max: 100)();
  TextColumn get username => text().withLength(min: 1, max: 100)();
  TextColumn get password => text().withLength(min: 1, max: 100)();
  TextColumn get firstname => text().withLength(min: 1, max: 100)();
  TextColumn get lastname => text().withLength(min: 0, max: 100)();
  TextColumn get gender => text().withLength(min: 0, max: 100)();
  TextColumn get email => text().withLength(min: 1, max: 100)();
  TextColumn get birthday => text().withLength(min: 0, max: 100)();
  TextColumn get location => text().withLength(min: 0, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [LocalUsers, LoggedUser, LocalPosts])
class Database extends _$Database {
  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'database.sqlite', logStatements: true));

  @override
  int get schemaVersion => 12;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 11) {
          //await m.drop(localUsers);
          await m.drop(localPosts);
          await m.createTable(localPosts);
        }
      });

  Future<List<UserEntry>> getUsers() => select(localUsers).get();

  Future<List<PostEntry>> getPosts() => select(localPosts).get();

  Stream<List<UserEntry>> watchUsers() => select(localUsers).watch();

  Stream<List<PostEntry>> watchPosts() => select(localPosts).watch();

  Future<String> usernamePostByUserId(String id) {
    return (select(localUsers)..where((t) => t.id.equals(id)))
        .get()
        .then((value) => value.first.username);
  }

  Stream<UserEntry> userById(String id) {
    return (select(localUsers)..where((t) => t.id.equals(id))).watchSingle();
  }

  SingleSelectable<UserEntry> entryById(String id) {
    return select(localUsers)..where((t) => t.id.equals(id));
  }

  Future<List<UserEntry>>? userByUsernameAndPassword(
      String username, String password) {
    try {
      return (select(localUsers)
            ..where((t) =>
                t.username.equals(username) & t.password.equals(password)))
          .get();
    } catch (error) {
      return null;
    }
  }

  SingleSelectable<UserEntry> entry(String id) {
    return select(localUsers)..where((t) => t.id.equals(id));
  }

  Future<void> insertUser(LocalUsersCompanion user) async {
    into(localUsers).insert(user);
  }

  Future<void> insertPost(LocalPostsCompanion post) async {
    into(localPosts).insert(post);
  }

  Future<void> insertLoggedUser(LoggedUserCompanion user) async {
    await (delete(loggedUser)).go();
    into(loggedUser).insert(user);
  }

  Stream<List<LoggedUserEntry>> watchLoggedUser() => select(loggedUser).watch();

  Future<List<LoggedUserEntry>> getLoggedUser() => select(loggedUser).get();

  Future<void> insertUserEntry(UserEntry user) async {
    into(localUsers).insert(user);
    insertLoggedUser(LoggedUserCompanion.insert(
        id: user.id,
        username: user.username,
        password: user.password,
        firstname: user.firstname,
        lastname: user.lastname,
        gender: user.gender,
        email: user.email,
        birthday: user.birthday,
        location: user.location));
  }

  Future<void> updateUser(UserEntry user) async {
    insertLoggedUser(LoggedUserCompanion.insert(
        id: user.id,
        username: user.username,
        password: user.password,
        firstname: user.firstname,
        lastname: user.lastname,
        gender: user.gender,
        email: user.email,
        birthday: user.birthday,
        location: user.location));
    update(localUsers).replace(user);
  }

  Future<void> deleteUser(UserEntry user) => delete(localUsers).delete(user);

  Future<void> deletePost(PostEntry post) => delete(localPosts).delete(post);

  Future<void> deleteUserById(String id) {
    return (delete(localUsers)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deletePostById(String id) {
    return (delete(localPosts)..where((t) => t.id.equals(id))).go();
  }

  Future<void> updateUserById(UserEntry user) {
    insertLoggedUser(LoggedUserCompanion.insert(
        id: user.id,
        username: user.username,
        password: user.password,
        firstname: user.firstname,
        lastname: user.lastname,
        gender: user.gender,
        email: user.email,
        birthday: user.birthday,
        location: user.location));
    return (update(localUsers)..where((t) => t.id.equals(user.id))).write(user);
  }

  Future<void> deleteAllUsers() => delete(localUsers).go();
}
