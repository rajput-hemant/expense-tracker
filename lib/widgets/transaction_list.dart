import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/notransactions.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'No transaction added yet!',
                  style: theme.textTheme.headline6,
                  textScaleFactor: 1.25,
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (currentTransaction, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: theme.primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.all(10),
                    child: FittedBox(
                      child: Text(
                        '₹ ${transactions[index].amount}',
                        style: theme.textTheme.headline6,
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: theme.textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: theme.errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: theme.errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        ),
                ),
              );
            },
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
//                   color: theme.primaryColor,
//                   width: 2,
//                 ),
//               ),
//               padding: EdgeInsets.all(10),
//               child: Text(
//                 '\₹ ${transactions[index].amount.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   color: theme.primaryColor,
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(transactions[index].title,
//                     style: theme.textTheme.headline6),
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
