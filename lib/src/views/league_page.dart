import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:footy/src/controllers/theme_controller.dart';
import 'package:footy/src/views/standing_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:footy/src/controllers/network_controller.dart' as network;

class LeaguePage extends StatelessWidget {
  const LeaguePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.backgroundColor.withAlpha(200),
      body: const LeagueWidget(),
    );
  }
}

class LeagueWidget extends StatefulWidget {
  const LeagueWidget({Key? key}) : super(key: key);

  @override
  State<LeagueWidget> createState() => _LeagueWidgetState();
}

class _LeagueWidgetState extends State<LeagueWidget> {
  @override
  Widget build(BuildContext context) {
    return buildLeagueWidget(context);
  }

  Widget buildLeagueWidget(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 6, //network.leagueData!.length,
      itemBuilder: (ctx, index) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.all(12),
            elevation: 12,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            color: themeController.cardColor.withAlpha(200),
            child: MaterialButton(
              onPressed: () {
                HapticFeedback.vibrate();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => StandingPage(
                      index: index,
                      url: network.leagueData![index][2],
                    ),
                  ),
                );
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              highlightColor: Colors.green.shade500,
              child: buildLeagueCard(
                ctx,
                index,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildLeagueCard(BuildContext ctx, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Hero(
          tag: "logo$index",
          child: Center(
            child: CachedNetworkImage(
              imageUrl: network.leagueData![index][2],
              fit: BoxFit.fill,
              height: 72,
              width: 72,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: themeController.spinnerColor2,
              ),
            ),
          ),
        ),
        Text(
          network.leagueData![index][0],
          softWrap: true,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
