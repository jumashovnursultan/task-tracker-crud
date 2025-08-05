import 'package:to_do/data/services/purchase_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

part 'purchase_providers.g.dart';
part 'purchase_providers.freezed.dart';

enum PurchaseStatus { initial, loading, success, error }

@freezed
abstract class PurchaseState with _$PurchaseState {
  const factory PurchaseState({
    @Default(PurchaseStatus.initial) PurchaseStatus status,
    @Default([]) List<ProductDetails> products,
    String? error,
  }) = _PurchaseState;
}

@riverpod
class PurchaseNotifier extends _$PurchaseNotifier {
  final _purchaseService = PurchaseService();

  @override
  PurchaseState build() {
    return const PurchaseState();
  }

  Future<void> loadProducts() async {
    state = state.copyWith(status: PurchaseStatus.loading);
    try {
      await _purchaseService.init();
      state = state.copyWith(
        status: PurchaseStatus.success,
        products: _purchaseService.products,
      );
    } catch (e) {
      state = state.copyWith(status: PurchaseStatus.error, error: e.toString());
    }
  }

  void setupCallbacks({
    required Function(String) onSuccess,
    required Function(String) onError,
  }) {
    _purchaseService.onPurchaseSuccess = onSuccess;
    _purchaseService.onPurchaseError = onError;
  }

  Future<void> buy(ProductDetails product) async {
    await _purchaseService.buy(product);
  }

  Future<void> restorePurchases() async {
    await _purchaseService.restorePurchases();
  }
}
