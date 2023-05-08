import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('\$${expense.amount.toStringAsFixed(1)}'),
                    const SizedBox(width: 8),
                    const Spacer(),
                    Row(children: [
                      Icon(CategoryIcons[expense.category]),
                      const SizedBox(width: 8),
                      Text(expense.formattedDate),
                    ])
                  ],
                )
              ],
            )));
  }
}
