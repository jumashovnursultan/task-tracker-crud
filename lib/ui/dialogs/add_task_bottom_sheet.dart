import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AddTaskBottomSheet extends HookWidget {
  const AddTaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final priority = useState(0);

    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 4.0),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: textController,
                  maxLines: null,
                  minLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: '|Add task',
                    hintStyle: TextStyle(
                      color: Color(0xFF92918A),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
                Gap(10),
                SizedBox(
                  height: 24,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (context, index) => Gap(16),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          priority.value = index + 1;
                        },
                        child:
                            index < priority.value
                                ? SvgPicture.asset(
                                  'assets/svg/star_filled.svg',
                                  color: Color(0xFFFF4C4C),
                                )
                                : SvgPicture.asset(
                                  'assets/svg/star_outline.svg',
                                ),
                      );
                    },
                  ),
                ),
                Gap(15),

                Row(
                  children: [
                    Gap(10),
                    SvgPicture.asset('assets/svg/calendar.svg'),
                    Gap(25),
                    SvgPicture.asset('assets/svg/watch.svg'),
                    Gap(20),
                    SvgPicture.asset('assets/svg/bell.svg'),
                    Gap(8),
                    SvgPicture.asset('assets/svg/attach.svg'),
                    Spacer(),
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF5F5F5),
                      ),
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 23,
                        width: 24,
                        child: SvgPicture.asset('assets/svg/microphone.svg'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
