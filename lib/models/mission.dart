import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  general,
  study,
  leisure,
  buisness,
  work,
}

final formatDate = DateFormat.yMd();
final formatHour = DateFormat.Hm();

const categoryIcons = {
  Category.general: Icons.article_outlined,
  Category.study: Icons.school_outlined,
  Category.leisure: Icons.fmd_good_outlined,
  Category.buisness: Icons.attach_money,
  Category.work: Icons.work_history_outlined,
};

class Mission {
  Mission({
    required this.title,
    required this.date,
    required this.time,
    required this.category,
    required this.comment,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay time;
  final Category category;
  final String comment;

  String get formattedDate {
    return formatDate.format(date);
  }

  String get formattedHour {
    return time.minute < 10 // אם יש אפס בדקות בצד שמאל
        ? '${time.hour} : 0${time.minute}'
        : '${time.hour} : ${time.minute}';
  }
}
