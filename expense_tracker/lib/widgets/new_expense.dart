import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this._onAddExpense, {super.key});
  final Function(Expense e) _onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  var _selectedCategory = Category.leisure;
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().add(const Duration(days: -365)),
        lastDate: DateTime.now());
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (context, constraints) {
      print('modalMaxWidth ${constraints.maxWidth} ${constraints.minWidth}');
      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardHeight),
            child: Column(children: [
              TextField(
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Title')),
                controller: _titleController,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                          label: Text('Amount'), prefixText: '\$ '),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: _presentDatePicker,
                          child: Text(_selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!)),
                        ),
                        Expanded(
                          child: IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                        print(value);
                      }),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: () {
                        _submitExpenseData();
                      },
                      child: const Text('Save Expense')),
                ],
              )
            ]),
          ),
        ),
      );
    });
  }

  void _submitExpenseData() {
    final amount = double.tryParse(_amountController.text);
    if (_titleController.text.isEmpty ||
        amount == null ||
        _selectedDate == null) {
      if (Platform.isAndroid) {
        showCupertinoDialog(
          context: context,
          builder: (c) => CupertinoAlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(c);
                  },
                  child: const Text('OK'))
            ],
            title: const Text('Invalid data'),
            content: const Text('Title, amount or date is empty!'),
          ),
        );
      } else {
        showDialog(
            context: context,
            builder: (c) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(c);
                        },
                        child: const Text('OK'))
                  ],
                  title: const Text('Invalid data'),
                  content: const Text('Title, amount or date is empty!'),
                ));
      }
      return;
    }
    //Pass validation
    widget._onAddExpense(Expense(
        title: _titleController.text,
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }
}
