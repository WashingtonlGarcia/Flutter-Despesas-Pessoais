import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.value,
      @required this.date});
  get dateGet => DateFormat("d MMM y").format(this.date).toString();
  get valueGet => "R\$ ${value.toStringAsFixed(2)}";
}
