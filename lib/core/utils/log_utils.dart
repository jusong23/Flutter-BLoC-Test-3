import 'package:logger/logger.dart';

import '../../main.dart';

var _enableLogger = false;
var _enableServiceLogger = false;

void enableLog(bool enabled) {
  _enableLogger = enabled;
  _enableServiceLogger = enabled;
}

final Logger logger = Logger(
  level: BUILD_TYPE == "release" ? Level.nothing : Level.verbose,
  filter: _ConsoleFilter(),
  printer: SimplePrinter(colors: false, printTime: true),
  output: _ConsoleOutput(),
);

final Logger loggerStack = Logger(
  level: BUILD_TYPE == "release" ? Level.nothing : Level.verbose,
  filter: _ConsoleFilter(),
  printer: PrettyPrinter(colors: false, printTime: true),
  output: _ConsoleOutput(),
);

final Logger loggerErr = Logger(
  level: BUILD_TYPE == "release" ? Level.nothing : Level.verbose,
  filter: _ConsoleFilter(),
  printer: _generateLoggerPrinter(PrettyPrinter(), "ErrorLogger"),
  output: _ConsoleOutput(),
);

final Logger serviceLogger = Logger(
  level: BUILD_TYPE == "release" ? Level.nothing : Level.verbose,
  filter: _ServiceLoggerConsoleFilter(),
  printer: _generateLoggerPrinter(SimplePrinter(colors: false, printTime: true), "ServiceLogger"),
  output: _ConsoleOutput(),
);

LogPrinter _generateLoggerPrinter(LogPrinter printer, String tag) {
  if (tag.isEmpty) {
    return printer;
  }

  return PrefixPrinter(
    printer,
    debug: "[$tag]",
    verbose: "[$tag]",
    wtf: "[$tag]",
    info: "[$tag]",
    warning: "[$tag]",
    error: "[$tag]",
  );
}

class _ConsoleFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return _enableLogger && BUILD_TYPE != "release";
  }
}

class _ServiceLoggerConsoleFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return _enableLogger && BUILD_TYPE != "release" && _enableServiceLogger;
  }
}

class _ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      printWrapped(line);
    }
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}

extension LoggerExt on Logger {
  void err(dynamic e, StackTrace? stacktrace) {
    loggerErr.log(Level.error, "", error: e, stackTrace: stacktrace);
  }
}
