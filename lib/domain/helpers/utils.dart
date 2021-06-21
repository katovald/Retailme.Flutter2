import 'package:android_multiple_identifier/android_multiple_identifier.dart';
import 'package:intl/intl.dart';

class Utils {
  static Future<String> uuidSerial() async => await AndroidMultipleIdentifier.serialCode;
  static String get currentDate => DateFormat('aaaa-mm-dd hh:MM:ss').format(DateTime.now());
}