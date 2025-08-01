import 'package:hooks_riverpod/hooks_riverpod.dart';

const unauthorizedErrorCode = 401;
final clientErrorProvider = Provider((ref) => ClientErrorNotifier());

class ClientErrorNotifier extends StateNotifier<int?> {
  ClientErrorNotifier() : super(null);

  void notifyError(int? code) => state = code;

  // Check if there's an unauthorized error
  bool get isUnauthorized => state == unauthorizedErrorCode;
}
