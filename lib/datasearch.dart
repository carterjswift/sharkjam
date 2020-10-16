import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'dart:async';
import 'model/video.dart';
import 'datasearch.dart';


// class DataSearch extends SearchDelegate<String> {

//   List<YT_API> ytResult = [];
//   List<Video> results = [];
//   Future<List<Video>> search(String q, YoutubeAPI api) async {
//     ytResult = await api.search(q); // Perhaps this is taking too long?

//     ytResult.forEach((YT_API vid) {
//       // print(vid.title);             // Test
//       results.add(new Video(
//         // Add video data to results[]
//         title: vid.title,
//         channel: vid.channelTitle,
//         id: vid.id,
//         duration: vid.duration,
//      ));
//     });
//   print("ytResult length is " + ytResult.length.toString()); // Test
//   return results;
// }

//   static String key = "AIzaSyAL-Dl_ehtuZP8eoVRKxxysLlBKc8gGKlM";
//   YoutubeAPI ytApi = YoutubeAPI(key);

//   final music = [
//     "On The Run", // Should be replaced with a list of available youTube video names
//     "Wake Me Up",
//     "We Are The World"
//   ];

//   final recentMusic = [
//     "On The Run", // Will be replaced with recent music names
//     "Wake Me Up",
//     "We Are The World"
//   ];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: () {
//             query = "";
//           })
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         icon: AnimatedIcon(
//           icon: AnimatedIcons.menu_arrow,
//           progress: transitionAnimation,
//         ),
//         onPressed: () {
//           close(context, null);
//         });
//   }

//   @override
//   Widget buildResults(BuildContext context) {

//     // Future<List<Video>> results = search(query, ytApi);
//     search(query, ytApi);
//     print(
//         "Submission successfully returned buildResults"); // Should be printed everytime query is entered.
//     ytResult.forEach((YT_API vid) {
//       print(vid
//           .title); // Test whether ytResult is updated at this point => Nope it's not. The size is correct though.
//     });
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Youtube API'),
//       // ),
//       body: Container(
//         child: ListView.builder(
//           itemCount: ytResult.length,
//           itemBuilder: (_, int index) => listItem(index), // Not sure why but search result is not affected until second enter.
//         ),
//       ),
//     );
//     // Create a list of cards by looping through the list, retrieving information and arranging them.
//     // for (Video vid in results)
//     // print(results);
//   }

//   ///
//   /// Code copied from youtube_api page.
//   ///
//   Widget listItem(index) {
//     print("code run has reached listItem");
//     return Card(
//       child: GestureDetector(
//         child: Container(
//           margin: EdgeInsets.symmetric(vertical: 7.0),
//           padding: EdgeInsets.all(12.0),
//           child: Row(
//             children: <Widget>[
//               Padding(padding: EdgeInsets.only(right: 15.0)),
//               Image.network(
//                 ytResult[index].thumbnail['default']['url'],
//               ),
//               Padding(padding: EdgeInsets.all(8)),
//               Expanded(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                     Text(
//                       ytResult[index].title,
//                       softWrap: true,
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                     Padding(padding: EdgeInsets.only(bottom: 1.5)),
//                     Text(
//                       ytResult[index].channelTitle,
//                       softWrap: true,
//                     ),
//                     Padding(padding: EdgeInsets.only(bottom: 3.0)),
//                     // Text(
//                     //   ytResult[index].url,
//                     //   softWrap: true,
//                     // ),
//                   ])),
//               Padding(padding: EdgeInsets.all(5)),
//               GestureDetector(
//                   child: Icon(Icons.add),
                  
                  
//               )
//             ],
//           ),
//         ),
//         onTap: () {
//           print('Add Song');
//           Video video = new Video(
//               title: ytResult[index].title, duration: ytResult[index].duration);
//           //videos.add(video);
//           //print(videos.elementAt(videos.length - 1).title);
//           // navigateToMusicControl(context);
//         },
//       ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty
//         ? recentMusic
//         : music.where((p) => p.startsWith(query)).toList();
//     // search(query, ytApi);       // If this doesn't work, I don't know what else would.
//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//         onTap: () {
//           showResults(context);
//         },
//         leading: Icon(Icons.music_note),
//         title: RichText(
//           text: TextSpan(
//               text: suggestionList[index].substring(0, query.length),
//               style:
//                   TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               children: [
//                 TextSpan(
//                     text: suggestionList[index].substring(query.length),
//                     style: TextStyle(color: Colors.grey))
//               ]),
//         ),
//       ),
//       itemCount: suggestionList.length,
//     );
//   }
// }