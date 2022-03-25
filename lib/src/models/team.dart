List<Standings> standings = [];

class TeamModel {
  TeamModel();

  TeamModel.fromJson(Map<String, dynamic> json) {
    if (json['standings'] != null) {
      standings = <Standings>[];
      json['standings'].forEach((v) {
        standings.add(
          Standings.fromJson(v),
        );
      });
    }
  }
}

class Standings {
  Team? team;
  Note? note;
  List<Stats>? stats;

  Standings({this.team, this.note, this.stats});

  Standings.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(Stats.fromJson(v));
      });
    }
  }
}

class Team {
  String? id;
  String? uid;
  String? location;
  String? name;
  String? abbreviation;
  String? displayName;
  String? shortDisplayName;
  bool? isActive;
  List<Logos>? logos;

  Team(
      {this.id,
      this.uid,
      this.location,
      this.name,
      this.abbreviation,
      this.displayName,
      this.shortDisplayName,
      this.isActive,
      this.logos});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    location = json['location'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    displayName = json['displayName'];
    shortDisplayName = json['shortDisplayName'];
    isActive = json['isActive'];
    if (json['logos'] != null) {
      logos = <Logos>[];
      json['logos'].forEach((v) {
        logos!.add(Logos.fromJson(v));
      });
    }
  }
}

class Logos {
  String? href;
  int? width;
  int? height;
  String? alt;
  List<String>? rel;
  String? lastUpdated;

  Logos(
      {this.href,
      this.width,
      this.height,
      this.alt,
      this.rel,
      this.lastUpdated});

  Logos.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    width = json['width'];
    height = json['height'];
    alt = json['alt'];
    rel = json['rel'].cast<String>();
    lastUpdated = json['lastUpdated'];
  }
}

class Note {
  String? color;
  String? description;
  int? rank;

  Note({this.color, this.description, this.rank});

  Note.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    description = json['description'];
    rank = json['rank'];
  }
}

class Stats {
  String? name;
  String? displayName;
  String? shortDisplayName;
  String? description;
  String? abbreviation;
  String? type;
  int? value;
  String? displayValue;
  String? id;
  String? summary;

  Stats(
      {this.name,
      this.displayName,
      this.shortDisplayName,
      this.description,
      this.abbreviation,
      this.type,
      this.value,
      this.displayValue,
      this.id,
      this.summary});

  Stats.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayName = json['displayName'];
    shortDisplayName = json['shortDisplayName'];
    description = json['description'];
    abbreviation = json['abbreviation'];
    type = json['type'];
    value = json['value'];
    displayValue = json['displayValue'];
    id = json['id'];
    summary = json['summary'];
  }
}
