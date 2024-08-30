import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { kerja, hiburan, belajar, makanan }

final formatter = DateFormat.yMd();

const categoryIcons = {
  Category.makanan: Icons.lunch_dining,
  Category.kerja: Icons.cases_outlined,
  Category.hiburan: Icons.movie,
  Category.belajar: Icons.library_books_outlined,
};

class Expense {
  final String id;
  final String title;
  final String amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  String get formatDate {
    return formatter.format(date);
  }
}
