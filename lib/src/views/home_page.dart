import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:backdrop/backdrop.dart';
import 'package:footy/src/data/data.dart';

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
        future: fetchLeagueData(),
        builder: (ctx, obj) {
          if (obj.connectionState == ConnectionState.done) {
            return const LeaguePage();
          } else {
            return const Center(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                  strokeWidth: 6,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class LeaguePage extends StatelessWidget {
  const LeaguePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      backgroundColor: const Color(0xFF314755),
      appBar: BackdropAppBar(
          backgroundColor: const Color.fromARGB(255, 30, 68, 92),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "FOOTY BALL",
            style: GoogleFonts.aldrich(
              color: Colors.white,
            ),
          ),
          leading: const BackdropToggleButton(
            icon: AnimatedIcons.arrow_menu,
          )),
      backLayer: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 30, 68, 92),
        child: Transform.scale(
          scale: 1.3,
          child: Image.asset(
            "assets/cr7image.jpeg",
            height: 128,
          ),
        ),
      ),
      frontLayer: const LeagueWidget(),
      frontLayerBackgroundColor: const Color(0xFF314755),
      onBackLayerRevealed: () {
        // final assetsAudioPlayer = AssetsAudioPlayer();
        // assetsAudioPlayer.open(
        //   Audio("assets/audios/song1.mp3"),
        // );
      },
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
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: leagueData!.length,
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
            color: const Color(0xFF7882A4),
            child: MaterialButton(
              onPressed: () async {
                await fetchSpecificLeagueData(index);
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => StandingPage(
                      index: index,
                      url: leagueData![index][2],
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
                          leagueData![index][2],
                        ),
                        fit: BoxFit.fill,
                        width: 72,
                        height: 72,
                      ),
                    ),
                  ),
                  Text(
                    leagueData![index][0],
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade400,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Hero(
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
            ),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: standings!.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${index + 1}"),
                          const Spacer(),
                          Text(
                            "${standings![index][0]}",
                            textAlign: TextAlign.left,
                          ),
                          const Spacer(),
                          Text(
                            "${standings![index][1]}",
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
