import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Text(expense.title),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Text(expense.amount),
            const Spacer(),
            Row(
              children: [
                Icon(categoryIcons[expense.category]),
                Text(expense.formatDate),
              ],
            )
          ],
        )
      ],
    ));
  }
}
