import 'package:logging/logging.dart';

void initLoggerListener() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');

    assert(() {
      if (record.error != null) {
        print('${record.error}');
      }
      if (record.stackTrace != null) {
        print('${record.stackTrace}');
      }

      return true;
    }());
  });
}
