import 'package:flutter/material.dart';

import 'search/data_search.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  final String title = 'Search Bar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: const Drawer(),
    );
  }
}
