import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 199.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        constraints: const BoxConstraints(minWidth: double.infinity),
        builder: (ctx) => NewExpense(_onAddExpense),
        isScrollControlled: true);
  }

  void _onAddExpense(Expense e) {
    setState(() {
      _registeredExpenses.add(e);
    });
  }

  void _onRemoveExpense(int index) {
    final removedItem = _registeredExpenses[index];
    setState(() {
      _registeredExpenses.removeAt(index);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('${removedItem.title} was removed'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(index, removedItem);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget content = const Center(
      child: Text('No item'),
    );
    if (_registeredExpenses.isNotEmpty) {
      content = width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: ExpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: _onRemoveExpense),
                )
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: ExpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: _onRemoveExpense),
                )
              ],
            );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text('Flutter Expense Tracker'),
      ),
      body: content,
    );
  }
}
