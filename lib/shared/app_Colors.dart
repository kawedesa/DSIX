import 'package:flutter/material.dart';

class AppColors {
  //UI
  static final black00 = Colors.black;
  static final grey00 = Colors.grey[900];
  static final grey01 = Colors.grey[800];
  static final grey02 = Colors.grey[700];
  static final grey03 = Colors.grey[600];
  static final grey04 = Colors.grey[500];
  static final grey05 = Colors.grey[400];
  static final grey06 = Colors.grey[300];
  static final grey07 = Colors.grey[200];
  static final grey08 = Colors.grey[100];
  static final white00 = Colors.white;

  static final errorPrimary = Color.fromRGBO(225, 50, 50, 1);
  static final errorSecondary = Color.fromRGBO(150, 0, 0, 1);

  //PLAYERS

  static final attackMode = Color.fromRGBO(150, 0, 0, 1);

  static final bluePlayerPrimary = Colors.indigoAccent;
  static final bluePlayerSecondary = Colors.indigo[800];
  static final bluePlayerTertiary = Colors.indigo[900];
  static final bluePlayerShadow = Color.fromRGBO(0, 50, 255, 0.3);
  static final pinkPlayerPrimary = Colors.pinkAccent;
  static final pinkPlayerSecondary = Colors.pink[800];
  static final pinkPlayerTertiary = Colors.pink[900];
  static final pinkPlayerShadow = Color.fromRGBO(255, 0, 0, 0.3);
  static final yellowPlayerPrimary = Colors.orange;
  static final yellowPlayerSecondary = Color.fromRGBO(215, 112, 0, 1);
  static final yellowPlayerTertiary = Color.fromRGBO(155, 75, 7, 1);
  static final yellowPlayerShadow = Color.fromRGBO(250, 150, 0, 0.3);
  static final greenPlayerPrimary = Colors.teal;
  static final greenPlayerSecondary = Colors.teal[800];
  static final greenPlayerTertiary = Colors.teal[900];
  static final greenPlayerShadow = Color.fromRGBO(150, 250, 0, 0.3);
  static final purplePlayerPrimary = Colors.purple;
  static final purplePlayerSecondary = Color.fromRGBO(102, 20, 115, 1);
  static final purplePlayerTertiary = Colors.purple[900];
  static final purplePlayerShadow = Color.fromRGBO(250, 0, 250, 0.3);

  //MAPS
  //Crossroads
  static final crossroadsGrass00 = Color.fromRGBO(97, 103, 72, 1);
  static final crossroadsGrass01 = Color.fromRGBO(164, 156, 70, 1);
  static final crossroadsHill00 = Color.fromRGBO(61, 64, 60, 1);
  static final crossroadsHill01 = Color.fromRGBO(73, 81, 80, 1);
  static final crossroadsRiver00 = Color.fromRGBO(87, 109, 100, 1);
  static final crossroadsRiver01 = Color.fromRGBO(114, 155, 142, 1);
  static final crossroadsStructure00 = Color.fromRGBO(113, 114, 114, 1);
  static final crossroadsStructure01 = Color.fromRGBO(132, 134, 122, 1);
  static final crossroadsStructure02 = Color.fromRGBO(174, 166, 124, 1);
  static final crossroadsStructure03 = Color.fromRGBO(196, 187, 142, 1);
  static final crossroadsTree00 = Color.fromRGBO(59, 40, 28, 1);
  static final crossroadsTree01 = Color.fromRGBO(134, 87, 58, 1);
  static final crossroadsTree02 = Color.fromRGBO(158, 122, 66, 1);

  //ENEMY
  static final enemyShadow00 = Color.fromRGBO(150, 0, 0, 0.3);
  static final enemyRange00 = Color.fromRGBO(255, 100, 100, 0.75);

  //GRAVE
  static final grave00 = Color.fromRGBO(87, 87, 85, 1);
  static final grave01 = Color.fromRGBO(114, 110, 109, 1);
  static final grave02 = Color.fromRGBO(147, 140, 135, 1);
  static final grave03 = Color.fromRGBO(168, 159, 154, 1);

  //CHEST
  static final chestInside00 = Color.fromRGBO(86, 80, 78, 1);
  static final chestWood00 = Color.fromRGBO(107, 69, 40, 1);
  static final chestWood01 = Color.fromRGBO(138, 57, 40, 1);
  static final chestMetal00 = Color.fromRGBO(148, 141, 136, 1);
  static final chestMetal01 = Color.fromRGBO(206, 193, 185, 1);

  //ORC
  static final orcArmor00 = Color.fromRGBO(84, 49, 41, 1);
  static final orcArmor01 = Color.fromRGBO(107, 69, 39, 1);
  static final orcSkin00 = Color.fromRGBO(88, 92, 39, 1);
  static final orcSkin01 = Color.fromRGBO(119, 133, 54, 1);
  static final orcDetail00 = Color.fromRGBO(173, 158, 145, 1);
  static final orcDetail01 = Color.fromRGBO(246, 231, 198, 1);

  //DWARF
  static final dwarfArmor00 = Color.fromRGBO(107, 79, 31, 1);
  static final dwarfArmor01 = Color.fromRGBO(177, 133, 44, 1);
  static final dwarfSkin00 = Color.fromRGBO(158, 107, 59, 1);
  static final dwarfSkin01 = Color.fromRGBO(212, 157, 108, 1);
  static final dwarfDetail00 = Color.fromRGBO(137, 83, 42, 1);
  static final dwarfDetail01 = Color.fromRGBO(237, 228, 187, 1);
  static final dwarfBeard00 = Color.fromRGBO(166, 82, 37, 1);

  //ELF
  static final elfArmor00 = Color.fromRGBO(141, 123, 114, 1);
  static final elfArmor01 = Color.fromRGBO(198, 185, 175, 1);
  static final elfSkin00 = Color.fromRGBO(201, 116, 82, 1);
  static final elfSkin01 = Color.fromRGBO(239, 175, 131, 1);
  static final elfClothes00 = Color.fromRGBO(65, 80, 132, 1);
  static final elfClothes01 = Color.fromRGBO(109, 115, 153, 1);
  static final elfDetail01 = Color.fromRGBO(237, 228, 187, 1);
  static final elfHair00 = Color.fromRGBO(196, 115, 41, 1);
}
