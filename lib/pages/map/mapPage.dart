import 'package:dsixv02app/models/enemy/enemyController.dart';
import 'package:dsixv02app/models/game.dart';
import 'package:dsixv02app/models/gameController.dart';
import 'package:dsixv02app/models/loot/loot.dart';
import 'package:dsixv02app/models/loot/lootController.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/playerMenu/playerMenu.dart';
import 'package:dsixv02app/models/player/playerTempLocation.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turn.dart';
import 'package:dsixv02app/models/turnOrder/turnController.dart';
import 'package:dsixv02app/pages/map/mapTile.dart';

import 'package:dsixv02app/pages/playerSelection/playerSelectionPage.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/goToPageButton.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
import 'mapPageAnimation.dart';
import 'mapPageVM.dart';
import '../../models/player/playerSprite.dart';
import 'turnButton.dart';

// ignore: must_be_immutable
class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapPageVM _mapPageVM = MapPageVM();
  MapPageAnimation _mapPageAnimation = MapPageAnimation();
  UIColor _uiColor = UIColor();

  @override
  void initState() {
    _mapPageAnimation.loadRiverFile();
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //Controlers
    final gameController = Provider.of<GameController>(context);
    final turnController = Provider.of<TurnController>(context);
    final enemyController = Provider.of<EnemyController>(context);
    final lootController = Provider.of<LootController>(context);
    final user = Provider.of<User>(context);

    //Streams
    final game = Provider.of<Game>(context);
    final players = Provider.of<List<Player>>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    final loot = Provider.of<List<Loot>>(context);

    // try {
    //   gameController.checkForEndGame(players);
    // } on EndGameException {
    //   _mapPageVM
    //       .createEndGameButton(players[user.selectedPlayerIndex].isDead());
    // }

    try {
      turnController.passTurnForDeadPlayers(game.id!, turnOrder, players);
    } on NewTurnException {
      gameController.newRound(game.round!);
      turnController.newTurnOrder(game.id!, players);
      // gameController.setFogSize();
      print('play new turn animation');
    }
    try {
      user.checkForPlayerTurn(turnOrder);
    } on StartPlayerTurnException {
      user.startPlayerTurn();
      _mapPageAnimation.playYourTurnAnimation();
    } on ContinuePlayerTurnException {
      user.continuePlayerTurn();
    } on NotPlayerTurnException {
      user.endPlayerTurn();
    }

    enemyController.updateEnemyPlayersInSight(
        players, players[user.selectedPlayer!.index!]);

    lootController.updateLootInSight(
        loot, players[user.selectedPlayer!.index!]);

    _mapPageVM.createCanvasController(context, game.map!.size!,
        players[user.selectedPlayer!.index!].location);

    return Scaffold(
      backgroundColor: AppColors.black00,
      appBar: AppBar(
        actions: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: SvgPicture.asset(
                  AppIcons.life,
                  height: MediaQuery.of(context).size.height * 0.045,
                  color:
                      _uiColor.setUIColor(user.selectedPlayerID, 'secondary'),
                ),
              ),
              Text(
                '${players[user.selectedPlayer!.index!].life!.current}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Santana',
                  height: 1,
                  fontSize: 27,
                  color:
                      _uiColor.setUIColor(user.selectedPlayerID, 'secondary'),
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 2, 0),
                child: SvgPicture.asset(
                  AppIcons.weight,
                  height: MediaQuery.of(context).size.height * 0.045,
                  color:
                      _uiColor.setUIColor(user.selectedPlayerID, 'secondary'),
                ),
              ),
              Text(
                '${players[user.selectedPlayer!.index!].weight!.current}/${players[user.selectedPlayer!.index!].weight!.max}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Santana',
                  height: 1,
                  fontSize: 27,
                  color:
                      _uiColor.setUIColor(user.selectedPlayerID, 'secondary'),
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              )
            ],
          ),
        ],
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        leading: GoToPagePageButton(
          goToPage: PlayerSelectionPage(),
          buttonColor: _uiColor.setUIColor(user.selectedPlayerID, 'secondary'),
        ),
        backgroundColor: _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
      ),
      body: SafeArea(
        child: ChangeNotifierProxyProvider<List<Player>, PlayerTempLocation?>(
          create: (context) => PlayerTempLocation(),
          update: (context, _, playerTempLocation) => playerTempLocation!
            ..updatePlayerLocation(user.selectedPlayer!.location!.dx,
                user.selectedPlayer!.location!.dy),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.86,
                child: Stack(
                  children: [
                    InteractiveViewer(
                      transformationController: _mapPageVM.canvasController,
                      constrained: false,
                      panEnabled: true,
                      maxScale: _mapPageVM.maxZoom,
                      minScale: _mapPageVM.minZoom,
                      child: SizedBox(
                        width: game.map!.size,
                        height: game.map!.size,
                        child: Stack(
                          children: [
                            MapTile(
                              name: game.map!.name,
                            ),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: TransparentPointer(
                            //     transparent: true,
                            //     child: AnimatedContainer(
                            //       duration: Duration(milliseconds: 500),
                            //       width: gameController.fogSize,
                            //       height: gameController.fogSize,
                            //       decoration: BoxDecoration(
                            //         shape: BoxShape.circle,
                            //         border: Border.all(
                            //           color: AppColors.badEffectImage,
                            //           width: 0.5,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Stack(
                              children: lootController.visibleLoot,
                            ),
                            Stack(
                              children: enemyController.enemyPlayers,
                            ),

                            PlayerMenu(
                              refresh: () => refresh(),
                            ),

                            Consumer<PlayerTempLocation>(
                                builder: (context, playerTempLocation, ___) {
                              return PlayerSprite(
                                refresh: () => refresh(),
                                tempLocation: playerTempLocation,
                                player: user.selectedPlayer,
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Stack(
                    //     children: _mapPageVM.temporaryUI,
                    //   ),
                    // ),

                    //Animation
                    Align(
                      alignment: Alignment.center,
                      child: (_mapPageAnimation.artboard != null)
                          ? TransparentPointer(
                              transparent: true,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.86,
                                child: Rive(
                                  artboard: _mapPageAnimation.artboard!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                height: 2,
                color: _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    itemCount: turnOrder.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TurnButton(
                          onDoubleTap: () {
                            user.changeSelectPlayer(
                                players, turnOrder[index].id!);
                            _mapPageVM.goToPlayer(
                                context, game.map!.size!, user.selectedPlayer!);
                            refresh();
                          },
                          color: _uiColor.setUIColor(
                              turnOrder[index].id, 'primary'),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                height: 2,
                color: _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
