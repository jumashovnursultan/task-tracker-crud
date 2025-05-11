import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class PausePlayButton extends StatelessWidget {
  const PausePlayButton({super.key, required this.onTap, this.isPause = true});

  final VoidCallback onTap;
  final bool isPause;

  @override
  Widget build(BuildContext context) {
    print(isPause);
    return Bounceable(
      onTap: onTap,
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          color:
              !isPause
                  ? Color.fromRGBO(255, 255, 255, 1)
                  : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: Text(
          !isPause ? 'Pause' : 'Play',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
