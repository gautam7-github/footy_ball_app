import 'package:flutter/material.dart';
import 'package:footy/src/controllers/network_controller.dart' as network;
import 'package:footy/src/controllers/theme_controller.dart';
import 'package:footy/src/models/team.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: "logo${widget.index}",
              child: Center(
                child: Image(
                  image: NetworkImage(widget.url.toString()),
                  fit: BoxFit.fill,
                  width: 72,
                  height: 72,
                ),
              ),
            ),
            Text(
              "${network.leagueName}",
            ),
          ],
        ),
        FutureBuilder(
          future: network.fetchSpecificLeagueData(
            widget.index!,
          ),
          builder: (context, obj) {
            if (obj.connectionState == ConnectionState.done) {
              return Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: standings.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: SizedBox(
                          child: Card(
                            elevation: 8,
                            // color: Colors.grey.shade900,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  12,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Table(
                                columnWidths: const <int, TableColumnWidth>{
                                  0: FlexColumnWidth(),
                                  1: FlexColumnWidth(),
                                  2: FlexColumnWidth(),
                                },
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          12,
                                        ),
                                      ),
                                    ),
                                    children: [
                                      Image.network(
                                        "${standings[index].team!.logos![0].href}",
                                      ),
                                      Text(
                                        "${standings[index].team!.displayName}",
                                      ),
                                      Text(
                                        "${standings[index].stats![6].displayValue}",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
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

  Widget buildLoader(BuildContext ctx) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: themeController.spinnerColor,
        size: MediaQuery.of(context).size.width / 5,
      ),
    );
  }
}
// Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(
//                                 "${index + 1}",
//                                 style: GoogleFonts.roboto(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 "${network.standings![index][0]}",
//                                 textAlign: TextAlign.left,
//                                 style: GoogleFonts.roboto(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 "${network.standings![index][1]}",
//                                 style: GoogleFonts.roboto(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),