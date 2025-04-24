import 'package:flutter/material.dart';
import 'package:video_downloader/main.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;

  // ignore: use_key_in_widget_constructors
  const ButtonWidget({
    required this.title,
    required this.hasBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? Colors.white : theme.myAppMainColor,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(
                  color: theme.myAppMainColor,
                  width: 1.0,
                )
              : const Border.fromBorderSide(
                  BorderSide.none,
                ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 60.0,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: hasBorder ? theme.myAppMainColor : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
