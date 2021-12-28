import 'dart:math';
import 'package:flutter/material.dart';

class Game {
  String? id;
  bool? isRunning;
  int? round;
  GameMap? map;
  Fog? fog;
  Game({
    String? id,
    bool? isRunning,
    int? round,
    GameMap? map,
    Fog? fog,
  }) {
    this.id = id;
    this.isRunning = isRunning;
    this.round = round;
    this.map = map;
    this.fog = fog;
  }

  factory Game.fromMap(Map<String, dynamic>? data) {
    return Game(
      id: data?['id'],
      round: data?['round'],
      isRunning: data?['isRunning'],
      map: GameMap.fromMap(data?['map']),
      fog: Fog.fromMap(data?['fog']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'round': this.round,
      'map': this.map?.toMap(),
      'isRunning': this.isRunning,
      'fog': this.fog?.toMap(),
    };
  }

  factory Game.newEmptyGame() {
    GameMap map = GameMap(
      name: '',
      size: 0.0,
      tallGrass: TallGrassArea.empty(),
    );

    return Game(
      id: 'alpha',
      round: 0,
      map: map,
      isRunning: false,
      fog: Fog.newFog(map.size),
    );
  }

  factory Game.newGame(String gameID, GameMap map) {
    return Game(
      id: gameID,
      round: 0,
      map: map,
      isRunning: true,
      fog: Fog.newFog(map.size),
    );
  }
}

class Fog {
  double? dx;
  double? dy;
  double? size;

  Fog({double? dx, double? dy, double? size}) {
    this.dx = dx;
    this.dy = dy;
    this.size = size;
  }

  Map<String, dynamic> toMap() {
    return {
      'dx': this.dx,
      'dy': this.dy,
      'size': this.size,
    };
  }

  factory Fog.fromMap(Map<String, dynamic>? data) {
    return Fog(
      dx: data?['dx'] * 1.0,
      dy: data?['dy'] * 1.0,
      size: data?['size'] * 1.0,
    );
  }
  factory Fog.newFog(double? mapSize) {
    double dx = (Random().nextDouble() * mapSize! * 0.8) + (mapSize * 0.1);
    double dy = (Random().nextDouble() * mapSize * 0.8) + (mapSize * 0.1);

    return Fog(
      dx: dx,
      dy: dy,
      size: mapSize * 1.7,
    );
  }

  Offset getLocation() {
    return Offset(this.dx!, this.dy!);
  }

  void shrink() {
    this.size = this.size! - 32;
    if (this.size! < 50) {
      this.size = 50;
    }
  }
}

class GameMap {
  String? name;
  double? size;
  TallGrassArea? tallGrass;
  GameMap({
    String? name,
    double? size,
    TallGrassArea? tallGrass,
  }) {
    this.name = name;
    this.size = size;
    this.tallGrass = tallGrass;
  }

  factory GameMap.fromMap(Map data) {
    return GameMap(
      name: data['name'],
      size: data['size'] * 1.0,
      tallGrass: TallGrassArea.fromMap(data['tallGrass']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'size': this.size,
      'tallGrass': this.tallGrass!.toMap(),
    };
  }
}

class TallGrassArea {
  List<Area>? totalArea;
  TallGrassArea({
    List<Area>? totalArea,
  }) {
    this.totalArea = totalArea;
  }
  factory TallGrassArea.empty() {
    return TallGrassArea(
      totalArea: [],
    );
  }

  factory TallGrassArea.fromMap(Map data) {
    List<Area> totalArea = [];
    List<dynamic> areaMap = data['totalArea'];
    areaMap.forEach((area) {
      totalArea.add(new Area.fromMap(area));
    });
    return TallGrassArea(
      totalArea: totalArea,
    );
  }

  Map<String, dynamic> toMap() {
    var totalArea = this.totalArea?.map((area) => area.toMap()).toList();
    return {
      'totalArea': totalArea,
    };
  }

