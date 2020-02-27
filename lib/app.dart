import 'package:flutter/material.dart';
import 'dart:math';

import './components/transaction_form.dart';

import 'components/transaction_list.dart';
import 'models/transaction.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _transactions = [
    Transaction(
      id: "t1",
      title: "Novo Tênis de Corrida",
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Conta de luz",
      value: 211.30,
      date: DateTime.now(),
    )
  ];

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
        backgroundColor: Colors.purple,
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
            Container(
              // width: double.infinity,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('Grafico'),
              ),
            ),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
