import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (Transaction tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) totalSum += tx.amount;
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValue);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: []
      ),
    );
  }
}
