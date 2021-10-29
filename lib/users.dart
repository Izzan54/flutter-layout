// ignore_for_file: avoid_types_as_parameter_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class userMsg {
  int? id;
  String? firstname;
  String? lastname;
  String? avatar;
  String? username;
  String? lastseentime;
  String? status;
  int? messages;

  userMsg(
      {this.id,
      this.firstname,
      this.lastname,
      this.avatar,
      this.username,
      this.lastseentime,
      this.messages,
      this.status});

  // ignore: non_constant_identifier_names
  userMsg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['first_name'];
    lastname = json['last_name'];
    avatar = json['avatar'];
    username = json['username'];
    lastseentime = json['last_seen_time'];
    status = json['status'];
    messages = json['messages'];
  }
}
