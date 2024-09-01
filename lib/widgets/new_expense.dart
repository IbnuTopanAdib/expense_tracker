import 'package:expense_tracker/model/expense.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) addNewExpense;
  const NewExpense({super.key, required this.addNewExpense});
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.belajar;

  void _pickDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    final titleIsInvalid = _titleController.text.trim().isEmpty;

    if (amountIsInvalid || titleIsInvalid || _selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Invalid Input'),
              content: Text('Tolong isi semua data dengan benar!'),
            );
          });
      return;
    }

    widget.addNewExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Nama Barang'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Harga Barang'), prefixText: 'Rp.'),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_selectedDate == null
                      ? 'Pilih Tanggal'
                      : DateFormat.yMd().format(_selectedDate!)),
                  IconButton(
                      onPressed: _pickDate, icon: Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Batalkan'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text('Simpan Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
