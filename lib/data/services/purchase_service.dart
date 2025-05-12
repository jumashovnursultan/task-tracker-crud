import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseService {
  static final PurchaseService _instance = PurchaseService._internal();
  factory PurchaseService() => _instance;
  PurchaseService._internal();

  Function(String)? onPurchaseSuccess;
  Function(String)? onPurchaseError;
  final InAppPurchase _iap = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  List<ProductDetails> products = [];
  bool isAvailable = false;

  Future<void> init() async {
    isAvailable = await _iap.isAvailable();
    if (!isAvailable) {
      throw Exception('Store is not available');
    }

    const Set<String> ids = {'adhdoit_monthly', 'adhdoit_yearly'};
    final ProductDetailsResponse response = await _iap.queryProductDetails(ids);
    if (response.error != null || response.productDetails.isEmpty) {
      throw Exception('Failed to load products');
    }

    products = response.productDetails;

    _subscription = _iap.purchaseStream.listen(
      (purchases) => _listenToPurchases(purchases),
      onDone: () => _subscription.cancel(),
      onError: (error) {
        print('Purchase Stream Error: $error');
      },
    );
  }

  void _listenToPurchases(List<PurchaseDetails> purchases) {
    for (var purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased) {
        print('Purchase success: ${purchase.productID}');

        if (purchase.pendingCompletePurchase) {
          _iap.completePurchase(purchase);
        }

        // ВАЖНО: вызвать callback успеха
        onPurchaseSuccess?.call(purchase.productID);
      } else if (purchase.status == PurchaseStatus.error) {
        print('Purchase failed: ${purchase.error}');

        // ВАЖНО: вызвать callback ошибки
        onPurchaseError?.call(purchase.error?.message ?? 'Unknown error');
      }
    }
  }

  Future<void> buy(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  void dispose() {
    _subscription.cancel();
  }
}
