import 'dart:io';

import 'package:flutter/material.dart';

class ConnectionIndicator extends StatelessWidget {
  const ConnectionIndicator({super.key, required this.isBackOnline});

  final bool isBackOnline;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: kBottomBarHeight,
        width: double.infinity,
        alignment: Alignment.center,
        color: isBackOnline ? Color(0xFF2CA641) : Color(0xFF212121),
        child: Text(
          isBackOnline
              ? 'Подключение к интернету установлено'
              : 'Нет подключения к интернету',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

final kBottomBarHeight = Platform.isIOS ? 30.0 : 25.0;
