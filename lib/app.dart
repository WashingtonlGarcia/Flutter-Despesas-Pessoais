import './components/chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
    final appBar = AppBar(
      title: Text("Despesas Pessoais"),
      //backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context))
      ],
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: availableHeight * 0.3,
              child: Chart(
                recentTransaction: _recenteTransactions,
              ),
            ),
            Container(
              height: availableHeight * 0.7,
              child: TransactionList(
                transactions: _transactions,
                removerTransction: _removerTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
