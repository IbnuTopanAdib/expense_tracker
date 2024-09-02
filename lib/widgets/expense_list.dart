import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense) removeExpense;
  const ExpenseList(
      {super.key, required this.expenses, required this.removeExpense});
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.errorContainer,
            margin: Theme.of(context).cardTheme.margin,
          ),
          onDismissed: (direction) {
            removeExpense(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: ExpenseItem(
            expense: expenses[index],
          ),
        );
      },
    );
  }
}
