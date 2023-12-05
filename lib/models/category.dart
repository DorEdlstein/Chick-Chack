import 'package:flutter/material.dart';

enum CategoryList { general, study, leisure, business, work }

const categoryIcons = {
  CategoryList.general: Icons.article_outlined,
  CategoryList.study: Icons.school_outlined,
  CategoryList.work: Icons.work_history_outlined,
  CategoryList.leisure: Icons.fmd_good_outlined,
  CategoryList.business: Icons.attach_money,
};
