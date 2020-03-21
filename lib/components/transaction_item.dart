import 'dart:math';

import 'package:despesasPessoais/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.tr,
    @required this.removerTransction,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String) removerTransction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];
  Color _backgroundColor;
  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(colors.length);
    _backgroundColor = colors[i];
  }

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
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(child: Text('${widget.tr.valueGet}')),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(widget.tr.dateGet),
        trailing: MediaQuery.of(context).size.width < 480
            ? IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  widget.removerTransction(widget.tr.id);
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
