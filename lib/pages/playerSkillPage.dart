import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dsixv02app/models/dsix/dsix.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'playerActionPointPage.dart';

class PlayerSkillPage extends StatefulWidget {
  final Dsix dsix;

  const PlayerSkillPage({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/playerSkillPage";

  @override
  _PlayerSkillPageState createState() => new _PlayerSkillPageState();
}

class _PlayerSkillPageState extends State<PlayerSkillPage> {
  List<bool> skillSelection;

  showAlertDialogDescription(BuildContext context, int index) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
                width: 2.5, //                   <--- border width here
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: widget.dsix.gm
                      .getCurrentPlayer()
                      .playerColor
                      .primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                    child: Center(
                      child: Text(
                        widget.dsix.gm
                            .getCurrentPlayer()
                            .playerAction[6]
                            .option[index]
                            .name,
                        style: TextStyle(
                          fontFamily: 'Santana',
                          height: 1,
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                  child: Text(
                    widget.dsix.gm
                        .getCurrentPlayer()
                        .playerAction[6]
                        .option[index]
                        .description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 19,
                      fontFamily: 'Calibri',
                      color: Colors.white,
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

  double _size = 0;

  void _updateState() {
    setState(() {
      _size = 50;
    });
  }

  Route _createRouteAttribute() {
    //ROUTE TO ATTRIBUTE PAGE
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlayerAttributePage(
        dsix: widget.dsix,
      ),
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
  }

  @override
  Widget build(BuildContext context) {
    //SKILL SELECTION
    skillSelection = [];
    widget.dsix.gm.getCurrentPlayer().availableSkills.forEach((element) {
      if (element == widget.dsix.gm.getCurrentPlayer().playerAction[6]) {
        skillSelection.add(true);
      } else {
        skillSelection.add(false);
      }
    });

    return new Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color:
                  widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
              size: 40,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
          backgroundColor:
              widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
          centerTitle: true,
          title: new Text(
            'SKILL   ',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Santana',
              height: 1,
              fontSize: 30,
              color:
                  widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
              letterSpacing: 1.2,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: AnimatedContainer(
                curve: Curves.easeInOutExpo,
                duration: Duration(milliseconds: 400),
                width: _size,
                height: _size,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.lightGreenAccent,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(_createRouteAttribute());
                  },
                ),
              ),
            ),
          ],
        ),
        body: new SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2.5, 10, 0),
                  child: GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.dsix.gm
                                  .getCurrentPlayer()
                                  .chooseSkill(index);

                              // focus();

                              _updateState();
                            });
                          },
                          child: SvgPicture.asset(
                            'assets/player/action/${widget.dsix.gm.getCurrentPlayer().availableSkills[index].icon}.svg',
                            color: skillSelection[index]
                                ? widget.dsix.gm
                                    .getCurrentPlayer()
                                    .playerColor
                                    .primaryColor
                                : Colors.white,
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 2,
                color:
                    widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${widget.dsix.gm.getCurrentPlayer().playerAction[6].name}',
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1.3,
                          fontSize: 45,
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                          letterSpacing: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: new TextSpan(
                            style: TextStyle(
                              height: 1.3,
                              fontSize: 18,
                              fontFamily: 'Calibri',
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: widget.dsix.gm
                                      .getCurrentPlayer()
                                      .playerAction[6]
                                      .description),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          itemCount: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerAction[6]
                              .option
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              ),
                              onPressed: () {
                                showAlertDialogDescription(context, index);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: widget.dsix.gm
                                        .getCurrentPlayer()
                                        .playerColor
                                        .primaryColor,
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
                                              0, 0, 15, 0),
                                          child: SvgPicture.asset(
                                            'assets/ui/help.svg',
                                            color: widget.dsix.gm
                                                .getCurrentPlayer()
                                                .playerColor
                                                .primaryColor,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        widget.dsix.gm
                                            .getCurrentPlayer()
                                            .playerAction[6]
                                            .option[index]
                                            .name,
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
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
