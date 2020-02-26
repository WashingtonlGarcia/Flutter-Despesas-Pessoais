import 'package:despesasPessoais/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final _transactions = [
    Transaction(
        id: "ti",
        title: "Novo Tênis de Corrida",
        value: 310.76,
        date: DateTime.now()),
    Transaction(
        id: "t2", title: "Conta de luz", value: 211.30, date: DateTime.now())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Despesas Pessoais"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              // width: double.infinity,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('Grafico'),
              ),
            ),
            Card(
              color: Colors.blue,
              elevation: 5,
              child: Text("Lista de Transações"),
            )
          ],
        ));
  }
}
