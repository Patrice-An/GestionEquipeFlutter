import 'package:logging/logging.dart';
class Logs{

  static bool _initialise = false;
  static final Logger _logger = Logger('Logs');

  static void init(){
    if(!_initialise){
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((record) {
        print(
            '${record.loggerName}: ${record.level.name}: ${record.time}: ${record.message}');
      });
      _initialise = true;
    }

  }

  static void addFinest(String message){
    _logger.finest(message);
  }

  static void addFiner(String message){
    _logger.finer(message);
  }

  static void addFine(String message){
    _logger.fine(message);
  }

  static void addConfig(String message){
    _logger.config(message);
  }

  static void addInfo(String message){
    _logger.info(message);
  }

  static void addWarning(String message){
    _logger.warning(message);
  }

  static void addSevere(String message){
    _logger.severe(message);
  }

  static void addShout(String message){
    _logger.shout(message);
  }


}