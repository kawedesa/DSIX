class NoAmmoException implements Exception {
  String message;
  String title = 'NO AMMO';

  NoAmmoException(this.message);
}

class NoWeaponException implements Exception {
  String message = 'Buy a weapon!';
  String title = 'NO WEAPON';

  NoWeaponException();
}

class NoGoldException implements Exception {
  String message;
  String title = 'NO GOLD';

  NoGoldException(this.message);
}

class TooHeavyException implements Exception {
  String message;
  String title = 'TOO HEAVY';

  TooHeavyException(this.message);
}

class MaxHpException implements Exception {
  String message = 'You are already at max HP.';
  String title = 'MAX HP';

  MaxHpException();
}

class MaxAmmoException implements Exception {
  String message = 'You are already loaded.';
  String title = 'MAX AMMO';

  MaxAmmoException();
}
