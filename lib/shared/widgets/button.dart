import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Button extends StatefulWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? buttonFillColor;
  final Function()? onTapAction;

  const Button({
    @required this.buttonText,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonFillColor,
    this.onTapAction,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Artboard? _artboard;

  @override
  void initState() {
    _loadRiverFile();
    super.initState();
  }

  void _loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/buttonAnimation.riv');
    final file = RiveFile.import(bytes);
    _artboard = file.mainArtboard;
    _playReflectionAnimation();
  }

  _playReflectionAnimation() {
    _artboard?.addController(SimpleAnimation('reflection'));
  }

  _playOnTapAnimation() {
    _artboard?.addController(OneShotAnimation(
      'onTap',
    ));
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () {
        _playOnTapAnimation();
        this.widget.onTapAction!();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.65,
        decoration: BoxDecoration(
          color: (this.widget.buttonFillColor != null)
              ? this.widget.buttonFillColor
              : AppColors.black00,
          border: Border.all(
            color: this.widget.buttonColor!,
            width: 2.5,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            (_artboard != null)
                ? Rive(
                    artboard: _artboard!,
                    fit: BoxFit.fill,
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Center(
                child: Text('${this.widget.buttonText}'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontFamily: 'Calibri',
                      color: this.widget.buttonTextColor!,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
