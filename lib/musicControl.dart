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
        title: Text("Music Player",
            style: TextStyle(
              color: Colors.white
            )
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Image(
                  image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/en/3/3b/Dark_Side_of_the_Moon.png",
                  scale: 0.9,
                  )
              ),
          ),
          Container(
            child: Text("On The Run",       // Will be replaced with music title.
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Roboto",
                fontSize: 30.0,
              )
            )
          ),
          Container(
              child: Text("Pink Floyd",       // Will be replaced with music artist.
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontSize: 20.0,
                  )
              )
          ),
          Container(
              // child: Slider              // Will implement slider later.
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Image.asset(
                        "assets/back.png",
                        color: Colors.white,
                    ),
                    iconSize: 120,
                    onPressed:(){},
                  ),
                  IconButton(
                    icon: Image.asset(
                        "assets/pause.png",
                        color: Colors.white,
                    ),
                    iconSize: 120,
                    onPressed:(){},
                  ),
                  IconButton(
                    icon: Image.asset(
                        "assets/forward.png",
                        color: Colors.white,
                    ),
                    iconSize: 120,
                    onPressed:(){},
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
