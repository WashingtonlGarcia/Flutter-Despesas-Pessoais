import 'package:flutter/cupertino.dart';

import './components/chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Transaction> _transactions = [];
  List<Transaction> get _recenteTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _value = false;
  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.pop(context);
  }

  final platformIOS = Platform.isIOS;
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  _removerTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  Widget _getIconButton(IconData icon, Function fn) {
    return platformIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            icon: Icon(icon),
            onPressed: fn,
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool _isLandscape = mediaQuery.orientation == Orientation.landscape;
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final iconList = platformIOS ? CupertinoIcons.refresh : Icons.list;
    final charList = platformIOS ? CupertinoIcons.refresh : Icons.show_chart;
    final actions = <Widget>[
      if (_isLandscape)
        _getIconButton(_value ? iconList : charList, () {
          setState(() {
            _value = !_value;
          });
        }),
      _getIconButton(platformIOS ? CupertinoIcons.add : Icons.add,
          () => _openTransactionFormModal(context)),
    ];
    final PreferredSizeWidget appBar = platformIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Despesas Pessoais",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text(
              "Despesas Pessoais",
            ),
            //backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            actions: actions);
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    final bodyPage = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_value || !_isLandscape)
            Container(
                height: availableHeight * (_isLandscape ? 0.7 : 0.3),
                child: Chart(
                  recentTransaction: _recenteTransactions,
                )),
          if (!_value || !_isLandscape)
            Container(
              height: availableHeight * (_isLandscape ? 1 : 0.7),
              child: TransactionList(
                transactions: _transactions,
                removerTransction: _removerTransaction,
              ),
            )
        ],
      ),
    ));
    return platformIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButtonLocation: platformIOS
                ? Container()
                : FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _openTransactionFormModal(context),
              child: Icon(Icons.add),
            ),
          );
  }
}
