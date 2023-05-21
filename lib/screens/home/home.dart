import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveller/screens/home/home_body.dart';
import 'package:traveller/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super();

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
            expandedHeight: 100.0,
            pinned: false,
            floating: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 20.0),
              title: Text(
                "Traveller",
                style: GoogleFonts.pacifico(
                  fontSize: 18,
                  color: AppColors.blue,
                ),
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
