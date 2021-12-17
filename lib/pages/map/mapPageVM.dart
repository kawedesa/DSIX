import 'package:dsixv02app/models/loot/loot.dart';
import 'package:dsixv02app/models/loot/lootSprite.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/pages/settings/battleRoyaleSettingsPage.dart';
import 'package:dsixv02app/shared/widgets/button.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import '../../models/enemy/enemyPlayerSprite.dart';

class MapPageVM {
  TransformationController canvasController;
  UIColor _uiColor = UIColor();
  List<Widget> temporaryUI = [];

  double minZoom = 5;
  double maxZoom = 15;

  void createCanvasController(context, double dx, double dy) {
    if (canvasController != null) {
      return;
    }
    updateCanvasController(context, dx, dy);
  }

  void updateCanvasController(context, double dx, double dy) {
    double dxCanvas = dx * minZoom - MediaQuery.of(context).size.width / 2;
    double dyCanvas =
        dy * minZoom - MediaQuery.of(context).size.height * 0.8 / 2;

    if (dxCanvas < 0) {
      dxCanvas = 0;
    }
    if (dxCanvas > 640 * minZoom - MediaQuery.of(context).size.width) {
      dxCanvas = 640 * minZoom - MediaQuery.of(context).size.width;
    }
    if (dyCanvas < 0) {
      dyCanvas = 0;
    }
    if (dyCanvas > 640 * minZoom - MediaQuery.of(context).size.height * 0.9) {
      dyCanvas = 640 * minZoom - MediaQuery.of(context).size.height * 0.9;
    }

    canvasController = TransformationController(Matrix4(minZoom, 0, 0, 0, 0,
        minZoom, 0, 0, 0, 0, minZoom, 0, -dxCanvas, -dyCanvas, 0, 1));
  }

  void goToPlayer(context, Player player) {
    updateCanvasController(context, player.dx, player.dy);
  }

  void checkForEndGame(context, List<Player> players, Player player) {
    int deadPlayers = 0;
    players.forEach((player) {
      if (player.life < 1) {
        deadPlayers++;
      }
    });
    if (deadPlayers != players.length - 1) {
      return;
    }

    if (player.life < 1) {
      createWinOrLooseButton(context, player.id, 'you loose');
    } else {
      createWinOrLooseButton(context, player.id, 'you win');
    }
  }

  void createWinOrLooseButton(context, String id, String text) {
    this.temporaryUI = [];
    this.temporaryUI.add(Button(
          buttonText: text,
          onTapAction: () => goToHomePage(context),
          buttonColor: _uiColor.setUIColor(id, 'primary'),
          buttonTextColor: _uiColor.setUIColor(id, 'primary'),
        ));
  }

  void goToHomePage(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          BattleRoyaleSettingsPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );

    Navigator.of(context).push(newRoute);
  }

  List<EnemyPlayerSprite> enemyPlayer = [];

  void updateEnemyPlayersInSight(List<Player> players, Player selectedPlayer) {
    this.enemyPlayer = [];
    players.forEach((target) {
      if (target.id == selectedPlayer.id) {
        return;
      }
      if (selectedPlayer.cantSee(Offset(target.dx, target.dy))) {
        return;
      }
      this.enemyPlayer.add(EnemyPlayerSprite(
            enemyID: target.id,
            dx: target.dx,
            dy: target.dy,
            race: target.race,
            vision: target.visionRange,
            life: target.life,
          ));
    });
  }

  List<LootSprite> visibleLoot = [];

  void updateLootInSight(List<Loot> loot, Player selectedPlayer) {
    this.visibleLoot = [];
    loot.forEach((target) {
      if (selectedPlayer.cantSee(Offset(target.dx, target.dy))) {
        return;
      }
      this.visibleLoot.add(LootSprite(
            lootIndex: target.index,
            dx: target.dx,
            dy: target.dy,
            isClosed: target.isClosed,
          ));
    });
  }
}
