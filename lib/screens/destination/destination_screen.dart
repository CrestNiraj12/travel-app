import 'package:flutter/material.dart';
import 'package:traveller/models/destination.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({
    required this.destination,
  });

  final Destination destination;

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  late String firstHalf;

  late String secondHalf;

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    if (destination.description.length > 50) {
      firstHalf = destination.description.substring(0, 100);
      secondHalf =
          destination.description.substring(50, destination.description.length);
    } else {
      firstHalf = destination.description;
      secondHalf = "";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.name),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 220,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: Image.network(
                  destination.imageUrl,
                  fit: BoxFit.fill,
                  height: 280,
                  width: double.infinity,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 221.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 3, left: 15, right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Card(
                      child: Container(
                          height: 90,
                          color: Color.fromRGBO(55, 70, 105, 1),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 90,
                                width: 70,
                                color: Color.fromRGBO(95, 115, 150, 1),
                                child: Icon(
                                  Icons.flag,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Country :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            destination.country,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Place :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            destination.name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 3, left: 15, right: 15),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(30),
                //     child: Card(
                //       child: Container(
                //           height: 105,
                //           color: Color.fromRGBO(55, 70, 105, 1),
                //           child: Row(
                //             children: <Widget>[
                //               Container(
                //                 height: 105,
                //                 width: 70,
                //                 color: Color.fromRGBO(95, 115, 150, 1),
                //                 child: Icon(
                //                   Icons.place,
                //                   color: Colors.white,
                //                   size: 60,
                //                 ),
                //               ),
                //               SizedBox(
                //                 width: 10,
                //               ),
                //               Expanded(
                //                 child: Column(
                //                   children: <Widget>[
                //                     Expanded(
                //                       child: Row(
                //                         children: <Widget>[
                //                           Text(
                //                             "Location :",
                //                             style: TextStyle(
                //                                 fontSize: 15,
                //                                 color: Colors.white,
                //                                 fontWeight: FontWeight.bold),
                //                           ),
                //                           SizedBox(
                //                             width: 7,
                //                           ),
                //                           Expanded(
                //                             child: Text(
                //                               destination.location,
                //                               style: TextStyle(
                //                                   color: Colors.white,
                //                                   fontSize: 15),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           )),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 15.0, top: 8, left: 15, right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Card(
                      color: Color.fromRGBO(55, 70, 105, 1),
                      child: Column(
                        children: <Widget>[
                          Container(
                              color: Color.fromRGBO(95, 115, 150, 1),
                              height: 30,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )),
                          SizedBox(
                            height: 1,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5.0),
                            color: Color.fromRGBO(55, 70, 105, 1),
                            child: secondHalf.isEmpty
                                ? new Text(firstHalf)
                                : new Column(
                                    children: <Widget>[
                                      new Text(
                                        flag
                                            ? (firstHalf + "...")
                                            : (firstHalf + secondHalf),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      new InkWell(
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Text(
                                              flag ? "show more" : "show less",
                                              style: new TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            flag = !flag;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
