class Item {
  String? icon;
  String? name;
  String? description;
  String? itemSlot;
  String? type;
  int? pDamage;
  int? mDamage;
  int? pArmor;
  int? mArmor;
  int? weight;
  int? value;
  double? maxWeaponRange;
  double? minWeaponRange;
  Item({
    String? icon,
    String? name,
    String? description,
    String? itemSlot,
    String? type,
    int? pDamage,
    int? mDamage,
    int? pArmor,
    int? mArmor,
    int? weight,
    int? value,
    double? maxWeaponRange,
    double? minWeaponRange,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.itemSlot = itemSlot;
    this.type = type;
    this.pDamage = pDamage;
    this.mDamage = mDamage;
    this.pArmor = pArmor;
    this.mArmor = mArmor;
    this.weight = weight;
    this.value = value;
    this.maxWeaponRange = maxWeaponRange;
    this.minWeaponRange = minWeaponRange;
  }

  factory Item.fromMap(Map<String, dynamic>? data) {
    return Item(
      icon: data?['icon'],
      name: data?['name'],
      description: data?['description'],
      itemSlot: data?['itemSlot'],
      type: data?['type'],
      pDamage: data?['pDamage'],
      mDamage: data?['mDamage'],
      pArmor: data?['pArmor'],
      mArmor: data?['mArmor'],
      weight: data?['weight'],
      value: data?['value'],
      maxWeaponRange: data?['maxWeaponRange'] * 1.0,
      minWeaponRange: data?['minWeaponRange'] * 1.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': this.icon,
      'name': this.name,
      'description': this.description,
      'itemSlot': this.itemSlot,
      'type': this.type,
      'pDamage': this.pDamage,
      'mDamage': this.mDamage,
      'pArmor': this.pArmor,
      'mArmor': this.mArmor,
      'weight': this.weight,
      'value': this.value,
      'maxWeaponRange': this.maxWeaponRange,
      'minWeaponRange': this.minWeaponRange,
    };
  }

  factory Item.empty() {
    return Item(
      icon: '',
      name: '',
      description: '',
      itemSlot: '',
      type: '',
      pDamage: 0,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      weight: 0,
      value: 0,
      maxWeaponRange: 0,
      minWeaponRange: 0,
    );
  }
}
