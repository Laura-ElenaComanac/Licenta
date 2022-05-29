// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class UserEntry extends DataClass implements Insertable<UserEntry> {
  final String id;
  final String username;
  final String password;
  final String firstname;
  final String lastname;
  final String gender;
  final String email;
  final String birthday;
  final String location;
  UserEntry(
      {required this.id,
      required this.username,
      required this.password,
      required this.firstname,
      required this.lastname,
      required this.gender,
      required this.email,
      required this.birthday,
      required this.location});
  factory UserEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserEntry(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password'])!,
      firstname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}firstname'])!,
      lastname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lastname'])!,
      gender: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gender'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      birthday: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}birthday'])!,
      location: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}location'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['firstname'] = Variable<String>(firstname);
    map['lastname'] = Variable<String>(lastname);
    map['gender'] = Variable<String>(gender);
    map['email'] = Variable<String>(email);
    map['birthday'] = Variable<String>(birthday);
    map['location'] = Variable<String>(location);
    return map;
  }

  LocalUsersCompanion toCompanion(bool nullToAbsent) {
    return LocalUsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      firstname: Value(firstname),
      lastname: Value(lastname),
      gender: Value(gender),
      email: Value(email),
      birthday: Value(birthday),
      location: Value(location),
    );
  }

  factory UserEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserEntry(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      firstname: serializer.fromJson<String>(json['firstname']),
      lastname: serializer.fromJson<String>(json['lastname']),
      gender: serializer.fromJson<String>(json['gender']),
      email: serializer.fromJson<String>(json['email']),
      birthday: serializer.fromJson<String>(json['birthday']),
      location: serializer.fromJson<String>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'firstname': serializer.toJson<String>(firstname),
      'lastname': serializer.toJson<String>(lastname),
      'gender': serializer.toJson<String>(gender),
      'email': serializer.toJson<String>(email),
      'birthday': serializer.toJson<String>(birthday),
      'location': serializer.toJson<String>(location),
    };
  }

  UserEntry copyWith(
          {String? id,
          String? username,
          String? password,
          String? firstname,
          String? lastname,
          String? gender,
          String? email,
          String? birthday,
          String? location}) =>
      UserEntry(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        location: location ?? this.location,
      );
  @override
  String toString() {
    return (StringBuffer('UserEntry(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('firstname: $firstname, ')
          ..write('lastname: $lastname, ')
          ..write('gender: $gender, ')
          ..write('email: $email, ')
          ..write('birthday: $birthday, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, firstname, lastname,
      gender, email, birthday, location);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserEntry &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.firstname == this.firstname &&
          other.lastname == this.lastname &&
          other.gender == this.gender &&
          other.email == this.email &&
          other.birthday == this.birthday &&
          other.location == this.location);
}

class LocalUsersCompanion extends UpdateCompanion<UserEntry> {
  final Value<String> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String> firstname;
  final Value<String> lastname;
  final Value<String> gender;
  final Value<String> email;
  final Value<String> birthday;
  final Value<String> location;
  const LocalUsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.firstname = const Value.absent(),
    this.lastname = const Value.absent(),
    this.gender = const Value.absent(),
    this.email = const Value.absent(),
    this.birthday = const Value.absent(),
    this.location = const Value.absent(),
  });
  LocalUsersCompanion.insert({
    required String id,
    required String username,
    required String password,
    required String firstname,
    required String lastname,
    required String gender,
    required String email,
    required String birthday,
    required String location,
  })  : id = Value(id),
        username = Value(username),
        password = Value(password),
        firstname = Value(firstname),
        lastname = Value(lastname),
        gender = Value(gender),
        email = Value(email),
        birthday = Value(birthday),
        location = Value(location);
  static Insertable<UserEntry> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? firstname,
    Expression<String>? lastname,
    Expression<String>? gender,
    Expression<String>? email,
    Expression<String>? birthday,
    Expression<String>? location,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (firstname != null) 'firstname': firstname,
      if (lastname != null) 'lastname': lastname,
      if (gender != null) 'gender': gender,
      if (email != null) 'email': email,
      if (birthday != null) 'birthday': birthday,
      if (location != null) 'location': location,
    });
  }

  LocalUsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? username,
      Value<String>? password,
      Value<String>? firstname,
      Value<String>? lastname,
      Value<String>? gender,
      Value<String>? email,
      Value<String>? birthday,
      Value<String>? location}) {
    return LocalUsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      location: location ?? this.location,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (firstname.present) {
      map['firstname'] = Variable<String>(firstname.value);
    }
    if (lastname.present) {
      map['lastname'] = Variable<String>(lastname.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String>(birthday.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('firstname: $firstname, ')
          ..write('lastname: $lastname, ')
          ..write('gender: $gender, ')
          ..write('email: $email, ')
          ..write('birthday: $birthday, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }
}

class $LocalUsersTable extends LocalUsers
    with TableInfo<$LocalUsersTable, UserEntry> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LocalUsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _firstnameMeta = const VerificationMeta('firstname');
  late final GeneratedColumn<String?> firstname = GeneratedColumn<String?>(
      'firstname', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _lastnameMeta = const VerificationMeta('lastname');
  late final GeneratedColumn<String?> lastname = GeneratedColumn<String?>(
      'lastname', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  late final GeneratedColumn<String?> gender = GeneratedColumn<String?>(
      'gender', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _birthdayMeta = const VerificationMeta('birthday');
  late final GeneratedColumn<String?> birthday = GeneratedColumn<String?>(
      'birthday', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _locationMeta = const VerificationMeta('location');
  late final GeneratedColumn<String?> location = GeneratedColumn<String?>(
      'location', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        password,
        firstname,
        lastname,
        gender,
        email,
        birthday,
        location
      ];
  @override
  String get aliasedName => _alias ?? 'local_users';
  @override
  String get actualTableName => 'local_users';
  @override
  VerificationContext validateIntegrity(Insertable<UserEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('firstname')) {
      context.handle(_firstnameMeta,
          firstname.isAcceptableOrUnknown(data['firstname']!, _firstnameMeta));
    } else if (isInserting) {
      context.missing(_firstnameMeta);
    }
    if (data.containsKey('lastname')) {
      context.handle(_lastnameMeta,
          lastname.isAcceptableOrUnknown(data['lastname']!, _lastnameMeta));
    } else if (isInserting) {
      context.missing(_lastnameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    } else if (isInserting) {
      context.missing(_birthdayMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return UserEntry.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocalUsersTable createAlias(String alias) {
    return $LocalUsersTable(_db, alias);
  }
}

class LoggedUserEntry extends DataClass implements Insertable<LoggedUserEntry> {
  final String id;
  final String username;
  final String password;
  final String firstname;
  final String lastname;
  final String gender;
  final String email;
  final String birthday;
  final String location;
  LoggedUserEntry(
      {required this.id,
      required this.username,
      required this.password,
      required this.firstname,
      required this.lastname,
      required this.gender,
      required this.email,
      required this.birthday,
      required this.location});
  factory LoggedUserEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LoggedUserEntry(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password'])!,
      firstname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}firstname'])!,
      lastname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lastname'])!,
      gender: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gender'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      birthday: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}birthday'])!,
      location: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}location'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['firstname'] = Variable<String>(firstname);
    map['lastname'] = Variable<String>(lastname);
    map['gender'] = Variable<String>(gender);
    map['email'] = Variable<String>(email);
    map['birthday'] = Variable<String>(birthday);
    map['location'] = Variable<String>(location);
    return map;
  }

  LoggedUserCompanion toCompanion(bool nullToAbsent) {
    return LoggedUserCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      firstname: Value(firstname),
      lastname: Value(lastname),
      gender: Value(gender),
      email: Value(email),
      birthday: Value(birthday),
      location: Value(location),
    );
  }

  factory LoggedUserEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LoggedUserEntry(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      firstname: serializer.fromJson<String>(json['firstname']),
      lastname: serializer.fromJson<String>(json['lastname']),
      gender: serializer.fromJson<String>(json['gender']),
      email: serializer.fromJson<String>(json['email']),
      birthday: serializer.fromJson<String>(json['birthday']),
      location: serializer.fromJson<String>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'firstname': serializer.toJson<String>(firstname),
      'lastname': serializer.toJson<String>(lastname),
      'gender': serializer.toJson<String>(gender),
      'email': serializer.toJson<String>(email),
      'birthday': serializer.toJson<String>(birthday),
      'location': serializer.toJson<String>(location),
    };
  }

  LoggedUserEntry copyWith(
          {String? id,
          String? username,
          String? password,
          String? firstname,
          String? lastname,
          String? gender,
          String? email,
          String? birthday,
          String? location}) =>
      LoggedUserEntry(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        location: location ?? this.location,
      );
  @override
  String toString() {
    return (StringBuffer('LoggedUserEntry(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('firstname: $firstname, ')
          ..write('lastname: $lastname, ')
          ..write('gender: $gender, ')
          ..write('email: $email, ')
          ..write('birthday: $birthday, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, firstname, lastname,
      gender, email, birthday, location);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoggedUserEntry &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.firstname == this.firstname &&
          other.lastname == this.lastname &&
          other.gender == this.gender &&
          other.email == this.email &&
          other.birthday == this.birthday &&
          other.location == this.location);
}

class LoggedUserCompanion extends UpdateCompanion<LoggedUserEntry> {
  final Value<String> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String> firstname;
  final Value<String> lastname;
  final Value<String> gender;
  final Value<String> email;
  final Value<String> birthday;
  final Value<String> location;
  const LoggedUserCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.firstname = const Value.absent(),
    this.lastname = const Value.absent(),
    this.gender = const Value.absent(),
    this.email = const Value.absent(),
    this.birthday = const Value.absent(),
    this.location = const Value.absent(),
  });
  LoggedUserCompanion.insert({
    required String id,
    required String username,
    required String password,
    required String firstname,
    required String lastname,
    required String gender,
    required String email,
    required String birthday,
    required String location,
  })  : id = Value(id),
        username = Value(username),
        password = Value(password),
        firstname = Value(firstname),
        lastname = Value(lastname),
        gender = Value(gender),
        email = Value(email),
        birthday = Value(birthday),
        location = Value(location);
  static Insertable<LoggedUserEntry> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? firstname,
    Expression<String>? lastname,
    Expression<String>? gender,
    Expression<String>? email,
    Expression<String>? birthday,
    Expression<String>? location,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (firstname != null) 'firstname': firstname,
      if (lastname != null) 'lastname': lastname,
      if (gender != null) 'gender': gender,
      if (email != null) 'email': email,
      if (birthday != null) 'birthday': birthday,
      if (location != null) 'location': location,
    });
  }

  LoggedUserCompanion copyWith(
      {Value<String>? id,
      Value<String>? username,
      Value<String>? password,
      Value<String>? firstname,
      Value<String>? lastname,
      Value<String>? gender,
      Value<String>? email,
      Value<String>? birthday,
      Value<String>? location}) {
    return LoggedUserCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      location: location ?? this.location,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (firstname.present) {
      map['firstname'] = Variable<String>(firstname.value);
    }
    if (lastname.present) {
      map['lastname'] = Variable<String>(lastname.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String>(birthday.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoggedUserCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('firstname: $firstname, ')
          ..write('lastname: $lastname, ')
          ..write('gender: $gender, ')
          ..write('email: $email, ')
          ..write('birthday: $birthday, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }
}

class $LoggedUserTable extends LoggedUser
    with TableInfo<$LoggedUserTable, LoggedUserEntry> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LoggedUserTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _firstnameMeta = const VerificationMeta('firstname');
  late final GeneratedColumn<String?> firstname = GeneratedColumn<String?>(
      'firstname', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _lastnameMeta = const VerificationMeta('lastname');
  late final GeneratedColumn<String?> lastname = GeneratedColumn<String?>(
      'lastname', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  late final GeneratedColumn<String?> gender = GeneratedColumn<String?>(
      'gender', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _birthdayMeta = const VerificationMeta('birthday');
  late final GeneratedColumn<String?> birthday = GeneratedColumn<String?>(
      'birthday', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _locationMeta = const VerificationMeta('location');
  late final GeneratedColumn<String?> location = GeneratedColumn<String?>(
      'location', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        password,
        firstname,
        lastname,
        gender,
        email,
        birthday,
        location
      ];
  @override
  String get aliasedName => _alias ?? 'logged_user';
  @override
  String get actualTableName => 'logged_user';
  @override
  VerificationContext validateIntegrity(Insertable<LoggedUserEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('firstname')) {
      context.handle(_firstnameMeta,
          firstname.isAcceptableOrUnknown(data['firstname']!, _firstnameMeta));
    } else if (isInserting) {
      context.missing(_firstnameMeta);
    }
    if (data.containsKey('lastname')) {
      context.handle(_lastnameMeta,
          lastname.isAcceptableOrUnknown(data['lastname']!, _lastnameMeta));
    } else if (isInserting) {
      context.missing(_lastnameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    } else if (isInserting) {
      context.missing(_birthdayMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoggedUserEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LoggedUserEntry.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LoggedUserTable createAlias(String alias) {
    return $LoggedUserTable(_db, alias);
  }
}

class PostEntry extends DataClass implements Insertable<PostEntry> {
  final String id;
  final String date;
  final String description;
  final String title;
  final String userid;
  PostEntry(
      {required this.id,
      required this.date,
      required this.description,
      required this.title,
      required this.userid});
  factory PostEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PostEntry(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      userid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}userid'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['description'] = Variable<String>(description);
    map['title'] = Variable<String>(title);
    map['userid'] = Variable<String>(userid);
    return map;
  }

  LocalPostsCompanion toCompanion(bool nullToAbsent) {
    return LocalPostsCompanion(
      id: Value(id),
      date: Value(date),
      description: Value(description),
      title: Value(title),
      userid: Value(userid),
    );
  }

  factory PostEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PostEntry(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      title: serializer.fromJson<String>(json['title']),
      userid: serializer.fromJson<String>(json['userid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'description': serializer.toJson<String>(description),
      'title': serializer.toJson<String>(title),
      'userid': serializer.toJson<String>(userid),
    };
  }

  PostEntry copyWith(
          {String? id,
          String? date,
          String? description,
          String? title,
          String? userid}) =>
      PostEntry(
        id: id ?? this.id,
        date: date ?? this.date,
        description: description ?? this.description,
        title: title ?? this.title,
        userid: userid ?? this.userid,
      );
  @override
  String toString() {
    return (StringBuffer('PostEntry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('title: $title, ')
          ..write('userid: $userid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, description, title, userid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.description == this.description &&
          other.title == this.title &&
          other.userid == this.userid);
}

class LocalPostsCompanion extends UpdateCompanion<PostEntry> {
  final Value<String> id;
  final Value<String> date;
  final Value<String> description;
  final Value<String> title;
  final Value<String> userid;
  const LocalPostsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.title = const Value.absent(),
    this.userid = const Value.absent(),
  });
  LocalPostsCompanion.insert({
    required String id,
    required String date,
    required String description,
    required String title,
    required String userid,
  })  : id = Value(id),
        date = Value(date),
        description = Value(description),
        title = Value(title),
        userid = Value(userid);
  static Insertable<PostEntry> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? description,
    Expression<String>? title,
    Expression<String>? userid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (title != null) 'title': title,
      if (userid != null) 'userid': userid,
    });
  }

  LocalPostsCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<String>? description,
      Value<String>? title,
      Value<String>? userid}) {
    return LocalPostsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      description: description ?? this.description,
      title: title ?? this.title,
      userid: userid ?? this.userid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (userid.present) {
      map['userid'] = Variable<String>(userid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPostsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('title: $title, ')
          ..write('userid: $userid')
          ..write(')'))
        .toString();
  }
}

class $LocalPostsTable extends LocalPosts
    with TableInfo<$LocalPostsTable, PostEntry> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LocalPostsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<String?> date = GeneratedColumn<String?>(
      'date', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1, maxTextLength: 1000),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _useridMeta = const VerificationMeta('userid');
  late final GeneratedColumn<String?> userid = GeneratedColumn<String?>(
      'userid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, date, description, title, userid];
  @override
  String get aliasedName => _alias ?? 'local_posts';
  @override
  String get actualTableName => 'local_posts';
  @override
  VerificationContext validateIntegrity(Insertable<PostEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('userid')) {
      context.handle(_useridMeta,
          userid.isAcceptableOrUnknown(data['userid']!, _useridMeta));
    } else if (isInserting) {
      context.missing(_useridMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PostEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PostEntry.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocalPostsTable createAlias(String alias) {
    return $LocalPostsTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $LocalUsersTable localUsers = $LocalUsersTable(this);
  late final $LoggedUserTable loggedUser = $LoggedUserTable(this);
  late final $LocalPostsTable localPosts = $LocalPostsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [localUsers, loggedUser, localPosts];
}
