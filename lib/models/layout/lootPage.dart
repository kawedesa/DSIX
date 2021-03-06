import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:dsixv02app/models/game/item.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LootPage extends StatefulWidget {
  final Function() refresh;
  final Dsix dsix;

  LootPage({Key key, this.dsix, this.refresh}) : super(key: key);

  static const String routeName = "/npcPage";

  @override
  _LootPageState createState() => new _LootPageState();
}

class _LootPageState extends State<LootPage> {
  int _layoutIndex = 0;
  List<bool> lootSelection;
  int lootAmount;

  void chooseAmount(int value) {
    if (lootAmount + value < 2) {
      lootAmount = 1;
      return;
    }

    lootAmount += value;
  }

  void selectLoot(int index) {
    widget.dsix.gm.selectedLoot = widget.dsix.gm.lootList[index];
    _layoutIndex = 1;
  }

  void deleteLoot() {
    widget.dsix.gm.lootList.remove(widget.dsix.gm.selectedLoot);
    _layoutIndex = 0;
  }

  List<String> ammoQuantity = [];

  void showItem(Item item) {
    ammoQuantity.clear();

    if (item.itemClass == 'thrownWeapon' || item.itemClass == 'ammo') {
      for (int check = 0; check < item.uses; check++) {
        ammoQuantity.add('ammo');
      }
    }

    showAlertDialogItemDetail(context, item);
  }

  @override
  void initState() {
    super.initState();
  }

