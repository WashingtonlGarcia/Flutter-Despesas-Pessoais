import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({@required this.onSubmit});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  _submitForm() {
    final title = _titleController.text;
    final value = double.parse(_valueController.text) ?? 0.0;
    if (_titleController.text.isEmpty ||
        double.parse(_valueController.text) <= 0 ||
        _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              TextField(
                onSubmitted: (_) => _submitForm(),
                keyboardType: TextInputType.text,
                controller: _titleController,
                decoration: InputDecoration(labelText: "Titulo"),
              ),
              TextField(
                onSubmitted: (_) => _submitForm(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _valueController,
                decoration: InputDecoration(labelText: "Valor (R\$)"),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : "Data selecionada: ${DateFormat("d/MM/y").format(this._selectedDate).toString()}",
                      ),
                    ),
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _showDatePicker,
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
      ),
    );
  }
}
