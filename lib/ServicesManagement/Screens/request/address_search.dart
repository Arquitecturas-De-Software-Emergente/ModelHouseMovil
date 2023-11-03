import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Services/place_service.dart';

class AddressSearch extends SearchDelegate<Place> {
  final List<Place> suggestions;

  AddressSearch(this.suggestions);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context); // Mostrar sugerencias al borrar el texto
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // Aquí, puedes proporcionar un valor predeterminado si es necesario
        close(context, Place("", ""));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredSuggestions = suggestions
        .where((suggestion) =>
        suggestion.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredSuggestions.isEmpty) {
      return Center(
        child: Text("No results found for '$query'"),
      );
    }

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        final suggestion = filteredSuggestions[index];
        return ListTile(
          title: Text(suggestion.description),
          onTap: () {
            close(context, suggestion);
          },
        );
      },
    );
  }

  @override
        Widget buildSuggestions(BuildContext context) {
      final filteredSuggestions = suggestions
          .where((suggestion) =>
          suggestion.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        final suggestion = filteredSuggestions[index];
        return ListTile(
          title: Text(suggestion.description),
          onTap: () {
            close(context, suggestion);
          },
        );
      },
    );
  }
}