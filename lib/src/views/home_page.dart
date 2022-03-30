import 'package:flutter/material.dart';
import 'package:footy/src/controllers/theme_controller.dart';
import 'package:footy/src/views/league_page.dart';
import 'package:footy/src/controllers/network_controller.dart' as network;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.backgroundColor,
      body: FutureBuilder(
        future: network.fetchLeagueData(),
        builder: (ctx, obj) {
          if (obj.connectionState == ConnectionState.done) {
            return const LeaguePage();
          } else {
            return buildLoader(
              ctx,
            );
          }
        },
      ),
    );
  }

  Widget buildLoader(BuildContext ctx) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: LoadingAnimationWidget.inkDrop(
              color: themeController.spinnerColor2,
              size: MediaQuery.of(context).size.width / 5,
            ),
          ),
          const Spacer(),
          Image.asset(
            "assets/images/backLayer.png",
            scale: 1.25,
          ),
        ],
      ),
    );
  }
}
