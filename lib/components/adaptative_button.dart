import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  AdaptativeButton({
    @required this.label,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Theme.of(context).primaryColor,
            child: Text(label),
            onPressed: onPressed,
            padding: EdgeInsets.symmetric(horizontal: 20),
          )
        : InkWell(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).primaryColor),
              child: Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).textTheme.button.color,
                ),
              ),
            ),
          );

    /*RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).textTheme.button.color,
      onPressed: onPressed,
      child: Text(label),
    );*/
  }
}
