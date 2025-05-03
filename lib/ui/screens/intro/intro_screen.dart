import 'package:adhdo_it_mob/config/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class IntroModel {
  final String image;
  final EdgeInsets imagePadding;
  final List<TextSpan> titleSpans; // Изменено здесь
  final String subTitle;
  final Color backgroundColor;

  IntroModel({
    required this.image,
    required this.imagePadding,
    required this.titleSpans,
    required this.subTitle,
    required this.backgroundColor,
  });
}

final List<IntroModel> introPages = [
  IntroModel(
    backgroundColor: const Color(0xFFFFFACD),
    titleSpans: [
      const TextSpan(text: 'How to create\na '),
      const TextSpan(
        text: 'task',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
    subTitle: 'Tap the plus button to add a new task',
    image: 'assets/images/into_image1.png',
    imagePadding: const EdgeInsets.symmetric(horizontal: 16),
  ),
  IntroModel(
    backgroundColor: const Color(0xFFB5DAF6),
    titleSpans: [
      const TextSpan(
        text: 'Swit ',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(text: 'tasks'),
    ],
    subTitle: 'Swipe left to view the next task',
    image: 'assets/images/into_image2.png',
    imagePadding: const EdgeInsets.only(left: 12, right: 34),
  ),
  IntroModel(
    backgroundColor: const Color(0xFFFCCF9C),
    titleSpans: [
      const TextSpan(
        text: 'Start ',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(text: 'a task'),
    ],
    subTitle: 'Swipe right to start focusing on a task',
    image: 'assets/images/into_image3.png',
    imagePadding: const EdgeInsets.only(left: 33, right: 7),
  ),
];

class IntroScreen extends HookWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: introPages.length,
        itemBuilder: (context, index) {
          final page = introPages[index];
          final isLastPage = index == introPages.length - 1;

          return ColoredBox(
            color: page.backgroundColor,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Gap(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ADHDo.it',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go(Routes.home()),
                          child: const Text('Skip'),
                        ),
                      ],
                    ),
                    const Spacer(flex: 2),
                    Padding(
                      padding: page.imagePadding,
                      child: Image.asset(page.image),
                    ),
                    const Spacer(flex: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 40,
                                    height: 1,
                                    color:
                                        Colors
                                            .black, // Не забудь указать цвет текста!
                                  ),
                                  children: page.titleSpans,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                page.subTitle,
                                style: const TextStyle(
                                  color: Color(0xFF92918A),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Bounceable(
                          onTap:
                              () =>
                                  isLastPage
                                      ? context.go(Routes.home())
                                      : pageController.nextPage(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      ),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/svg/arrow_right.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(32),
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
