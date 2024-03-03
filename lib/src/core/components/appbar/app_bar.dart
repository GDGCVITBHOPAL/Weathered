import 'package:flutter/material.dart';

// TODO: Replace the current appbar with just a search bar

// Appbar which Contains the search icon as the leading and list icon as the trailing/actions
AppBar appBar(BuildContext context) {
  return AppBar(
      
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IconButton(
          icon: const Icon(Icons.search_rounded),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {},
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
      ]
      );
}
