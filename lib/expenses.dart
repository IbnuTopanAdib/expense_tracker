import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:expense_tracker/model/expense.dart';

import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void openAddExpenseDialog() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return NewExpense(
            addNewExpense: addExpense,
          );
        });
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: openAddExpenseDialog, icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Chart(expenses: expenses),
            Expanded(
              child: ListView.builder(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
