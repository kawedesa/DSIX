class NewTurnException implements Exception {
  String message = 'new turn';
  NewTurnException();
}

class PassTurnException implements Exception {
  String message = 'pass turn';
  PassTurnException();
}

class PlayerTurnException implements Exception {
  String message = 'player turn';
  PlayerTurnException();
}

class NotPlayerTurnException implements Exception {
  String message = 'not player turn';
  NotPlayerTurnException();
}

class StartPlayerTurnException implements Exception {
  String message = 'start player turn';
  StartPlayerTurnException();
}

class ContinuePlayerTurnException implements Exception {
  String message = 'continue player turn';
  ContinuePlayerTurnException();
}

class EndPlayerTurnException implements Exception {
  String message = 'end player turn';
  EndPlayerTurnException();
}

class EndGameException implements Exception {
  String message = 'end game';
  EndGameException();
}