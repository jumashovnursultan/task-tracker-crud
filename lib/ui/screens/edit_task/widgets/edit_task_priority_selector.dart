import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EditTaskPrioritySelector extends StatelessWidget {
  const EditTaskPrioritySelector({super.key, required this.priority});

  final ValueNotifier<int> priority;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,

      decoration: BoxDecoration(
        color: Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/svg/star_filled.svg',
                color: Colors.black,
              ),
              Gap(8),
              Text(
                'Priority',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Flexible(
            child: SizedBox(
              height: 24,
              width: 184,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) => Gap(16),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (priority.value == index + 1) {
                        priority.value = 0;
                      } else {
                        priority.value = index + 1;
                      }
                    },
                    child:
                        index < priority.value
                            ? SvgPicture.asset(
                              'assets/svg/star_filled.svg',
                              color: Color(0xFFFF4C4C),
                            )
                            : SvgPicture.asset('assets/svg/star_outline.svg'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
