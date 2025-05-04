import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Center(
            child: CircularProgressIndicator.adaptive(
              strokeAlign: 1.2,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
