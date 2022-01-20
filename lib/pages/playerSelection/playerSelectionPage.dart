import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/pages/battleRoyaleSettings/battleRoyaleSettingsPage.dart';
import 'package:dsixv02app/shared/widgets/button.dart';
import 'package:dsixv02app/shared/widgets/goToPageButton.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'playerSelectionPageVM.dart';

class PlayerSelectionPage extends StatelessWidget {
  const PlayerSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerSelectionPageVM _selectPlayerPageVM = PlayerSelectionPageVM();
    UIColor _uiColor = UIColor();
    final user = Provider.of<User>(context);
    final players = Provider.of<List<Player>>(context);

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.06,
          centerTitle: true,
          title: Text(
            'select your player'.toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Santana',
              height: 1,
              fontSize: 27,
              color: AppColors.grey00,
              letterSpacing: 1.2,
            ),
          ),
          leading: GoToPagePageButton(goToPage: BattleRoyaleSettingsPage()),
          backgroundColor: AppColors.grey02,
        ),
        backgroundColor: AppColors.black00,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemCount: players.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Button(
                        buttonText: '${players[index].id}',
                        buttonColor:
                            _uiColor.setUIColor(players[index].id, 'primary'),
                        buttonTextColor:
                            _uiColor.setUIColor(players[index].id, 'primary'),
                        onTapAction: () async {
                          user.selectPlayer(
                            players[index],
                          );
                          _selectPlayerPageVM.goToMapPage(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
