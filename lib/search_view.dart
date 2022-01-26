import 'package:flutter/material.dart';

import 'repo/cities.dart';

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

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    //actions for appbar
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // leading icon on the left of the appbar
    return IconButton(
      onPressed: () {
        close(context, 'null');
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result base on the selection
    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: Card(
          color: Colors.red,
          shape: const StadiumBorder(),
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searches for something
    final suggestionList = query.isEmpty
        ? TurkeyCity.recentCities
        : TurkeyCity.cities
            .where((element) => element.startsWith(query))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showResults(context);
          },
          leading: const Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: const TextStyle(color: Colors.grey),
                  )
                ]),
          ),
        );
      },
    );
  }
}
