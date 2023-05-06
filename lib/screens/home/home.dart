import 'package:flutter/material.dart';
import 'package:traveller/screens/home/home_body.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super();

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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

  @override
  bool get wantKeepAlive => true;
}
