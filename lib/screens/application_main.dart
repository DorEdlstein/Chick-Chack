import 'package:chick_chack_beta/main.dart';
import 'package:chick_chack_beta/models/user.dart';
import 'package:chick_chack_beta/screens/missions/missions.dart';
import 'package:chick_chack_beta/screens/settings.dart';
import 'package:chick_chack_beta/screens/waiting_screen.dart';
import 'package:chick_chack_beta/styles/styled_text.dart';
import 'package:chick_chack_beta/screens/expenses/expenses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

final userConnected = FirebaseAuth.instance.currentUser!;

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

@override
class _MainAppState extends State<MainApp> {
  void _showConnactionDetails() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(userConnected.uid)
        .get();

    setState(() {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: StyledText(
            outText: 'welcome ${userData.data()!['user_name']}'.toUpperCase(),
            size: 21,
            color: kColorScheme.primaryContainer,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //_showConnactionDetails(user);
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingScreen();
          } else {
            // _showConnactionDetails();
            return Scaffold(
              // appBar: AppBar(
              //   actions: [
              //     IconButton(
              //         onPressed: () {
              //           FirebaseAuth.instance.signOut();
              //         },
              //         icon: const Icon(Icons.exit_to_app),
              //         color: Theme.of(context).colorScheme.primary),
              //   ],
              // ),
              body:
                  // Container(
                  //   decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage('https://www.sampletemplates.com/business-templates/checklist/daily-checklist-sample.html'))),
                  //   child:
                  Padding(
                padding: const EdgeInsets.only(bottom: 290),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            icon: const Icon(Icons.exit_to_app),
                            color: Theme.of(context).colorScheme.primary),
                      ],
                    ),
                    StyledText(
                        outText: 'welcome XXXplaceholder'.toUpperCase(),
                        size: 15,
                        color: kColorScheme.onBackground),
                    StyledText(
                      outText: 'everything \n Chick-Chack'.toUpperCase(),
                      size: 50,
                      color: kColorScheme.onBackground,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const Expenses(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.attach_money_rounded),
                      iconSize: 100,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const Missions(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_box_outlined),
                      iconSize: 100,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => SettingsS(),
                          ),
                        );
                      },
                      alignment: Alignment.center,
                      icon: const Icon(Icons.settings),
                      iconSize: 30,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

























// import 'package:chick_chack_beta/main.dart';
// import 'package:chick_chack_beta/models/user.dart';
// import 'package:chick_chack_beta/screens/missions/missions.dart';
// import 'package:chick_chack_beta/screens/settings.dart';
// import 'package:chick_chack_beta/styles/styled_text.dart';
// import 'package:chick_chack_beta/screens/expenses/expenses.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';

// class MainApp extends StatefulWidget {
//   const MainApp({super.key});

//   @override
//   State<MainApp> createState() => _MainAppState();
// }

// @override
// class _MainAppState extends State<MainApp> {
//   void _showConnactionDetails(UserCC user) {
//     setState(() {
//       ScaffoldMessenger.of(context).clearSnackBars();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           duration: const Duration(seconds: 3),
//           content: StyledText(
//             outText: 'welcome ${user.name}'.toUpperCase(),
//             size: 21,
//             color: kColorScheme.primaryContainer,
//           ),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return //_showConnactionDetails(user);
//         Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             IconButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//               },
//               icon: Icon(
//                 Icons.exit_to_app,
//                 color: Theme.of(context).colorScheme.primary,
//                 size: 100,
//               ),
//             ),
//             StyledText(
//                 outText: 'welcome XXXplaceholder'.toUpperCase(),
//                 size: 15,
//                 color: kColorScheme.onBackground),
//             StyledText(
//               outText: 'everything \n Chick-Chack'.toUpperCase(),
//               size: 50,
//               color: kColorScheme.onBackground,
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (ctx) => const Expenses(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.attach_money_rounded),
//               iconSize: 100,
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (ctx) => const Missions(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.check_box_outlined),
//               iconSize: 100,
//             ),
//             IconButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (ctx) =>  Settings(),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.settings),
//                 iconSize:100
//                ),
//           ],
//         ),
//       ),
//     );
//   }
// }
