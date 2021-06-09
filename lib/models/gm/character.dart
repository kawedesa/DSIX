import 'characterSkill.dart';
import 'dart:math';

class Character {
  // CharacterSkillList CharacterSkills = new CharacterSkillList();

//NAME DESCRIPTION
  String icon;
  String name;
  String description;
  String image;

//HEALTH

  int baseHealth;
  int maxHealth;
  int currentHealth = 0;

  //DICE

  int dice;

  //STATS

  int pDamage;
  int pArmor;
  int mDamage;
  int mArmor;
  int pSkill;
  int mSkill;

//SKILLS

  List<CharacterSkill> possibleSkills = [];
  List<CharacterSkill> availableSkills = [];
  List<CharacterSkill> selectedSkills = [];

  int amount = 1;

//LOOT DESCRIPTION

  int totalLoot = 0;
  double baseLoot;
  int totalXp;
  int baseXp;

  void newCharacter() {
    this.icon = 'character';
    this.image = 'undead';
    this.name = 'CHARACTER';
    this.description = 'A character.';
    this.baseHealth = 1;
    this.dice = 1;
    this.pDamage = 0;
    this.pArmor = 0;
    this.mDamage = 0;
    this.mArmor = 0;
    this.pSkill = 0;
    this.mSkill = 0;
    this.possibleSkills = [];
    this.availableSkills = [];
    this.selectedSkills = [];
    this.baseLoot = 0;
    this.baseXp = 0;
  }

  void prepareCharacterNpc() {
    this.maxHealth = this.baseHealth;
    this.currentHealth = this.maxHealth;
    this.totalLoot = this.baseLoot.toInt();
    this.totalXp = this.baseXp;

    for (int check = 0; check < this.pSkill; check++) {
      selectedSkills.add(
        CharacterSkill(
          icon: 'pSkill',
          name: 'ABILITY',
          skillType: 'pSkill',
          description: 'pSkill',
          value: 0,
        ),
      );
    }

    for (int check = 0; check < this.mSkill; check++) {
      selectedSkills.add(
        CharacterSkill(
          icon: 'mSkill',
          name: 'SPELL',
          skillType: 'mSkill',
          description: 'mSkill',
          value: 0,
        ),
      );
    }
  }

  void changeAmount(int value) {
    if (this.amount + value < 1) {
      this.amount = 0;
      this.currentHealth = 0;
      this.maxHealth = 0;
      this.totalXp = 0;
      this.totalLoot = 0;
      return;
    }

    this.amount += value;
    this.maxHealth += this.baseHealth * value;
    this.currentHealth += this.baseHealth * value;

    this.totalXp += this.baseXp * value;
    this.totalLoot += (this.baseLoot * value).toInt();
  }

  void setAmount(int value) {
    if (this.amount + value < 1) {
      this.amount = 1;
      return;
    }

    this.amount += value;

    this.maxHealth = this.baseHealth * this.amount;
    this.currentHealth = this.maxHealth;

    this.totalXp = this.baseXp * this.amount;
    this.totalLoot = (this.baseLoot * this.amount).toInt();
  }

  String characterAction() {
    String result = 'roll';

    result = '${Random().nextInt(this.dice) + 1}';

    return result;
  }

  void openSkill(CharacterSkill skill) {
    this.availableSkills = [];

    switch (skill.icon) {
      case 'pSkill':
        {
          this.possibleSkills.forEach((element) {
            if (element.skillType == 'pSkill') {
              this.availableSkills.add(element);
            }
          });
        }
        break;

      case 'mSkill':
        {
          this.possibleSkills.forEach((element) {
            if (element.skillType == 'mSkill') {
              this.availableSkills.add(element);
            }
          });
        }
        break;
    }
  }

  void chooseSkill(CharacterSkill skill) {
    switch (skill.skillType) {
      case 'pSkill':
        // this.selectedSkills.remove((element) => element.name == 'ABILITY');
        this.selectedSkills.remove(this
            .selectedSkills
            .lastWhere((element) => element.name == 'ABILITY'));

        this.selectedSkills.add(skill);

        break;

      case 'mSkill':
        this.selectedSkills.remove(this
            .selectedSkills
            .lastWhere((element) => element.name == 'SPELL'));
        this.selectedSkills.add(skill);
        break;
    }
  }

  void changeHealth(int value) {
    if (this.currentHealth + value > this.maxHealth) {
      this.currentHealth = this.maxHealth;

      return;
    }

    if (this.currentHealth + value < 1) {
      this.currentHealth = 0;

      return;
    }

    this.currentHealth += value;
    this.amount = ((this.currentHealth - 1) ~/ this.baseHealth) + 1;
  }

  Character({
    String icon,
    String name,
    String description,
    String image,
    int baseHealth,
    int dice,
    int pDamage,
    int pArmor,
    int mDamage,
    int mArmor,
    int pSkill,
    int mSkill,
    List<CharacterSkill> possibleSkills,
    List<CharacterSkill> selectedSkills,
    double baseLoot,
    int baseXp,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.image = image;

    this.baseHealth = baseHealth;
    this.dice = dice;
    this.pDamage = pDamage;
    this.pArmor = pArmor;
    this.mDamage = mDamage;
    this.mArmor = mArmor;

    this.pSkill = pSkill;
    this.mSkill = mSkill;

    this.possibleSkills = possibleSkills;
    this.selectedSkills = selectedSkills;

    this.baseLoot = baseLoot;
    this.baseXp = baseXp;
  }
}