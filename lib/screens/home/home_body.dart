import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/recommendation/recommendation.dart';
import 'package:traveller/screens/destination/destination_screen.dart';
import 'package:traveller/states/bottom_nav.provider.dart';

class HomeBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CollectionReference destinationsDoc =
        FirebaseFirestore.instance.collection('destinations');

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
                      ref.read(bottomNavProvider.notifier).state = 0;
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
                    onTap: () {
                      ref.read(bottomNavProvider.notifier).state = 1;
                    },
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
        FutureBuilder<QuerySnapshot>(
          future: destinationsDoc.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return SizedBox.shrink();

            final destinations = snapshot.data?.docs ?? [];
            if (destinations.isNotEmpty) {
              return Container(
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 50)]),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                height: 270,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: destinations.length,
                  itemBuilder: (BuildContext context, int i) {
                    final id = destinations[i].id;
                    var data = destinations[i].data();
                    if (data != null) {
                      data = data as Map<String, dynamic>;
                      data['id'] = id;

                      final destination = Destination.fromJson(data);
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DestinationScreen(destination: destination),
                            ),
                          );
                        },
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
                                    destination.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
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