  showAlertDialogItemDetail(BuildContext context, Item item) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[700],
                width: 2.5, //                   <--- border width here
              ),
            ),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.grey[700],
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 7),
                    child: Center(
                      child: Text(
                        '${item.name}',
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1.3,
                          fontSize: 25.0,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ), //ITEM NAME
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Stack(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          width: 25,
                          child: GridView.count(
                            crossAxisCount: 1,
                            children:
                                List.generate(ammoQuantity.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: SvgPicture.asset(
                                  'assets/item/${ammoQuantity[index]}.svg',
                                  color: Colors.grey[700],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                        child: SvgPicture.asset(
                          'assets/item/${item.icon}.svg',
                          color: Colors.grey[400],
                        ),
                      ),
                    ]),
                  ),
                ),

                Divider(
                  thickness: 2,
                  color: Colors.grey[700],
                ),

                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/item/pDamage.svg',
                              color: Colors.grey[700],
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${item.pDamage}',
                                style: TextStyle(
                                  fontFamily: 'Headline',
                                  height: 1,
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/item/pArmor.svg',
                              color: Colors.grey[700],
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${item.pArmor}',
                                style: TextStyle(
                                  fontFamily: 'Headline',
                                  height: 1,
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/item/mDamage.svg',
                              color: Colors.grey[700],
                              width: MediaQuery.of(context).size.width * 0.065,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${item.mDamage}',
                                style: TextStyle(
                                  fontFamily: 'Headline',
                                  height: 1,
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/item/mArmor.svg',
                              color: Colors.grey[700],
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${item.mArmor}',
                                style: TextStyle(
                                  fontFamily: 'Headline',
                                  height: 1,
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/item/weight.svg',
                              color: Colors.grey[700],
                              width: MediaQuery.of(context).size.width * 0.045,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                '${item.weight}',
                                style: TextStyle(
                                  fontFamily: 'Headline',
                                  height: 1,
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Divider(
                  thickness: 2,
                  color: Colors.grey[700],
                ),

                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 20),
                    child: Text(
                      item.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.25,
                        fontSize: 19,
                        fontFamily: 'Calibri',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  showAlertDialogLoot(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              content: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[700],
                    width: 2.5, //                   <--- border width here
                  ),
                ),
                width: 300,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        color: Colors.grey[700],
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                          child: Center(
                            child: Text(
                              'HOW MUCH?',
                              style: TextStyle(
                                fontFamily: 'Headline',
                                height: 1.3,
                                fontSize: 25.0,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.pink,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            chooseAmount(-5);
                                          });
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '- 5',
                                            style: TextStyle(
                                              fontFamily: 'Headline',
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Center(
                                            child: Container(
                                          height: 125,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    chooseAmount(1);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.keyboard_arrow_up,
                                                  color: Colors.white,
                                                  size: 35,
                                                ),
                                              ),
                                              Container(
                                                // width: 100,
                                                // height: 100,
                                                // color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    '$lootAmount',
                                                    style: TextStyle(
                                                      fontFamily: 'Headline',
                                                      height: 1.3,
                                                      fontSize: 35.0,
                                                      color: Colors.grey[700],
                                                      letterSpacing: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    chooseAmount(-1);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.white,
                                                  size: 35,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // color: Colors.red,
                                        )),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            chooseAmount(5);
                                          });
                                        },
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '+ 5',
                                            style: TextStyle(
                                              fontFamily: 'Headline',
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.dsix.gm.createLoot(lootAmount);
                                    _layoutIndex = 1;
                                    widget.refresh();
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.058,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[400],
                                      width:
                                          2, //                   <--- border width here
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.centerEnd,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 10, 0),
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.grey[400],
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Text(
                                          'CONFIRM',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                            fontFamily: 'Calibri',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    lootSelection = [];
    widget.dsix.gm.lootList.forEach((element) {
      if (element == widget.dsix.gm.selectedLoot) {
        lootSelection.add(true);
      } else {
        lootSelection.add(false);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _layoutIndex = 0;

                      widget.refresh();
                    });
                  },
                  child: Container(
                    width: 23,
                    height: 23,
                    child: SvgPicture.asset(
                      'assets/gm/add.svg',
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                    itemCount: widget.dsix.gm.lootList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectLoot(index);
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          child: SvgPicture.asset(
                            'assets/item/${widget.dsix.gm.lootList[index].icon}.svg',
                            color: lootSelection[index]
                                ? Colors.grey[400]
                                : Colors.grey[700],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 5,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: Colors.grey[700],
        ),
        Expanded(
          child: IndexedStack(
            index: _layoutIndex,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOOT',
                      style: TextStyle(
                        fontFamily: 'Headline',
                        height: 1.3,
                        fontSize: 45,
                        color: Colors.grey[700],
                        letterSpacing: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'These are the spoils of war, the shimmer in the dark and the glitter amongst the rubble. This are the rewards the players get after defeating an enemy, finding a secret room or overcoming a challenge.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 18,
                          fontFamily: 'Calibri',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      onPressed: () {
                        lootAmount = 1;
                        showAlertDialogLoot(context);

                        widget.refresh();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.058,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[700],
                            width:
                                2, //                   <--- border width here
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.grey[700],
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                'LOOT',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(65, 15, 65, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // color: Colors.amberAccent,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                '${widget.dsix.gm.selectedLoot.name}',
                                style: TextStyle(
                                  fontFamily: 'Headline',
                                  height: 1.3,
                                  fontSize: 45,
                                  color: Colors.grey[700],
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    deleteLoot();
                                  });
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            '${widget.dsix.gm.selectedLoot.lootDescription}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              height: 1.3,
                              fontSize: 18,
                              fontFamily: 'Calibri',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 2,
                    color: Colors.grey[700],
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: widget.dsix.gm.selectedLoot.itemList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      showItem(widget.dsix.gm.selectedLoot
                                          .itemList[index]);
                                    });
                                  },
                                  title: Text(
                                    '${widget.dsix.gm.selectedLoot.itemList[index].name}',
                                    style: TextStyle(
                                      fontFamily: 'Headliner',
                                      height: 1.5,
                                      fontSize: 20.0,
                                      color: Colors.grey[300],
                                      letterSpacing: 2.5,
                                    ),
                                  ),
                                  trailing: Text(
                                    '\$ ${widget.dsix.gm.selectedLoot.itemList[index].value}',
                                    style: TextStyle(
                                      height: 1.5,
                                      fontSize: 18,
                                      fontFamily: 'Calibri',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0,
                                thickness: 2,
                                color: Colors.grey[700],
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
