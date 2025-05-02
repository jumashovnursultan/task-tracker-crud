import 'package:adhdo_it_mob/config/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IntroModel {
  final String image;
  final double leftPadding;
  final double rightPadding;
  final String title;
  final String subTitle;
  final Color backgroundColor;

  IntroModel({
    required this.image,
    required this.leftPadding,
    required this.rightPadding,
    required this.title,
    required this.subTitle,
    required this.backgroundColor,
  });
}

List<IntroModel> _pages() => [
  IntroModel(
    backgroundColor: Color(0xFFFFFACD),
    title: 'How to create a task',
    subTitle: 'Tap the plus button to add a new task',
    image: 'assets/images/into_image1.png',
    leftPadding: 16,
    rightPadding: 15,
  ),
  IntroModel(
    backgroundColor: Color(0xFFB5DAF6),
    title: 'Swit tasks',
    subTitle: 'Swipe left to view the next task',
    image: 'assets/images/into_image2.png',
    leftPadding: 12,
    rightPadding: 34,
  ),
  IntroModel(
    backgroundColor: Color(0xFFFCCF9C),
    title: 'Start a task',
    subTitle: 'Swipe right to start focusing on a task',
    image: 'assets/images/into_image3.png',
    leftPadding: 33,
    rightPadding: 7,
  ),
];

class IntroPage extends HookWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: _pages().length,
        itemBuilder: (context, index) {
          final page = _pages()[index];
          print(index);
          print(_pages().length);
          return ColoredBox(
            color: page.backgroundColor,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Gap(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ADHDo.it',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                        ),
                        TextButton(
                          child: Text('Skip'),
                          onPressed: () {
                            context.go(Routes.home());
                          },
                        ),
                      ],
                    ),
                    Spacer(flex: 2),
                    Padding(
                      padding: EdgeInsets.only(
                        left: page.leftPadding,
                        right: page.rightPadding,
                      ),
                      child: Image.asset(page.image),
                    ),
                    Spacer(flex: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                page.title,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              ),
                              Gap(10),
                              Text(
                                page.subTitle,
                                style: TextStyle(
                                  color: Color(0xFF92918A),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Bounceable(
                          onTap: () {
                            if (_pages().length == index + 1) {
                              context.go(Routes.home());
                            } else {
                              pageController.animateToPage(
                                index + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFFFFF),
                            ),
                            padding: EdgeInsets.only(left: 3),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/svg/arrow_right.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
