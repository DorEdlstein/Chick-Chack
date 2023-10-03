

import 'package:chick_chack_beta/styles/styled_text.dart';
import 'package:flutter/material.dart';

class SettingsS extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const StyledText(outText: 'Settings',
         size: 30, 
         color: Color.fromARGB(200, 100, 150, 120),
          ),
        ),
        body:SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: EdgeInsets.all(12),
            child:Column(
              children:const [
                 Text('hello')
              ],
            ),
          ),
        ) ,
    );
  }
}

