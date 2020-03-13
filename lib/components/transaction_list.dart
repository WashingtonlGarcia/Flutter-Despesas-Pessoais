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
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(child: Text('${tr.valueGet}')),
                  ),
                ),
                title: Text(
                  tr.title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(tr.dateGet),
                trailing: MediaQuery.of(context).size.width < 480
                    ? IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          removerTransction(tr.id);
                        })
                    : FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        label: Text("Excluir"),
                        textColor: Theme.of(context).errorColor,
                      ),
              ),
            );
          },
        );
}
