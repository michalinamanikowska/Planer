import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'menu.dart';
import 'task.dart';
import 'exam.dart';
import 'task_list.dart';
import 'exam_list.dart';
import 'globals.dart' as globals;
import 'new_task.dart';
import 'new_exam.dart';
import 'shared_pref.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[600],
        accentColor: Colors.white,
        fontFamily: 'OpenSans',
      ),
      home: MyStatelessWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyStatelessWidget> {
  bool isLoaded;
  SharedPref sharedPref = SharedPref();
  void loadSharedPrefs() async {
    Task task;
    Exam exam;
    int count = 0;
    isLoaded = false;
    do {
      try {
        task = Task.fromJson(await sharedPref.read("task$count"));
        globals.userTasks.add(task);
        count += 1;
      } catch (Exception) {
        break;
      }
    } while (1 != null);
    count = 0;
    do {
      try {
        exam = Exam.fromJson(await sharedPref.read("exam$count"));
        globals.userExams.add(exam);
        count += 1;
      } catch (Exception) {
        break;
      }
    } while (1 != null);

    globals.userExams.sort((a, b) => a.date.compareTo(b.date));
    globals.userTasks.sort((a, b) => a.date.compareTo(b.date));
    isLoaded = true;
    setState(() {});
  }

  void addTask(String taskName, String taskSubject, DateTime taskDate,
      String taskDescription) {
    setState(() {
      Task task = Task(
          name: taskName,
          subject: taskSubject,
          date: taskDate,
          description: taskDescription);
      globals.userTasks.add(task);
      globals.userTasks.sort((a, b) => a.date.compareTo(b.date));
      for (int i = 0; i < globals.userTasks.length; i++)
      {
        globals.userTasks[i].id = i;
        sharedPref.save("task$i", globals.userTasks[i]);
      }
    });
  }

  void addExam(String examName, String examSubject, DateTime examDate,
      String examDescription) {
    setState(() {
      Exam exam = Exam(
          name: examName,
          subject: examSubject,
          date: examDate,
          description: examDescription);
      globals.userExams.add(exam);
      globals.userExams.sort((a, b) => a.date.compareTo(b.date));
      for (int i = 0; i < globals.userExams.length; i++)
      {
        globals.userExams[i].id = i;
        sharedPref.save("exam$i", globals.userExams[i]);
      }
    });
  }

  void deleteTask(int index) {
    setState(() {
      print(globals.userTasks[index].name);
      globals.userTasks.removeAt(index);
      globals.userTasks.sort((a, b) => a.date.compareTo(b.date));
      for (int i = 0; i < globals.userTasks.length; i++)
        globals.userTasks[i].id = i;
      List<Task> temp = [...globals.userTasks];
      temp.sort((a, b) => a.id.compareTo(b.id));
      temp = temp.reversed.toList();
      sharedPref.clear();
      for (int i = 0; i < temp.length; i++)
        sharedPref.save("task$i", temp[i]);
      for (int i=0;i<globals.userExams.length;i++)
        sharedPref.save("exam$i", globals.userExams[i]);
    });
  }

  void deleteExam(int index) {
    setState(() {
      globals.userExams.removeAt(index);
      globals.userExams.sort((a, b) => a.date.compareTo(b.date));
      for (int i = 0; i < globals.userExams.length; i++)
        globals.userExams[i].id = i;
      List<Exam> temp = [...globals.userExams];
      temp.sort((a, b) => a.id.compareTo(b.id));
      temp = temp.reversed.toList();
      sharedPref.clear();
      for (int i = 0; i < temp.length; i++)
        sharedPref.save("exam$i", temp[i]);
      for (int i=0;i<globals.userTasks.length;i++)
        sharedPref.save("task$i", globals.userTasks[i]);
    });
  }

  void changeSite() {
    setState(() {});
  }

  void startAdd(BuildContext context, String object) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: GestureDetector(
            child: object == 'task'
                ? NewTask(addTask)
                : object == 'exam'
                    ? NewExam(addExam)
                    : null,
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          ),
        );
      },
    );
  }


  @override
  void initState() {
    loadSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? CircularProgressIndicator()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            drawer: Menu(changeSite),
            appBar: AppBar(
              centerTitle: true,
              title: Text(globals.uni,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            body: globals.chosen == 'ZADANIA'
                ? TasksList(deleteTask)
                : (globals.chosen == 'ZALICZENIA'
                    ? ExamsList(deleteExam)
                    : PDF.asset(
                        "assets/${globals.plan}",
                        height: double.infinity,
                        width: double.infinity,
                      )
                    ),
            floatingActionButton: globals.chosen != 'PLAN'
                ? FloatingActionButton(
                    child: Icon(Icons.add, color: Colors.blueGrey[600]),
                    onPressed: () => globals.chosen == 'ZADANIA'
                        ? startAdd(context, 'task')
                        : startAdd(context, 'exam'),
                  )
                : null,
          );
  }
}
