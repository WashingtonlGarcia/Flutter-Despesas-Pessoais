import 'package:despesasPessoais/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.tr,
    @required this.removerTransction,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String) removerTransction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
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
                icon: const Icon(
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
                label: const Text("Excluir"),
                textColor: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
