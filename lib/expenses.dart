import 'package:expense_tracker/widgets/chart.dart';

import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_list.dart';

import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> expenses = [
    Expense(
      title: 'Flutter pak erico',
      amount: 300,
      date: DateTime.now(),
      category: Category.belajar,
    ),
    Expense(
      title: 'USB C',
      amount: 50,
      date: DateTime.now(),
      category: Category.kerja,
    )
  ];

  void openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      shape: const BeveledRectangleBorder(),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addNewExpense: addExpense),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final indexOfExpense = expenses.indexOf(expense);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Kamu menghapus data expense'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expenses.insert(indexOfExpense, expense);
            });
          },
        ),
      ),
    );

    setState(() {
      expenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: expenses),
                Expanded(
                  child: ExpenseList(
                    expenses: expenses,
                    removeExpense: removeExpense,
                  ),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Chart(expenses: expenses)),
                Expanded(
                  child: ExpenseList(
                    expenses: expenses,
                    removeExpense: removeExpense,
                  ),
                )
              ],
            ),
    );
  }
}
