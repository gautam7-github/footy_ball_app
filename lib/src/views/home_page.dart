import 'package:flutter/material.dart';
import 'package:footy/src/views/league_page.dart';
import 'package:footy/src/data/data.dart' as network;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF314755),
      body: FutureBuilder(
        future: network.fetchLeagueData(),
        builder: (ctx, obj) {
          if (obj.connectionState == ConnectionState.done) {
            return const LeaguePage();
          } else {
            return Center(
              child: buildLoader(
                ctx,
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildLoader(BuildContext ctx) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.purple,
        strokeWidth: 6,
      ),
    );
  }
}
