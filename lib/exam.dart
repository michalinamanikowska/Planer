import 'package:flutter/foundation.dart';
import 'globals.dart' as globals;

class Exam{
  String name;
  String subject;
  DateTime date;
  String description;
  int id = globals.userExams.length;

  Exam({@required this.name, @required this.subject, @required this.date, this.description});

  Map<String,dynamic> toJson() => {
    'id': id.toString(),
    'name': name,
    'subject': subject,
    'date': date.toString(),
    'description': description,
  };

  Exam.fromJson(Map<String,dynamic> json)
    : id = int.parse(json['id']),
      name = json['name'],
      subject = json['subject'],
      date = DateTime.parse(json['date']),
      description = json['description'];

}

