import 'package:footy/src/models/team.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String URL = "https://api-football-standings.azharimm.site/leagues";
List<dynamic>? leagueData = [];
String? leagueName = "";
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
  http.Response? resp;
  try {
    resp = await http.get(
      Uri.parse(URL),
    );
  } catch (e) {
    print("Error : $e");
  }
  var jsonData = jsonDecode(resp!.body);
  for (var item in jsonData['data']) {
    if (slugs.contains(item['slug'])) {
      leagueData!.add(
          [item['name'], item['abbr'], item['logos']['light'], item['id']]);
    }
  }
}

Future<void> fetchSpecificLeagueData(int index) async {
  standings = [];
  leagueName = leagueData![index][0];
  var resp = await http.get(
    Uri.parse(
      URL + "/${leagueData![index][3]}/standings?season=2021&sort=asc",
    ),
  );
  var data = jsonDecode(resp.body)['data'];
  TeamModel.fromJson(data);
}
