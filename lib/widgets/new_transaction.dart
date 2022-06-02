import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // String? titleInput;
  // String? amountInput;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() => _selectedDate = pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                child:
                    Text('New Transaction', style: theme.textTheme.titleLarge),
                padding: EdgeInsets.only(bottom: 10),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter the Title',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                // onChanged: (value) => titleInput = value,
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter the Amount',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                // onChanged: (value) => amountInput = value,
                controller: _amountController,
                // keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.125,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),
                    OutlinedButton(
                      child: Text(
                        'Choose Date',
                        // style: TextStyle(fontWeight: FontWeight.bold)
                        style: theme.textTheme.headline6,
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                  textStyle: theme.textTheme.headline6,
                  minimumSize: Size(100, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
