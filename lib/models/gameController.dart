import 'package:cloud_firestore/cloud_firestore.dart';

import 'game.dart';

class GameController {
  final database = FirebaseFirestore.instance;

  String gameID = 'alpha';

  Stream<Game> pullGameFromDataBase() {
    return database
        .collection('game')
        .doc(gameID)
        .snapshots()
        .map((game) => Game.fromMap(game.data()));
  }

  void newGame(GameMap map) {
    Game game = Game.newGame(this.gameID, map);

    database.collection('game').doc(this.gameID).set(game.toMap());
  }

  void deleteGame() async {
    Game game = Game.newEmptyGame();
    database.collection('game').doc(this.gameID).set(game.toMap());
  }

  void newRound(int currentRound) async {
    int nextRound = currentRound + 1;
    await database.collection('game').doc(gameID).update({'round': nextRound});
  }

  // void checkForEndGame(List<Player> players) {
  //   int deadPlayers = 0;
  //   players.forEach((player) {
  //     if (player.life < 1) {
  //       deadPlayers++;
  //     }
  //   });
  //   if (deadPlayers == players.length - 1) {
  //     throw EndGameException();
  //   }
  // }

  // double fogSize;

  // void setFogSize() {
  //   this.fogSize = game.mapSize - this.game.round * 5;
  // }
}
