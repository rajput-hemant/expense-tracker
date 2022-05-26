import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: [
                Padding(padding: EdgeInsets.all(20)),
                Container(
                  height: 300,
                  child: Image.asset(
                    'assets/images/notransactions.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(padding: EdgeInsets.all(20)),
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.headline6,
                  textScaleFactor: 1.25,
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (currentTransaction, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: Text(
                          '₹ ${transactions[index].amount}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                  ),
                );
              },
            ),
    );
  }
}

// ListView.builder(
//     itemCount: transactions.length,
//     itemBuilder: (currentTransaction, index) {
//       return Card(
//         child: Row(
//           children: [
//             Container(
//               margin:
//                   EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Theme.of(context).primaryColor,
//                   width: 2,
//                 ),
//               ),
//               padding: EdgeInsets.all(10),
//               child: Text(
//                 '\₹ ${transactions[index].amount.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(transactions[index].title,
//                     style: Theme.of(context).textTheme.headline6),
//                 Text(
//                   DateFormat.yMMMd().format(transactions[index].date),
//                   style: TextStyle(
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//     },
//   ),
