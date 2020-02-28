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
  final List<Transaction> _transactions = [
    Transaction(
        id: 't0',
        title: "Conta Antiga",
        value: 310.76,
        date: DateTime.now().subtract(Duration(days: 33))),
    Transaction(
        id: 't1',
        title: "Novo Tênis de Corrida",
        value: 310.76,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: 't2',
        title: "Conta de Luz",
        value: 211.30,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
        id: 't3',
        title: "Conta Antiga",
        value: 310.76,
        date: DateTime.now().subtract(Duration(days: 33))),
    Transaction(
        id: 't4',
        title: "Novo Tênis de Corrida",
        value: 310.76,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: 't5',
        title: "Conta de Luz",
        value: 211.30,
        date: DateTime.now().subtract(Duration(days: 4))),
  ];
  List<Transaction> get _recenteTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
        //backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(
              recentTransaction: _recenteTransactions,
            ),
            TransactionList(transactions: _transactions),
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
