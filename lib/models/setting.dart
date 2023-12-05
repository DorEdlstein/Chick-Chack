import 'package:chick_chack_beta/main.dart';
import 'package:chick_chack_beta/screens/application_main.dart';
import 'package:chick_chack_beta/styles/styled_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingCC extends StatefulWidget {
  SettingCC({super.key, required this.isStudentSettings});
  bool isStudentSettings;

  @override
  State<SettingCC> createState() => _SettingCCState();
}

class _SettingCCState extends State<SettingCC> {
  void _changeStateStudent(bool flag) async {
    setState(() {
      widget.isStudentSettings = flag;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userConnected.uid)
        .update({'is_student': widget.isStudentSettings});
    if (!mounted) {
      return;
    } // מקביל לRETURN
    print(widget.isStudentSettings.toString());
    Navigator.of(context).pop(widget.isStudentSettings);
    // userConnected.uid;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const StyledText(
            outText: 'Settings',
            size: 25,
            color: Colors.grey),
        //actions: []
      ),
      // color: kColorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Switch(
                  value: widget.isStudentSettings,
                  onChanged: _changeStateStudent,
                  activeColor: kColorScheme.primary,
                ),// ON/OFF button
                SizedBox(width: screenWidth*0.3 ),
                // const StyledText(outText: 'האם סטונדט', color: Colors.black, size: 20),
                const Text('? האם סטודנט', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20),)
              ]
            )
            //const Text('הגדרות יופיעו כאן!'),
          ],
        ),
      ),
    );
  }
}