import 'package:flutter/material.dart';
import 'package:traveller/recommendation/list.dart';

class Recommendation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecommendationState();
  }
}

class RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 340.0,
            child: GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RecomDetail.routeName, arguments: "1");
                },
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Boudhanath_Stupa-IMG_7048.jpg/1280px-Boudhanath_Stupa-IMG_7048.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black87.withOpacity(0.6),
                title: Text(
                  "Boudhanath Stupa",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            width: 340.0,
            child: GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RecomDetail.routeName, arguments: "1");
                },
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Boudhanath_Stupa-IMG_7048.jpg/1280px-Boudhanath_Stupa-IMG_7048.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black87.withOpacity(0.6),
                title: Text(
                  "Boudhanath Stupa",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            width: 340.0,
            child: GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RecomDetail.routeName, arguments: "1");
                },
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Boudhanath_Stupa-IMG_7048.jpg/1280px-Boudhanath_Stupa-IMG_7048.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black87.withOpacity(0.6),
                title: Text(
                  "Boudhanath Stupa",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            width: 340.0,
            child: GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RecomDetail.routeName, arguments: "1");
                },
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Boudhanath_Stupa-IMG_7048.jpg/1280px-Boudhanath_Stupa-IMG_7048.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black87.withOpacity(0.6),
                title: Text(
                  "Boudhanath Stupa",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            width: 340.0,
            child: GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RecomDetail.routeName, arguments: "1");
                },
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Boudhanath_Stupa-IMG_7048.jpg/1280px-Boudhanath_Stupa-IMG_7048.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black87.withOpacity(0.6),
                title: Text(
                  "Boudhanath Stupa",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }
}
