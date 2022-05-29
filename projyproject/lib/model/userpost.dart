import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class UserPost {
  String _id;
  String get id => _id;

  String _title;
  String get title => _title;

  String _description;
  String get description => _description;

  String _date;
  String get date => _date;

  factory UserPost.fromJson(Map<String, dynamic> postsMap) {
    return UserPost(
        id: postsMap['id'].toString() as String,
        title: postsMap['title'] as String,
        description: postsMap['description'] as String,
        date: postsMap['date'] as String);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> postsMap = {
      'id': _id,
      'title': _title,
      'description': _description,
      'date': _date
    };
    return postsMap;
  }

  UserPost(
      {required String id,
      required String title,
      required String description,
      required String date})
      : _id = id,
        _title = title,
        _description = description,
        _date = date,
        assert(id != null),
        assert(title != null),
        assert(description != null),
        assert(date != null);

  @override
  bool operator ==(Object other) => other is UserPost && other._id == _id;

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
        _date;
  }
}
