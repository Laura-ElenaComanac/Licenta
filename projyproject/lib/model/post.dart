import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class Post {
  String _id;
  String get id => _id;

  String _title;
  String get title => _title;

  String _description;
  String get description => _description;

  String _date;
  String get date => _date;

  String _userid;
  String get userid => _userid;

  factory Post.fromJson(Map<String, dynamic> postsMap) {
    return Post(
        id: postsMap['id'].toString() as String,
        title: postsMap['title'] as String,
        description: postsMap['description'] as String,
        date: postsMap['date'] as String,
        userid: postsMap['userid'] as String);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> postsMap = {
      'id': _id,
      'title': _title,
      'description': _description,
      'date': _date,
      'userid': _userid
    };
    return postsMap;
  }

  Post(
      {required String id,
      required String title,
      required String description,
      required String date,
      required String userid})
      : _id = id,
        _title = title,
        _description = description,
        _date = date,
        _userid = userid,
        assert(id != null),
        assert(title != null),
        assert(description != null),
        assert(date != null),
        assert(userid != null);

  @override
  bool operator ==(Object other) => other is Post && other._id == _id;

  @override
  int get hashCode => hashValues(_id, _title);

  @override
  String toString() {
    return "id: " +
        _id +
        ", title: " +
        _title +
        ", description: " +
        _description +
        ", date:" +
        _date +
        ", userid:" +
        _userid;
  }
}
