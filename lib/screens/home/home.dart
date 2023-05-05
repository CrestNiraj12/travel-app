import 'package:flutter/material.dart';
import 'home_body.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Traveller",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              background: Image.asset(
                "images/bg.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      },
      body: HomeBody(),
    );
  }
}
