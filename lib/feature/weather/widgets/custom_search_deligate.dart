import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.searchTerms});

  List<String> searchTerms;

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
      IconButton(
        onPressed: () {
          close(context, query);
          //print(searchTerms);
        },
        icon: const Icon(Icons.search),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var city in searchTerms ?? []) {
      if (city.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(city);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var city in searchTerms ?? []) {
      if (city.toLowerCase().contains(query.toLowerCase()) &&
          query.length >= 3) {
        matchQuery.add(city);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            query = result;
          },
          title: Text(result),
        );
      },
    );
  }
}
