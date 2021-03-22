import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart';
import 'exam.dart';

// ignore: must_be_immutable
class ExamsList extends StatelessWidget {
  Function delete;
  ExamsList(this.delete);

  // ignore: missing_return
  int colorNumber(Exam currentExam){
    for (int i=0;i<globals.subjects.length;i++)
      if (globals.subjects[i] == currentExam.subject)
        return i;
  }

  createAlertDialog(BuildContext context, Exam exam){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Opis", style: TextStyle(fontWeight: FontWeight.bold),),
        content: Text(exam.description),
        actions: [
          FlatButton(
            child: Text("Zamknij"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ]
      );}
    );
  }

  @override
  Widget build(BuildContext context) {
    return globals.userExams.length > 0
        ? Column(
            children: [
              SizedBox(height: 5),
              Flexible(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  children: [
                    ...globals.userExams.map((exam) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(exam.description != '' ? Icons.info : null, size: 27,),
                              onPressed: () => createAlertDialog(context, exam),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(exam.name,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center),
                                    Text(exam.subject,
                                        style: TextStyle(
                                            fontSize: 15),
                                            textAlign: TextAlign.center),
                                    Text(DateFormat.yMMMd().format(exam.date),
                                        style: TextStyle(
                                            fontSize: 15),
                                            textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, size: 27,),
                              onPressed: () => delete(exam.id),
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: globals.colors[colorNumber(exam)],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          )
        : Center(
            child: Text(
              'Brak nadchodzących zaliczeń',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          );
  }
}