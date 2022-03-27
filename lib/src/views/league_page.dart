import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:backdrop/backdrop.dart';
import 'package:footy/src/controllers/theme_controller.dart';
import 'package:footy/src/views/standing_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:footy/src/controllers/network_controller.dart' as network;

class LeaguePage extends StatelessWidget {
  const LeaguePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      backgroundColor: themeController.backgroundColor,
      appBar: BackdropAppBar(
        backgroundColor: themeController.appbarColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "FOOTY BALL",
          style: GoogleFonts.roboto(
            color: Colors.white,
          ),
        ),
        leading: const BackdropToggleButton(
          icon: AnimatedIcons.pause_play,
        ),
      ),
      backLayer: Container(
        width: double.infinity,
        height: double.infinity,
        color: themeController.backgroundColor,
        child: GestureDetector(
          onDoubleTap: () {},
          child: Image.asset(
            "assets/images/backLayer.png",
            colorBlendMode: BlendMode.darken,
            isAntiAlias: true,
          ),
        ),
      ),
      frontLayer: const LeagueWidget(),
      frontLayerBackgroundColor: themeController.backgroundColor.withAlpha(50),
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
    setState(() {});
    return buildLeagueWidget(context);
  }

  Widget buildLeagueWidget(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: network.leagueData!.length,
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
              onPressed: () async {
                await network.fetchSpecificLeagueData(index);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                    tag: "logo$index",
                    child: Center(
                      child: Image(
                        image: NetworkImage(
                          network.leagueData![index][2],
                        ),
                        fit: BoxFit.fill,
                        width: 72,
                        height: 72,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
