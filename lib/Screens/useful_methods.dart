import 'package:flutter/material.dart';

void push(BuildContext context, final Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => page,
    ),
  );
}
