import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

class ExpandableBlurText extends HookWidget {
  final String text;
  const ExpandableBlurText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: GestureDetector(
          onTap: () => isExpanded.value = !isExpanded.value,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.2),
            ),
            child: Stack(
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      text,
                      maxLines: isExpanded.value ? null : 1,
                      overflow:
                          isExpanded.value
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      isExpanded.value
                          ? 'assets/svg/arrow_up.svg'
                          : 'assets/svg/arrow_forward.svg',
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
