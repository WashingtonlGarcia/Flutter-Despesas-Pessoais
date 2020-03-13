import './components/chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Transaction> _transactions = [];
  List<Transaction> get _recenteTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _value = false;
  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.pop(context);
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  _removerTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool _isLandscape = mediaQuery.orientation == Orientation.landscape;
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
      ),
      //backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      actions: <Widget>[
        if (_isLandscape)
          IconButton(
              icon: Icon(_value ? Icons.list : Icons.show_chart),
              onPressed: () {
                setState(() {
                  _value = !_value;
                });
              }),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context)),
      ],
    );
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_value || !_isLandscape)
              Container(
                  height: availableHeight * (_isLandscape ? 0.7 : 0.3),
                  child: Chart(
                    recentTransaction: _recenteTransactions,
                  )),
            if (!_value || !_isLandscape)
              Container(
                height: availableHeight * (_isLandscape ? 1 : 0.7),
                child: TransactionList(
                  transactions: _transactions,
                  removerTransction: _removerTransaction,
                ),
              )
          ],
        ),
      ),
      floatingActionButtonLocation: Platform.isIOS
          ? Container()
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
