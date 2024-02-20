import 'package:flutter/material.dart';

AppBar appBar() {
  return AppBar(
    leading: IconButton.filled(
      onPressed: () => {},
      icon: const Icon(Icons.search_sharp),
      // color: Color.fromRGBO(35, 149, 255, 1),
    ),
    actions: [
      IconButton.filled(
        onPressed: () => {},
        icon: const Icon(Icons.list_rounded),
        color: Colors.black,
      )
    ],
  );
}
