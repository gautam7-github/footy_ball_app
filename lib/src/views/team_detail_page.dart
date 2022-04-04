import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:footy/src/controllers/network_controller.dart';
import 'package:footy/src/controllers/theme_controller.dart';
import 'package:footy/src/models/team.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamDetailPage extends StatefulWidget {
  int? index;
  TeamDetailPage({Key? key, required this.index}) : super(key: key);

  @override
  State<TeamDetailPage> createState() => _TeamDetailPageState();
}

class _TeamDetailPageState extends State<TeamDetailPage> {
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );
  int _currentPage = 0;

  bool end = false;
  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(
          seconds: 5,
        ), (Timer timer) {
      if (_currentPage == 9) {
        end = true;
      } else if (_currentPage == 0) {
        end = false;
      }

      if (end == false) {
        _currentPage++;
      } else {
        _currentPage--;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(
          milliseconds: 3000,
        ),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      standings[widget.index!].team!.logos![0].href.toString(),
                  width: 72,
                  height: 72,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: themeController.spinnerColor1,
                  ),
                ),
                Hero(
                  tag: "team${widget.index}",
                  child: Text(
                    "${standings[widget.index!].team!.displayName}",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                children: [
                  for (var i = 0; i < 10; i++)
                    Card(
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
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
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
                                fontSize: 16,
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
            Spacer(),
          ],
        ),
      ),
    );
  }
}
