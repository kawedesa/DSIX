import 'dart:math';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:flutter/material.dart';
import 'playerAction.dart';
import 'playerArmor.dart';
import 'playerAttackRange.dart';
import 'playerDamage.dart';
import 'playerIventory.dart';
import 'playerLife.dart';
import 'playerLocation.dart';
import 'playerVision.dart';
import 'playerWalkRange.dart';

class Player {
  int? index;
  String? id;
  PlayerLocation? location;
  String? race;
  PlayerVision? vision;
  PlayerWalkRange? walkRange;
  PlayerLife? life;
  PlayerAttackRange? attackRange;
  PlayerDamage? damage;
  PlayerArmor? armor;
  PlayerIventory? iventory;
  PlayerAction? action;
  Player({
    int? index,
    String? id,
    PlayerLocation? location,
    String? race,
    PlayerVision? vision,
    PlayerWalkRange? walkRange,
    PlayerLife? life,
    PlayerAttackRange? attackRange,
    PlayerDamage? damage,
    PlayerArmor? armor,
    PlayerIventory? iventory,
    PlayerAction? action,
  }) {
    this.index = index;
    this.id = id;
    this.location = location;
    this.race = race;
    this.vision = vision;
    this.walkRange = walkRange;
    this.life = life;
    this.attackRange = attackRange;
    this.damage = damage;
    this.armor = armor;
    this.iventory = iventory;
    this.action = action;
  }

  Map<String, dynamic> toMap() {
    return {
      'index': this.index,
      'id': this.id,
      'location': this.location?.toMap(),
      'race': this.race,
      'vision': this.vision?.toMap(),
      'walkRange': this.walkRange?.toMap(),
      'life': this.life?.toMap(),
      'attackRange': this.attackRange?.toMap(),
      'damage': this.damage?.toMap(),
      'armor': this.armor?.toMap(),
      'iventory': this.iventory?.toMap(),
      'action': this.action?.toMap(),
    };
  }

  factory Player.fromMap(Map<String, dynamic>? data) {
    return Player(
      index: data?['index'],
      id: data?['id'],
      location: PlayerLocation.fromMap(data?['location']),
      race: data?['race'],
      vision: PlayerVision.fromMap(data?['vision']),
      walkRange: PlayerWalkRange.fromMap(data?['walkRange']),
      life: PlayerLife.fromMap(data?['life']),
      attackRange: PlayerAttackRange.fromMap(data?['attackRange']),
      damage: PlayerDamage.fromMap(data?['damage']),
      armor: PlayerArmor.fromMap(data?['armor']),
      iventory: PlayerIventory.fromMap(data?['iventory']),
      action: PlayerAction.fromMap(data?['action']),
    );
  }

  factory Player.newRandomPlayer(Offset location, int playerIndex) {
    List<String> id = [
      'blue',
      'pink',
      'green',
      'yellow',
      'purple',
    ];

    List<String> races = [
      'orc',
      'dwarf',
      'elf',
    ];
    int randomNumber = Random().nextInt(races.length);
    String randomRace = races[randomNumber];

    return Player(
      index: playerIndex,
      id: id[playerIndex],
      location: PlayerLocation.newLocation(location),
      race: randomRace,
      vision: PlayerVision.set(randomRace),
      walkRange: PlayerWalkRange.set(randomRace),
      life: PlayerLife.set(randomRace),
      attackRange: PlayerAttackRange.empty(),
      damage: PlayerDamage.empty(),
      armor: PlayerArmor.empty(),
      iventory: PlayerIventory.empty(randomRace),
      action: PlayerAction.empty(),
    );
  }

  bool cantReach(Offset targetLocation) {
    double distance = (targetLocation - this.location!.getLocation()).distance;
    if (distance > 20) {
      return true;
    } else {
      return false;
    }
  }

  int attack() {
    int damage = Random().nextInt(6) + 1;
    return damage;
  }

  void defend(String gameID) {
    int protect = Random().nextInt(6) + 1;
    this.armor!.increaseTempArmor(protect);
    this.armor!.update(gameID, this.index.toString());
  }

  void clearTempEffects(String gameID) {
    this.armor!.resetTempArmor();
    this.armor!.update(gameID, this.index.toString());
    this.vision!.reset();
    this.vision!.update(gameID, this.index.toString());
  }

  void takeDamage(String gameID, int damageRoll, pDamage, mDamage) {
    if (this.armor!.tempArmor! > 0) {
      int damage = pDamage + mDamage + damageRoll;
      this.life!.decrease(gameID, this.index.toString(),
          this.armor!.calculateTempArmor(damage));
      this.armor!.update(gameID, this.index.toString());
      return;
    }

    this.life!.decrease(gameID, this.index.toString(),
        this.armor!.calculateDamageReceived(damageRoll, pDamage, mDamage));
  }

  void equipItem(String gameID, Item item) {
    this.iventory!.bag!.remove(item);
    this.iventory!.update(gameID, this.index.toString());
    this.attackRange!.increase(item);
    this.attackRange!.update(gameID, this.index.toString());
    this.damage!.increasePDamage(item.pDamage!);
    this.damage!.increaseMDamage(item.mDamage!);
    this.damage!.update(gameID, this.index.toString());
    this.armor!.increasePArmor(item.pArmor!);
    this.armor!.increaseMArmor(item.mArmor!);
    this.armor!.update(gameID, this.index.toString());
  }

  void unequip(
    String gameID,
    Item item,
  ) {
    if (item.name == '') {
      return;
    }
    this.iventory!.unequip(item);
    this.iventory!.update(gameID, this.index.toString());
    this.attackRange!.decrease(item);
    this.attackRange!.update(gameID, this.index.toString());
    this.damage!.decreasePDamage(item.pDamage!);
    this.damage!.decreaseMDamage(item.mDamage!);
    this.damage!.update(gameID, this.index.toString());
    this.armor!.decreasePArmor(item.pArmor!);
    this.armor!.decreaseMArmor(item.mArmor!);
    this.armor!.update(gameID, this.index.toString());
  }
}
