import 'package:adhdo_it_mob/config/router/app_route.dart';
import 'package:adhdo_it_mob/helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:adhdo_it_mob/providers/purchase_providers.dart';

class TariffSelectionScreen extends HookConsumerWidget {
  const TariffSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTariff = useState('year'); // 'year' or 'month'
    final isLoading = useState(false);

    final purchaseState = ref.watch(purchaseNotifierProvider);
    final purchaseNotifier = ref.read(purchaseNotifierProvider.notifier);

    useEffect(() {
      purchaseNotifier.loadProducts();

      purchaseNotifier.setupCallbacks(
        onSuccess: (productId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Покупка успешна: $productId'),
              backgroundColor: Colors.green,
            ),
          );

          // Например, перенаправить на главный экран:
          context.go(Routes.intro());
        },
        onError: (errorMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ошибка покупки: $errorMessage'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );

      return null;
    }, []);

    purchaseNotifier.setupCallbacks(
      onSuccess: (productId) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Покупка успешна!'),
            backgroundColor: Colors.green,
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          context.go(Routes.intro());
        });
      },
      onError: (errorMessage) {
        showToast(
          context,
          msg: 'Ошибка покупки: $errorMessage',
          type: ToastificationType.error,
        );
      },
    );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(14),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Bounceable(
                      onTap: () {
                        context.go(Routes.intro());
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromRGBO(238, 238, 238, 1),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset('assets/svg/cancel.svg'),
                      ),
                    ),
                  ),

                  const Text(
                    'Tariff plan',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                  ),
                  const Gap(20),
                  Image.asset('assets/images/logo.png'),
                  const Gap(30),

                  // Tariff Options
                  _TariffOption(
                    isYear: true,
                    title: 'ADHDo.it',
                    subtitle: '1 month free, then \$30/year',
                    selected: selectedTariff.value == 'year',
                    onTap: () => selectedTariff.value = 'year',
                  ),
                  const Gap(8),
                  _TariffOption(
                    isYear: false,
                    title: 'ADHDo.it',
                    subtitle: '1 month free, then \$5/month',
                    selected: selectedTariff.value == 'month',
                    onTap: () => selectedTariff.value = 'month',
                  ),

                  Spacer(),

                  Text(
                    selectedTariff.value == 'year'
                        ? '1 month free, then \$30/year'
                        : '1 month free, then \$5/month',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(146, 145, 138, 1),
                    ),
                  ),
                  const Gap(8),

                  Bounceable(
                    onTap: () async {
                      try {
                        isLoading.value = true; // Показываем лоадер

                        final selectedProduct = purchaseState.products
                            .firstWhere(
                              (p) =>
                                  selectedTariff.value == 'year'
                                      ? p.id == 'adhdoit_yearly'
                                      : p.id == 'adhdoit_monthly',
                            );

                        await purchaseNotifier.buy(selectedProduct);
                      } catch (e) {
                        print('Ошибка покупки: $e');
                      } finally {
                        isLoading.value =
                            false; // Скрываем лоадер после завершения
                      }
                    },

                    child: Container(
                      alignment: Alignment.center,
                      height: 54,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child:
                          isLoading.value
                              ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2,
                                ),
                              )
                              : const Text(
                                'Try for free',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                    ),
                  ),
                  const Gap(32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TariffOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;
  final bool isYear;

  const _TariffOption({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
    required this.isYear,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border:
              selected
                  ? Border.all(width: 1, color: Color.fromRGBO(255, 238, 0, 1))
                  : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: title,

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: ' '),
                      TextSpan(
                        text: isYear ? 'for a year' : 'for a month',

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(146, 145, 138, 1),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(4),
                Text(subtitle, style: TextStyle(fontSize: 16)),
              ],
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      selected ? Theme.of(context).primaryColor : Colors.grey,
                  width: 2,
                ),
              ),
              child:
                  selected
                      ? SvgPicture.asset('assets/svg/check_selected.svg')
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