  factory TallGrassArea.newTallGrass() {
    return TallGrassArea(totalArea: [
      //Start with the triangle shape in the middle and start adding the grass areas clockwise
      Area(
        area: [
          Vertex(dx: 96, dy: 120),
          Vertex(dx: 125, dy: 100),
          Vertex(dx: 140, dy: 100),
          Vertex(dx: 160, dy: 120),
        ],
      ),
      Area(
        area: [
          Vertex(dx: 264, dy: 84),
          Vertex(dx: 264, dy: 72),
          Vertex(dx: 212, dy: 72),
          Vertex(dx: 208, dy: 80),
          Vertex(dx: 212, dy: 84),
        ],
      ),
      Area(area: [
        Vertex(dx: 228, dy: 196),
        Vertex(dx: 232, dy: 192),
        Vertex(dx: 232, dy: 184),
        Vertex(dx: 208, dy: 184),
        Vertex(dx: 208, dy: 196),
      ]),
      Area(
        area: [
          Vertex(dx: 320, dy: 186),
          Vertex(dx: 296, dy: 196),
          Vertex(dx: 284, dy: 212),
          Vertex(dx: 284, dy: 220),
          Vertex(dx: 272, dy: 232),
          Vertex(dx: 272, dy: 250),
          Vertex(dx: 280, dy: 256),
          Vertex(dx: 268, dy: 268),
          Vertex(dx: 236, dy: 280),
          Vertex(dx: 215, dy: 320),
          Vertex(dx: 320, dy: 320),
        ],
      ),
      Area(
        area: [
          Vertex(dx: 104, dy: 248),
          Vertex(dx: 108, dy: 240),
          Vertex(dx: 148, dy: 240),
          Vertex(dx: 148, dy: 252),
          Vertex(dx: 108, dy: 252),
        ],
      ),
      Area(
        area: [
          Vertex(dx: 68, dy: 292),
          Vertex(dx: 108, dy: 292),
          Vertex(dx: 136, dy: 320),
          Vertex(dx: 68, dy: 320),
        ],
      ),
      Area(
        area: [
          Vertex(dx: 44, dy: 240),
          Vertex(dx: 40, dy: 232),
          Vertex(dx: 24, dy: 216),
          Vertex(dx: 0, dy: 216),
          Vertex(dx: 0, dy: 320),
          Vertex(dx: 44, dy: 320),
        ],
      ),
      Area(
        area: [
          Vertex(dx: 32, dy: 136),
          Vertex(dx: 56, dy: 136),
          Vertex(dx: 40, dy: 120),
          Vertex(dx: 48, dy: 112),
          Vertex(dx: 40, dy: 104),
          Vertex(dx: 36, dy: 96),
          Vertex(dx: 0, dy: 96),
          Vertex(dx: 0, dy: 168),
          Vertex(dx: 24, dy: 168),
          Vertex(dx: 44, dy: 148),
        ],
      ),
    ]);
  }
}

class Area {
  List<Vertex>? area;
  Area({List<Vertex>? area}) {
    this.area = area;
  }
  factory Area.fromMap(Map data) {
    List<Vertex> area = [];
    List<dynamic> areaMap = data['area'];
    areaMap.forEach((vertex) {
      area.add(new Vertex.fromMap(vertex));
    });
    return Area(
      area: area,
    );
  }

  Map<String, dynamic> toMap() {
    var area = this.area?.map((vertex) => vertex.toMap()).toList();
    return {
      'area': area,
    };
  }

  List<Offset> toPoly() {
    List<Offset> poly = [];
    this.area!.forEach((vertex) {
      poly.add(vertex.toOffset());
    });

    return poly;
  }

  bool inHere(Offset location) {
    Path grass = Path();
    grass.addPolygon(toPoly(), true);
    return grass.contains(location);
  }
}

class Vertex {
  double? dx;
  double? dy;
  Vertex({
    double? dx,
    double? dy,
  }) {
    this.dx = dx;
    this.dy = dy;
  }

  factory Vertex.fromMap(Map data) {
    return Vertex(
      dx: data['dx'],
      dy: data['dy'] * 1.0,
    );
  }

  factory Vertex.newVertex(Offset location) {
    return Vertex(
      dx: location.dx,
      dy: location.dy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dx': this.dx,
      'dy': this.dy,
    };
  }

  Offset toOffset() {
    return Offset(this.dx!, this.dy!);
  }
}
