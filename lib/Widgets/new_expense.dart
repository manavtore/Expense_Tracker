// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  DateTime? _SelectedDate;

  final _amountcontroler = TextEditingController();
  final _titlecontroler = TextEditingController();

  Category _SelectdCategory = Category.leisure;

  @override
  void dispose() {
    _titlecontroler.dispose();
    _amountcontroler.dispose();
    super.dispose();
  }

  void _presentdatePicker() async {
    var now = DateTime.now();
    var first = DateTime(now.year - 20, now.month, now.day);
    var last = DateTime(now.year + 20, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: first,
      lastDate: last,
    );
    setState(() {
      _SelectedDate = pickedDate;
    });
  }

  void _submitexpenseData() {
    final enteredAmount = double.tryParse(_amountcontroler.text);
    final amountisInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titlecontroler.text.trim().isEmpty || amountisInvalid) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('plz enter valid Data'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('ok'),
                  ),
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(
        title: _titlecontroler.text,
        amount: enteredAmount,
        date: _SelectedDate!,
        category: _SelectdCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: ((context, constraints) {
      final Width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        width: Width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardspace + 16),
            child: Width >= 600
                ? Column(children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titlecontroler,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _amountcontroler,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '\$',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton(
                            value: _SelectdCategory,
                            items: Category.values
                                .map(
                                  (Category) => DropdownMenuItem(
                                    value: Category,
                                    child: Text(
                                      Category.name.toUpperCase(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _SelectdCategory = value;
                              });
                              const SizedBox(width: 16);

                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(_SelectedDate == null
                                      ? 'Date is not selected'
                                      : formatter.format(_SelectedDate!)),
                                  IconButton(
                                      onPressed: _presentdatePicker,
                                      icon: const Icon(
                                        Icons.calendar_month,
                                      ))
                                ],
                              ));
                            }),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_SelectedDate == null
                                ? 'Date is not selected'
                                : formatter.format(_SelectedDate!)),
                            IconButton(
                                onPressed: _presentdatePicker,
                                icon: const Icon(
                                  Icons.calendar_month,
                                ))
                          ],
                        ))
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitexpenseData,
                          child: const Text('save Expense'),
                        ),
                      ],
                    )
                  ])
                : Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            TextField(
                              controller: _titlecontroler,
                              maxLength: 50,
                              decoration: const InputDecoration(
                                label: Text('Title'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            TextField(
                              controller: _amountcontroler,
                              keyboardType: TextInputType.number,
                              maxLength: 50,
                              decoration: const InputDecoration(
                                prefixText: '\$',
                                label: Text('Amount'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          DropdownButton(
                              value: _SelectdCategory,
                              items: Category.values
                                  .map(
                                    (Category) => DropdownMenuItem(
                                      value: Category,
                                      child: Text(
                                        Category.name.toUpperCase(),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _SelectdCategory = value;
                                });
                              }),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_SelectedDate == null
                                  ? 'Date is not selected'
                                  : formatter.format(_SelectedDate!)),
                              IconButton(
                                  onPressed: _presentdatePicker,
                                  icon: const Icon(
                                    Icons.calendar_month,
                                  ))
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('cancel'),
                          ),
                          ElevatedButton(
                            onPressed: _submitexpenseData,
                            child: const Text('save Expense'),
                          ),
                        ],
                      )
                    ],
                  ),

            // // if (Width >= 600)
          ),
        ),
      );
    }));
  }
}
