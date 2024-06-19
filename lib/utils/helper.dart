import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

class Helper{
  String unixTimeToAmPm(String? unixTime) {
    DateTime date =
    DateTime.fromMillisecondsSinceEpoch(int.parse(unixTime!) * 1000);
    return DateFormat('h:mm a').format(date);
  }

  Future<bool> internetAvailability() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}