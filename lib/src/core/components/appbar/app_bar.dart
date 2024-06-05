import 'package:flutter/material.dart';
import 'package:weathered/src/features/search/view/customsearch.dart';
// TODO: Complete the search bar if time allows

// Appbar which Contains the search icon as the leading and list icon as the trailing/actions
AppBar appBar(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        icon: const Icon(Icons.search_rounded),
        color: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchCity()),
          );
        },
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IconButton(
          icon: const Icon(Icons.add_rounded),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {},
        ),
      )
    ],
    backgroundColor: Colors.transparent,
  );
}
