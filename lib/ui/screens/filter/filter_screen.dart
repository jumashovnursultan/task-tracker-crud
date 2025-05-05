import 'package:adhdo_it_mob/l10n/strings.dart';
import 'package:adhdo_it_mob/ui/dialogs/filter_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class FilterScreen extends HookConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Gap(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Gap(5),
                      SvgPicture.asset('assets/svg/arrow_back.svg'),
                      Text(
                        Strings.of(context).myTask,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                Bounceable(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (_) => FilterDialog(taskFilter: TaskFilter.all),
                    );
                  },
                  child: Container(
                    height: 44,
                    width: 215,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    margin: EdgeInsets.only(right: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          Strings.of(context).allTask,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SvgPicture.asset('assets/svg/arrow_dropdown.svg'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
