import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/pages/map/mapPage.dart';
import 'package:flutter/material.dart';

class PlayerSelectionPageVM {
  void selectPlayer(
      Player player, int playerIndex, User user, bool playerTurn) {
    user.selectPlayer(player, playerIndex);
    user.setPlayerModeBasedOnPlayerTurn(playerTurn);
  }

  void goToMapPage(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MapPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
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
}
