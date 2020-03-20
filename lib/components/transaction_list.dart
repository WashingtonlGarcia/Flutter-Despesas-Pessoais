import 'package:despesasPessoais/components/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removerTransction;
  TransactionList(
      {@required this.transactions, @required this.removerTransction});

  @override
  Widget build(BuildContext context) => transactions.isEmpty
      ? LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Nenhuma Transação Cadastrada",
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        })
      : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            final tr = transactions[index];
            return TransactionItem(
                tr: tr, removerTransction: removerTransction);
          },
        );
}
