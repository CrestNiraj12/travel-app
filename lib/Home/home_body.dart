import 'package:flutter/material.dart';
import 'package:traveller/places/Places.dart';
import 'package:traveller/recommendation/recommendation.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 50,
              ),
            ],
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: 80,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Places()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.place,
                          size: 35,
                          color: Colors.lightBlue,
                        ),
                        _button("Places"),
                      ],
                    )),
              ),
              SizedBox(
                width: 2.0,
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.only(start: .0, end: 1.0),
                    height: 50.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.wb_sunny,
                          size: 35,
                          color: Colors.lightBlue,
                        ),
                        _button("Weather")
                      ],
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 8),
          child: Text(
            "Recomendation",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 50)]),
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          height: 270,
          width: double.infinity,
          child: Recommendation(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 8),
          child: Text(
            "Nearest Places",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 50)]),
            margin: EdgeInsets.only(top: 10, bottom: 10),
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
            height: 270,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int i) => GestureDetector(
                onTap: () {},
                child: Card(
                  elevation: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 340.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Everest_North_Face_toward_Base_Camp_Tibet_Luca_Galuzzi_2006.jpg/1280px-Everest_North_Face_toward_Base_Camp_Tibet_Luca_Galuzzi_2006.jpg',
                          fit: BoxFit.cover,
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _button(String name) {
    return Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 17,
      ),
    );
  }
}
