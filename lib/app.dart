import 'package:flutter/material.dart';
import './components/transaction_user.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Despesas Pessoais"),
          backgroundColor: Colors.purple,
          centerTitle: true,
        ),
        body: Column(
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
            TransactionUser()
          ],
        ));
  }
}
