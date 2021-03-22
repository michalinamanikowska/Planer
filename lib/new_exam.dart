import 'package:intl/intl.dart';
import 'globals.dart' as globals;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewExam extends StatefulWidget {
  Function add;
  NewExam(this.add);

  @override
  _NewExamState createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String chosenSubject;
  DateTime selectedDate;
  bool makeHigher = false;

  void submitData() {
    if (titleController.text.isEmpty || chosenSubject == null || selectedDate == null) return;

    widget.add(titleController.text, chosenSubject, selectedDate,
        descriptionController.text);
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2022),
      builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light().copyWith(
        primary: Colors.blueGrey[600],
      ),
    ),
    child: child,
  );
}
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        selectedDate = pickedData;
      });
    });
  }

  bool makeBigger(String subject) {
    for (int i=0;i<globals.tooSmall.length;i++)
      if (globals.subjects[globals.tooSmall[i]] == subject)
        {
          makeHigher = true;
          return true;
        }
    makeHigher = false;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: makeBigger(chosenSubject) ? MediaQuery.of(context).size.height * 0.48 : MediaQuery.of(context).size.height * 0.42,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 8),
              child: Text(
                'Dodaj nowe zaliczenie',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Tytuł'),
              ),
            ),
            DropdownButton<String>(
              itemHeight: makeBigger(chosenSubject) ? 100 : 50,
              isExpanded: true,
              hint: Text('Przedmiot'),
              value: chosenSubject,
              icon: Icon(Icons.arrow_drop_down),
              onChanged: (String newValue) {
              setState(() {
                chosenSubject = newValue;
              });
            },
             items: globals.subjects.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Opis'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 39,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: presentDatePicker,
                        child: Text(
                          'Wybierz termin',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[300]),
                          textAlign: TextAlign.left),
                      ),
                      Expanded(
                          child: Text(
                          selectedDate == null
                          ? 'Brak wybranego terminu'
                          : 'Wybrano: ${DateFormat.yMd().format(selectedDate)}',
                          style: TextStyle( color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: submitData,
                  child: Text(
                    'Zapisz',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Colors.blueGrey[600])),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
