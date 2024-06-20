import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/view/widgets/body_text.dart';

class Helper{
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  String formatMillis(int millis) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    return formatDate(date);
  }

  Future<bool> internetAvailability() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  void showSnackBar(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: BodyText(text: message, size: 14, color: Colors.white)),
    );
  }

  Future<bool?> showConfirmationDialog(BuildContext context, String title, String content) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontFamily: 'poppins')),
          content: Text(content, style: const TextStyle(fontFamily: 'poppins')),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(fontFamily: 'poppins', color: Colors.black54)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Confirm', style: TextStyle(fontFamily: 'poppins')),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}