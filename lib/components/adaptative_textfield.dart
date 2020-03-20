import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final Function onSubmint;
  AdaptativeTextField(
      {@required this.label,
      @required this.textInputType,
      @required this.textEditingController,
      @required this.onSubmint});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              onSubmitted: onSubmint,
              placeholder: label,
              keyboardType: textInputType,
              controller: textEditingController,
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 6,
              ),
            ),
          )
        : TextField(
            onSubmitted: onSubmint,
            controller: textEditingController,
            keyboardType: textInputType,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
