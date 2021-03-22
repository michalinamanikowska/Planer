import 'package:flutter/foundation.dart';
import 'globals.dart' as globals;

class Task{
  String name;
  String subject;
  DateTime date;
  String description;
  int id = globals.userTasks.length;

  Task({@required this.name, @required this.subject,@required this.date, this.description});

  Map<String,dynamic> toJson() => {
    'id': id.toString(),
    'name': name,
    'subject': subject,
    'date': date.toString(),
    'description': description,
  };

  Task.fromJson(Map<String,dynamic> json)
    : id = int.parse(json['id']),
      name = json['name'],
      subject = json['subject'],
      date = DateTime.parse(json['date']),
      description = json['description'];
}

