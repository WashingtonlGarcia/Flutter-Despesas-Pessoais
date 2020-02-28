import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm({@required this.onSubmit});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.parse(valueController.text) ?? 0.0;
    if (titleController.text.isEmpty ||
        double.parse(valueController.text) <= 0) {
      return;
    }
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (_) => _submitForm(),
              keyboardType: TextInputType.text,
              controller: titleController,
              decoration: InputDecoration(labelText: "Titulo"),
            ),
            TextField(
              onSubmitted: (_) => _submitForm(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: valueController,
              decoration: InputDecoration(labelText: "Valor (R\$)"),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text('Nenhuma data selecionada!'),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {},
                      child: Text(
                        "Selecionar Data",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                    //hoverColor: Colors.purpleAccent,
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: _submitForm,
                    child: Text(
                      "Nova Transação",
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
