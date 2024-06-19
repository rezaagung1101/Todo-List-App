import 'package:intl/intl.dart';

class Helper{
  String unixTimeToAmPm(String? unixTime) {
    DateTime date =
    DateTime.fromMillisecondsSinceEpoch(int.parse(unixTime!) * 1000);
    return DateFormat('h:mm a').format(date);
  }
}