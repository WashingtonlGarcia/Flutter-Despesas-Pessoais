import 'package:flutter/material.dart';

import 'adaptative_date_picker.dart';
import './adaptative_button.dart';
import 'adaptative_textfield.dart';

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
              AdaptativeTextField(
                label: "Titulo",
                textInputType: TextInputType.text,
                textEditingController: _titleController,
                onSubmint: (_) => _submitForm,
              ),

              /*TextField(
                onSubmitted: (_) => _submitForm(),
                keyboardType: TextInputType.text,
                controller: _titleController,
                decoration: InputDecoration(labelText: "Titulo"),
              ),*/
              AdaptativeTextField(
                label: "Valor (R\$)",
                textInputType: TextInputType.numberWithOptions(decimal: true),
                textEditingController: _valueController,
                onSubmint: (_) => _submitForm,
              ),
              AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
              // Novo Componente
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: "Nova Transação",
                    onPressed: _submitForm,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
