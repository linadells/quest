import 'package:flutter/material.dart';
import 'package:quest/core/style.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            title: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.supervised_user_circle,
                      size: 50,
                      color: kAccent,
                    )),
                Text('Katia')
              ],
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {},
              child: Text('Create quest'),
            ),
          ),
        ],
      )),
    );
  }
}
