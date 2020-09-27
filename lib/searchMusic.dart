import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF261D1D),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFF261D1D),
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text("Add Music",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0
            )
        ),
          centerTitle: true,
          actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: DataSearch());
          })
        ]
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>{
  final cities = [
    "On The Run",     // Will be replaced with a list of available music name
    "Wake Me Up",
    "We Are The World"
  ];

  final recentCities = [
    "On The Run",     // Will be replaced with recent music names
    "Wake Me Up",
    "We Are The World"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = "";
          }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty?recentCities:cities;
    return ListView.builder(itemBuilder: (context, index) =>ListTile(
      leading: Icon(Icons.music_note),
      title: Text(suggestionList[index]),
    ),
      itemCount: suggestionList.length,
    );
  }
  
}