import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';
import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding();
  // SystemChrome.setPreferredOrientations([
  // DeviceOrientation.portraitUp,
  // DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        // accentColor: Colors.indigoAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.indigo)),
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
              .headline6,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (transaction) {
        return transaction.date
            .isAfter(DateTime.now().subtract(Duration(days: 7)));
      },
    ).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTrnxn = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTrnxn);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransactions(String id) {
    setState(() => _userTransactions.removeWhere((tx) => tx.id == id));
  }

  var appBar = AppBar(
    title: Text('Expense Tracker'),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 63, 119, 241),
            // Color.fromARGB(255, 45, 58, 233),
            Color.fromARGB(255, 23, 0, 78),
          ],
        ),
        // gradient: RadialGradient(
        //   radius: 8.5,
        //   stops: [
        //     0.0,
        //     0.27,
        //     1.0,
        //   ],
        //   colors: [
        //     Color.fromARGB(255, 255, 0, 43),
        //     Color.fromARGB(255, 168, 5, 32),
        //     Color.fromARGB(255, 83, 3, 40),
        //   ],
        // ),
      ),
    ),
  );

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, Widget transactionList) {
    return [
      Container(
          height: _recentTransactions.isNotEmpty
              ? (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.275
              : 0,
          child: _recentTransactions.isNotEmpty
              ? Chart(_recentTransactions)
              : null),
      transactionList
    ];
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, Widget transactionList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _recentTransactions.isNotEmpty
            ? [
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() => _showChart = val);
                    }),
              ]
            : [],
      ),
      _showChart
          ? Container(
              width: mediaQuery.size.width * 0.8,
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  (_recentTransactions.isNotEmpty ? 0.65 : 1),
              child: _recentTransactions.isNotEmpty
                  ? Chart(_recentTransactions)
                  : transactionList)
          : transactionList,
    ];
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final transactionList = Container(
      height: _recentTransactions.isNotEmpty
          ? (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              (_isLandscape ? 1 : 0.725)
          : (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top),
      child: TransactionList(_userTransactions, _deleteTransactions),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...(_isLandscape
                ? _buildLandscapeContent(mediaQuery, transactionList)
                : _buildPortraitContent(mediaQuery, transactionList))
          ],
        ),
      ),
      floatingActionButtonLocation: _isLandscape
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
