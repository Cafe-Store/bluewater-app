import 'package:logger/logger.dart' as logger;

class Logger {
  static var log = logger.Logger(
    printer: logger.PrettyPrinter(),
  );

  static var logNoStack = logger.Logger(
    printer: logger.PrettyPrinter(methodCount: 0),
  );
}
