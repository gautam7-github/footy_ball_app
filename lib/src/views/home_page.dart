import 'package:flutter/material.dart';
import 'package:footy/src/controllers/theme_controller.dart';
import 'package:footy/src/views/league_page.dart';
import 'package:footy/src/controllers/network_controller.dart' as network;

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
      child: CircularProgressIndicator(
        color: themeController.spinnerColor,
        strokeWidth: 6,
      ),
    );
  }
}
