import 'package:http/http.dart' as http;
import 'dart:convert';

const String URL = "https://api-football-standings.azharimm.site/leagues";
List<dynamic>? leagueData = [];
List<dynamic>? standings = [];

List<String> slugs = [
  "english-premier-league",
  "spanish-primera-division",
  "french-ligue-1",
  "german-bundesliga",
  "italian-serie-a",
  "dutch-eredivisie",
];
Future<void> fetchLeagueData() async {
  leagueData = [];
  var resp = await http.get(
    Uri.parse(URL),
  );
  var jsonData = jsonDecode(resp.body);
  for (var item in jsonData['data']) {
    if (slugs.contains(item['slug'])) {
      // dutch and french logos are shit!!
      // they dont work with the overall dark theme of the application
      if ((item['slug'] != "dutch-eredivisie") &&
          (item['slug'] != "french-ligue-1")) {
        leagueData!.add(
            [item['name'], item['abbr'], item['logos']['light'], item['id']]);
      } else {
        leagueData!.add(
            [item['name'], item['abbr'], item['logos']['dark'], item['id']]);
      }
    }
  }
}

Future<void> fetchSpecificLeagueData(int index) async {
  standings = [];
  var resp = await http.get(
    Uri.parse(
      URL + "/${leagueData![index][3]}/standings?season=2021&sort=asc",
    ),
  );
  var data = jsonDecode(resp.body)['data']['standings'];
  for (var stand in data) {
    standings!.add([stand['team']['name'], stand['stats'][6]['value']]);
  }
}
