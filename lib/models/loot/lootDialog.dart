import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/models/player/equipment/widget/equipmentPage.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'loot.dart';
import 'lootDetail.dart';

class LootDialog extends StatefulWidget {
  final Loot? loot;
  final Function()? onTapAction;
  const LootDialog({
    @required this.loot,
    this.onTapAction,
  });

  @override
  State<LootDialog> createState() => _LootDialogState();
}

class _LootDialogState extends State<LootDialog> {
  LootDialogController _lootDialogController = LootDialogController();
  UIColor _uiColor = UIColor();

  @override
  void initState() {
    _lootDialogController.loadRiverFile();
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final game = Provider.of<Game>(context);

    _lootDialogController.setOptions(widget.loot!.items!.length);

    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              color: _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                    (widget.loot!.items!.isEmpty)
                        ? 'empty'.toUpperCase()
                        : 'chest'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Santana',
                      height: 1,
                      fontSize: 25,
                      color: _uiColor.setUIColor(
                          user.selectedPlayer!.id, 'secondary'),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    )),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.09 *
                      widget.loot!.items!.length,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    itemCount: widget.loot!.items!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LootDialogOption(
                        item: widget.loot!.items![index],
                        optionSelected: _lootDialogController.options[index],
                        onTapAction: () {
                          _lootDialogController.selectOptions(
                              index, widget.loot!.items![index]);
                          refresh();
                        },
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EquipmentPage();
                      },
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.black00,
                      border: Border.all(
                        color: _uiColor.setUIColor(
                            user.selectedPlayer!.id, 'primary'),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        (_lootDialogController.artboard != null)
                            ? Rive(
                                artboard: _lootDialogController.artboard!,
                                fit: BoxFit.fill,
                              )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Center(
                            child: Text('iventory'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontFamily: 'Calibri',
                                  color: _uiColor.setUIColor(
                                      user.selectedPlayer!.id, 'primary'),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                (_lootDialogController.numberOfSelectedItems < 1)
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.black00,
                            border: Border.all(
                              color: _uiColor.setUIColor(
                                  user.selectedPlayer!.id, 'primary'),
                              width: 1,
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              (_lootDialogController.artboard != null)
                                  ? Rive(
                                      artboard: _lootDialogController.artboard!,
                                      fit: BoxFit.fill,
                                    )
                                  : SizedBox(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: Center(
                                  child: Text('leave'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontFamily: 'Calibri',
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayer!.id, 'primary'),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _lootDialogController.playOnTapAnimation();
                          _lootDialogController.chooseItems(context, game.id!,
                              user.selectedPlayer!, widget.loot!);
                          setState(() {});
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                (_lootDialogController.buttonText == 'choose')
                                    ? AppColors.black00
                                    : AppColors.errorPrimary,
                            border: Border.all(
                              color: _uiColor.setUIColor(
                                  user.selectedPlayer!.id, 'primary'),
                              width: 1,
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              (_lootDialogController.artboard != null)
                                  ? Rive(
                                      artboard: _lootDialogController.artboard!,
                                      fit: BoxFit.fill,
                                    )
                                  : SizedBox(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: Center(
                                  child: Text(
                                      _lootDialogController.buttonText
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontFamily: 'Calibri',
                                        color:
                                            (_lootDialogController.buttonText ==
                                                    'choose')
                                                ? _uiColor.setUIColor(
                                                    user.selectedPlayer!.id,
                                                    'primary')
                                                : AppColors.errorSecondary,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LootDialogController {
  Artboard? artboard;

  void loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/buttonAnimation.riv');
    final file = RiveFile.import(bytes);

    artboard = file.mainArtboard;
    playReflectionAnimation();
  }

  playReflectionAnimation() {
    artboard!.addController(SimpleAnimation('reflection'));
  }

  playOnTapAnimation() {
    artboard!.addController(OneShotAnimation(
      'onTap',
    ));
  }

  List<bool> options = [];
  void setOptions(int numberOfOptions) {
    if (options.isNotEmpty) {
      return;
    }
    for (int i = 0; i < numberOfOptions; i++) {
      this.options.add(false);
    }
  }

  int totalWeight = 0;
  int numberOfSelectedItems = 0;
  String buttonText = 'choose';

  void selectOptions(int index, Item item) {
    buttonText = 'choose';
    if (this.options[index]) {
      numberOfSelectedItems--;
      totalWeight -= item.weight!;
      this.options[index] = false;
    } else {
      numberOfSelectedItems++;
      totalWeight += item.weight!;
      this.options[index] = true;
    }
  }

  void chooseItems(
    context,
    String gameID,
    Player player,
    Loot loot,
  ) {
    if (player.equipment!.weight!.cantCarry(totalWeight)) {
      buttonText = 'too heavy';
      return;
    }

    List<Item> itemsRemovedFromChest = [];

    for (int i = 0; i < loot.items!.length; i++) {
      if (this.options[i]) {
        player.equipment!.getItem(gameID, player.id!, loot.items![i]);
        itemsRemovedFromChest.add(loot.items![i]);
      }
    }

    loot.removeItems(gameID, itemsRemovedFromChest);

    Navigator.pop(context);
  }
}

// ignore: must_be_immutable
class LootDialogOption extends StatelessWidget {
  Item? item;
  bool? optionSelected;
  Function()? onTapAction;
  LootDialogOption({Key? key, this.item, this.optionSelected, this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();
    final user = Provider.of<User>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
      width: double.infinity,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              onTapAction!();
            },
            child: Container(
              decoration: BoxDecoration(
                color: (optionSelected!)
                    ? _uiColor.setUIColor(user.selectedPlayer!.id, 'secondary')
                    : AppColors.black00,
                border: Border.all(
                  color:
                      _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${item!.weight}'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontFamily: 'Calibri',
                              color: _uiColor.setUIColor(
                                  user.selectedPlayer!.id, 'primary'),
                            )),
                        SvgPicture.asset(
                          AppIcons.weight,
                          height: MediaQuery.of(context).size.height * 0.03,
                          width: MediaQuery.of(context).size.height * 0.03,
                          color: _uiColor.setUIColor(
                              user.selectedPlayer!.id, 'primary'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Center(
                      child: Text('${item!.name}'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontFamily: 'Calibri',
                            color: _uiColor.setUIColor(
                                user.selectedPlayer!.id, 'primary'),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LootDetail(
                        playerID: user.selectedPlayer!.id,
                        item: item,
                      );
                    },
                  );
                },
                child: SvgPicture.asset(
                  AppIcons.help,
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.height * 0.03,
                  color:
                      _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
