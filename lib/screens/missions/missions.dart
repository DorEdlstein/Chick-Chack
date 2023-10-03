import 'dart:convert';

import 'package:chick_chack_beta/main.dart';
import 'package:chick_chack_beta/screens/missions/new_mission.dart';
import 'package:chick_chack_beta/styles/styled_text.dart';
// import 'package:chick_chack_beta/widgets/chart/chart.dart';
import 'package:chick_chack_beta/widgets/missions_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chick_chack_beta/models/mission.dart';

class Missions extends StatefulWidget {
  // עמוד הוצאות הכולל רשימת הוצאות והוספת הוצאה
  const Missions({super.key});

  @override
  State<Missions> createState() => _MissionsState();
}

class _MissionsState extends State<Missions> {
  final List<Mission> _loadedMissions = [
    // Mission(
    //   title: 'flutter course',
    //   date: DateTime.now(),
    //   time: const TimeOfDay(hour: 20, minute: 57),
    //   category: Category.study,
    //   comment: 'episod 8',
    // ),
    // Mission(
    //   title: 'drink water',
    //   date: DateTime.now(),
    //   time: const TimeOfDay(hour: 12, minute: 07),
    //   category: Category.general,
    //   comment: 'evrey hour 120 mili\'',
    // ),
    // Mission(
    //   title:
    //       'buy a fly tickets smdcklsd jsdcsd sdcndsc k ds  cdjskn cbjskcjdsscscs ',
    //   date: DateTime.now(),
    //   time: TimeOfDay.fromDateTime(DateTime.now()),
    //   category: Category.leisure,
    //   comment: '',
    // )
  ];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    // טעינת המשימות הקיימות
    final url = Uri.https(
        'chick-chack-6fdf7-default-rtdb.firebaseio.com', 'mission-list.json');
    final response = await http.get(url);
    print(response.body);
    final listData = json.decode(response.body);
    //final List<Mission> _loadedMissions = [];
    //if (listData != null) {
    for (final item in listData.entries) {
      _loadedMissions.add(
        Mission(
          title: item.value['title'],
          category: Category.values.byName(item.value['category']),
          comment: item.value['comment'],
          date: DateTime(2023, 04, 05), // -------------placeHolder----------
          // DateTime(
          //   item.value['date-year'],
          //   item.value['date-month'],
          //   item.value['date-day'],
          // ),
          time: const TimeOfDay(
            hour: 14, minute: 55, //-------------PLACEHOLDER--------------
            // hour: int.parse(_addZero(item.value['time-hour'])),
            // minute: int.parse(_addZero(item.value['time-minute'])),
          ),
          //item.value['time'],
        ),
      );
      // if (!mounted) {
      //   return;
      // }
      // Navigator.of(context).pop();
    }
  }
  //}

  String _addZero(String num) {
    int numInt = int.parse(num);
    String numStr = num.toString();
    if (numInt < 10) numStr = '0$num';
    return numStr;
  }

  void _openAddMissionOverlay() async {
    showModalBottomSheet(
        //פותח את חלונית הוספת המשימה
        //useSafeArea: true,F
        isScrollControlled: true, //גורם לחלונית להיות על מסך מלא
        context: context,
        builder: (ctx) => NewMission(
              onAddMission: _addMission,
            ));
  }

  void _addMission(Mission mission) async {
    setState(() {
      //מקבלת "הוצאה" ומוסיפה אותו לרשימת ההוצאות
      _loadedMissions.add(mission);
      _loadItems(); // unessery request
    });
  }

  void _removeMission(Mission mission) {
    final missionIndex = _loadedMissions.indexOf(mission); //potion
    setState(() {
      //לפי האינדקס INDEXOF נמצא את המשימה המדוברת ונסיר אותה
      _loadedMissions.remove(mission);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const StyledText(
            outText: 'Mission deleted!',
            size: 25,
            color: Color.fromARGB(255, 237, 32, 17)),
        action: SnackBarAction(
          label: 'Undo',
          textColor: kColorScheme.onError,
          onPressed: () {
            setState(() {
              _loadedMissions.insert(missionIndex, mission);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);  בדיקה של רוחב וגובה המכשיר (בשכיבה/עמידה)
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget mainContent = Center(
      //משתנה המכיל תוכן מסך ראשי
      child: StyledText(
          outText:
              'No Missions found. To add press on + button in the right top',
          size: 35,
          color: kColorScheme.onPrimaryContainer),
    );

    if (_loadedMissions.isNotEmpty) {
      //כאשר רשימת ההוצאות אינה ריקה
      mainContent = MissionsList(
        missions: _loadedMissions,
        onRemoveMission: _removeMission,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const StyledText(
            outText: 'MissionTracker Chick-Chack',
            size: 25,
            color: Colors.grey),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddMissionOverlay,
            iconSize: 35,
            color: Colors.grey,
          ),
        ],
      ),
      body: width < height // טלפון עומד
          ? Column(
              children: [
                const StyledText.title(
                  'placeHolder',
                ),
                //Chart(missions: _loadedMissions),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              // landscape
              children: [
                // Expanded(
                //   child: Chart(Missions: _loadedMissions),
                // ),
                Expanded(
                  //סידור מסויים
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
