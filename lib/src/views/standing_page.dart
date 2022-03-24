import 'package:flutter/material.dart';
import 'package:footy/src/data/data.dart' as network;

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
                  physics: const BouncingScrollPhysics(),
                  itemCount: network.standings!.length,
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
                            "${network.standings![index][0]}",
                            textAlign: TextAlign.left,
                          ),
                          const Spacer(),
                          Text(
                            "${network.standings![index][1]}",
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
