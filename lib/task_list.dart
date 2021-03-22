import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart';
import 'task.dart';

// ignore: must_be_immutable
class TasksList extends StatelessWidget {
  Function delete;
  TasksList(this.delete);

  // ignore: missing_return
  int colorNumber(Task currentTask){
    for (int i=0;i<globals.subjects.length;i++)
      if (globals.subjects[i] == currentTask.subject)
        return i;
  }

  createAlertDialog(BuildContext context, Task task){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Opis", style: TextStyle(fontWeight: FontWeight.bold),),
        content: Text(task.description),
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
    return globals.userTasks.length > 0
        ? Column(
            children: [
              SizedBox(height: 5),
              Flexible(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  children: [
                    ...globals.userTasks.map((task) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(task.description != '' ? Icons.info : null, size: 27,),
                              onPressed: () => createAlertDialog(context, task),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(task.name,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center),
                                    Text(task.subject,
                                        style: TextStyle(
                                            fontSize: 15),
                                            textAlign: TextAlign.center),
                                    Text(DateFormat.yMMMd().format(task.date),
                                        style: TextStyle(
                                            fontSize: 15),
                                            textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, size: 27,),
                              onPressed: () => delete(task.id),
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: globals.colors[colorNumber(task)],
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
              'Brak zadań do wykonania',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          );
  }
}