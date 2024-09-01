// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
  final double amount;
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

class ExpenseBucket {
  Category category;
  List<Expense> expenses;
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where(
              (expense) => expense.category == category,
            )
            .toList();

  double get totalAmount {
    double sum = 0;

    for (final element in expenses) {
      sum += element.amount;
    }

    return sum;
  }
}
