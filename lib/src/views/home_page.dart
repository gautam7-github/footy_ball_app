import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footy/src/controllers/theme_controller.dart';
import 'package:footy/src/views/league_page.dart';
import 'package:footy/src/controllers/network_controller.dart' as network;
// import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

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
            HapticFeedback.vibrate();
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
    HapticFeedback.vibrate();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Lottie.asset(
              "assets/images/football.json",
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
