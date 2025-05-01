class ApiResponse<T> {
  String? message;
  T? result;
  dynamic errorData;
  int? statusCode;

  bool get isSuccessful =>
      statusCode != null && statusCode! >= 200 && statusCode! <= 299;

  ApiResponse({
    this.statusCode,
    this.message,
    this.result,
    this.errorData,
  });

  static ApiResponse<T> error<T>(String message, {dynamic errorData}) {
    return ApiResponse<T>(
      statusCode: 400,
      message: message,
      errorData: errorData,
    );
  }

  TResult when<TResult>({
    required TResult Function(T? result) success,
    required TResult Function(String? message, dynamic errorData) error,
  }) =>
      isSuccessful ? success(result) : error(message, errorData);

  @override
  String toString() {
    return 'ApiResponse(message: $message, result: $result, errorData: $errorData, statusCode: $statusCode)';
  }
}
