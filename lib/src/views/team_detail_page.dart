import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:footy/src/controllers/theme_controller.dart';
import 'package:footy/src/models/team.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamDetailPage extends StatefulWidget {
  late int? index;
  TeamDetailPage({Key? key, required this.index}) : super(key: key);

  @override
  State<TeamDetailPage> createState() => _TeamDetailPageState();
}

class _TeamDetailPageState extends State<TeamDetailPage> {
  PageController? controller;
  @override
  void initState() {
    controller = PageController(
      initialPage: 0,
      viewportFraction: 0.7,
    );
    super.initState();
  }

  void nextPage() {
    controller!.animateToPage(
      controller!.page!.toInt() + 1,
      duration: const Duration(
        milliseconds: 400,
      ),
      curve: Curves.decelerate,
    );
  }

  void previousPage() {
    controller!.animateToPage(
      controller!.page!.toInt() - 1,
      duration: const Duration(
        milliseconds: 400,
      ),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 28,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: CachedNetworkImage(
                      imageUrl: standings[widget.index!]
                          .team!
                          .logos![0]
                          .href
                          .toString(),
                      width: 72,
                      height: 72,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: themeController.spinnerColor1,
                      ),
                    ),
                  ),
                  Hero(
                    tag: "team${widget.index}",
                    child: Text(
                      "${standings[widget.index!].team!.displayName}",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                children: [
                  for (var i = 0; i < 10; i++)
                    Card(
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                      ),
                      color: themeController.backgroundColor,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              standings[widget.index!]
                                  .stats![i]
                                  .displayName
                                  .toString(),
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 20,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text(
                              standings[widget.index!]
                                  .stats![i]
                                  .displayValue
                                  .toString(),
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 56,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: null,
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      previousPage();
                    },
                    child: Icon(
                      Icons.chevron_left_rounded,
                      color: themeController.cardColor,
                      size: 32,
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    padding: null,
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      nextPage();
                    },
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: themeController.cardColor,
                      size: 32,
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
