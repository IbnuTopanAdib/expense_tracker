import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(expense.amount.toString()),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(expense.formatDate),
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
