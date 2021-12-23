// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dsixv02app/shared/app_Exceptions.dart';
// import 'player.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';

import '../turn.dart';
import 'player.dart';

class User {
  String? selectedPlayerID;

  Player? selectedPlayer;
  String? playerMode = 'walk';
  bool playerTurn = false;
  bool menuIsOpen = false;
  final firebase = FirebaseFirestore.instance.collection('game');

  void selectPlayer(
    String? id,
    int? index,
    Player? player,
  ) {
    this.selectedPlayerID = id;
    this.selectedPlayer = player;
  }

  void endWalk(
    String gameID,
    PlayerLocation newLocation,
  ) async {
    this.selectedPlayer!.location!.dx = newLocation.dx;
    this.selectedPlayer!.location!.dy = newLocation.dy;

    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({'location': this.selectedPlayer!.location!.toMap()});
  }

  void takeAction(String gameID) async {
    this.selectedPlayer!.action!.takeAction();

    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({'action': this.selectedPlayer!.action!.toMap()});
  }

  void checkForPlayerTurn(List<Turn> turnOrder) {
    if (turnOrder.isEmpty) {
      throw NotPlayerTurnException();
    }

    if (turnOrder.first.id != this.selectedPlayerID) {
      throw NotPlayerTurnException();
    }

    if (this.selectedPlayer!.action!.outOfActions() &&
        this.playerTurn == false) {
      throw StartPlayerTurnException();
    }
    throw ContinuePlayerTurnException();
  }

  void startPlayerTurn() {
    this.selectedPlayer!.action!.newActions();
    this.playerTurn = true;
    setPlayerMode();
  }

  void continuePlayerTurn() {
    this.playerTurn = true;
    setPlayerMode();
  }

  void endPlayerTurn() {
    this.playerTurn = false;
    setPlayerMode();
  }

  void setPlayerMode() {
    if (this.playerTurn) {
      if (this.playerMode == 'wait') {
        walkMode();
      }
      if (this.menuIsOpen) {
        waitMode();
      }
    } else {
      waitMode();
    }
  }

  void openCloseMenu() {
    if (this.menuIsOpen) {
      if (this.playerTurn) {
        walkMode();
      } else {
        waitMode();
      }
      this.menuIsOpen = false;
    } else {
      this.menuIsOpen = true;
    }
  }

  void walkMode() {
    this.playerMode = 'walk';
  }

  void waitMode() {
    this.playerMode = 'wait';
  }

  void attackMode() {
    this.playerMode = 'attack';
    this.menuIsOpen = false;
  }

  void updateBag(
    String gameID,
  ) async {
    var updatedBag =
        this.selectedPlayer!.bag!.map((item) => item.toMap()).toList();

    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({
      'bag': updatedBag,
      'weight': this.selectedPlayer!.weight,
    });
  }

  void updateIventory(
    String gameID,
  ) async {
    List<Map<String, dynamic>> updatedBag =
        this.selectedPlayer!.bag!.map((item) => item.toMap()).toList();

    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({
      'bag': updatedBag,
      'mainHandSlot': this.selectedPlayer!.mainHandSlot!.toMap(),
      'offHandSlot': this.selectedPlayer!.offHandSlot!.toMap(),
      'headSlot': this.selectedPlayer!.headSlot!.toMap(),
      'bodySlot': this.selectedPlayer!.bodySlot!.toMap(),
      'handSlot': this.selectedPlayer!.handSlot!.toMap(),
      'feetSlot': this.selectedPlayer!.feetSlot!.toMap(),
      'pDamage': this.selectedPlayer!.pDamage,
      'mDamage': this.selectedPlayer!.mDamage,
      'pArmor': this.selectedPlayer!.pArmor,
      'mArmor': this.selectedPlayer!.mArmor,
      'attackRange': this.selectedPlayer!.attackRange!.toMap(),
    });
  }

  void changeSelectPlayer(List<Player> players, String playerID) {
    for (int i = 0; i < players.length; i++) {
      if (players[i].id == playerID) {
        selectPlayer(
          playerID,
          i,
          players[i],
        );
      }
    }
  }
}
