import 'package:flutter/material.dart';
import 'package:todo_app/view/widgets/title_text.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white38,
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: SizedBox(
            width: double.infinity, // Match parent width
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // Button background color
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.transparent,
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: TitleText(size: 14, text: text, color: Colors.blue,),
                ),
              ),
            ),
          ),
        ),
      );
  }
}
