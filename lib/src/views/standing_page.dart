import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footy/src/controllers/network_controller.dart' as network;
import 'package:footy/src/controllers/theme_controller.dart';
import 'package:footy/src/models/team.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StandingPage extends StatefulWidget {
  String? url;
  int? index;
  StandingPage({Key? key, required this.url, required this.index})
      : super(key: key);

  @override
  State<StandingPage> createState() => _StandingPageState();
}

class _StandingPageState extends State<StandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.appbarColor,
      body: SafeArea(
        child: buildTable(
          context,
        ),
      ),
    );
  }

  Widget buildTable(BuildContext ctx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Hero(
          tag: "logo${widget.index}",
          child: Center(
            child: CachedNetworkImage(
              imageUrl: widget.url.toString(),
              fit: BoxFit.fill,
              width: 72,
              height: 72,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: themeController.spinnerColor2,
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: network.fetchSpecificLeagueData(
            widget.index!,
          ),
          builder: (context, obj) {
            if (obj.connectionState == ConnectionState.done) {
              return buildTeams(
                ctx,
              );
            } else {
              return buildLoader(
                ctx,
              );
            }
          },
        ),
      ],
    );
  }

  Widget buildTeams(BuildContext ctx) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: standings.length,
        itemBuilder: (ctx, index) {
          return Container(
            height: MediaQuery.of(context).size.height / 7,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withAlpha(100),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  12,
                ),
              ),
            ),
            child: Card(
              color: themeController.appbarColor.withAlpha(200),
              elevation: 8,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    12,
                  ),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl:
                              standings[index].team!.logos![0].href.toString(),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: themeController.spinnerColor1,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${standings[index].team!.displayName}",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 18,
                      ),
                      child: Text(
                        "${standings[index].stats![6].displayValue}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoader(BuildContext ctx) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: themeController.spinnerColor2,
        size: MediaQuery.of(context).size.width / 5,
      ),
    );
  }
}
