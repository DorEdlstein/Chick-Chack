import 'package:chick_chack_beta/main.dart';
import 'package:chick_chack_beta/models/mission.dart';
import 'package:chick_chack_beta/styles/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MissionCard extends StatelessWidget {
  const MissionCard(this.mission, {super.key});

  final Mission mission;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          //mainRow
          crossAxisAlignment:
              CrossAxisAlignment.center, //טקסט בעמודה העליונה מתחיל מצד שמאל
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Column(
                //left
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //title
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          mission.title,
                          style: GoogleFonts.ephesis(
                            color: kColorScheme.onBackground,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ), //TextStyle(fontSize: 12,fontStyle: GoogleFonts.adamina(), color: kColorScheme.onBackground,fontWeight: FontWeight.bold,) ,//Theme.of(context).textTheme.bodyMedium,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    //category
                    children: [
                      Icon(categoryIcons[mission.category]),
                      const SizedBox(width: 10),
                      StyledText(
                        outText: mission.category.toString().substring(9),
                        size: 30,
                        color: kColorScheme.secondary,
                      ),
                    ],
                  ),
                  Row(
                    children:  [
                      Text(mission.comment.toString()),
                    ],
                  )
                ],
              ),
            ),
            // Row(
            //   children: const [SizedBox(width: 80)],
            // ),
            //RowLeftEnds
            Column(
              //right
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StyledText(
                        outText: mission.formattedHour,
                        size: 60,
                        color: Colors.black87),
                  ],
                ),
              ],
            ),
          ],
        ), //mainRow
      ),
    );
  }
}