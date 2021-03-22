import 'package:flutter/material.dart';
import 'globals.dart' as globals;

// ignore: must_be_immutable
class Menu extends StatelessWidget {
  Function update;
  Menu(this.update);
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            child: DrawerHeader(child: Center(child: Text('MENU', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            decoration: BoxDecoration(color: Colors.blueGrey[600]),
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0),
            ),
            height: 56.0,
          ),
          ...globals.actions.map((action) {
            return ListTile(
              leading: Transform.translate(
                  offset: Offset(0, 10), child: Icon(Icons.arrow_right_alt, color: Colors.blueGrey[600])),
              title: Transform.translate(
                  offset: Offset(-16, 10),
                  child: Text(action, style: TextStyle(fontSize: 18))),
              onTap: () {
                Navigator.of(context).pop();
                globals.chosen = action;
                update();
              }
            );
          }).toList(),
        ],
      ),
    );
  }
}
