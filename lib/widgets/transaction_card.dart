import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: theme.primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(10),
          child: FittedBox(
            child: Text(
              '₹ ${transaction.amount}',
              style: theme.textTheme.headline6,
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: theme.textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? OutlinedButton.icon(
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(11),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: theme.errorColor,
                    side: BorderSide(width: 1.0, color: theme.errorColor)),
                // textColor: theme.errorColor,
                onPressed: () => deleteTransaction(transaction.id))
            : IconButton(
                splashRadius: 30,
                icon: Icon(Icons.delete),
                color: theme.errorColor,
                onPressed: () => deleteTransaction(transaction.id),
              ),
      ),
    );
  }
}

//   child: Row(
//     children: [
//       Container(
//         margin:
//             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: theme.primaryColor,
//             width: 2,
//           ),
//         ),
//         padding: EdgeInsets.all(10),
//         child: Text(
//           '\₹ ${transactions[index].amount.toStringAsFixed(2)}',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: theme.primaryColor,
//           ),
//         ),
//       ),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(transactions[index].title,
//               style: theme.textTheme.headline6),
//           Text(
//             DateFormat.yMMMd().format(transactions[index].date),
//             style: TextStyle(
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       )
//     ],
//   ),
// );
