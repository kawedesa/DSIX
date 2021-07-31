class StorySettings {
  String icon;
  String name;
  String description;

  int numberOfQuests;

  int questXp;
  int addXp;

  int questGold;
  int addGold;

  StorySettings defaultSettings() {
    StorySettings newSettings = new StorySettings(
      icon: 'normal',
      name: 'NORMAL',
      description: 'Normal.',
      numberOfQuests: 3,
      questXp: 50,
      addXp: 50,
      questGold: 100,
      addGold: 100,
    );

    return newSettings;
  }

  StorySettings({
    String icon,
    String name,
    String description,
    int numberOfQuests,
    int questXp,
    int addXp,
    int questGold,
    int addGold,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;

    this.numberOfQuests = numberOfQuests;
    this.questXp = questXp;
    this.addXp = addXp;

    this.questGold = questGold;
    this.addGold = addGold;
  }
}
