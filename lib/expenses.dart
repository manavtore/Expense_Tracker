import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/expense.dart';
import 'package:flutter_application_1/Widgets/expenses_list.dart';
import 'package:flutter_application_1/Widgets/new_expense.dart';
import 'package:flutter_application_1/Widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseoverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeexpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expenses Deleted'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        )));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses to display'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeexpense,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Expenses_App'),
          actions: [
            IconButton(
                onPressed: _openAddExpenseoverlay, icon: const Icon(Icons.add)),
          ],
        ),
        body: Width < 600
            ? Column(
                children: [
                  Chart(expense: _registeredExpenses),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(expense: _registeredExpenses),
                  ),
                  Expanded(child: mainContent),
                ],
              ));
  }
}
