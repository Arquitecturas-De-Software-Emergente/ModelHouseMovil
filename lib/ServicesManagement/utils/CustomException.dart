class CustomException implements Exception {
  int? statusCode;
  String? error;
  String? message;

  CustomException({
    this.statusCode,
    this.error,
    this.message,
  });

  @override
  String toString() {
    return 'CustomException{statusCode: $statusCode, error: $error, message: $message}';
  }
}
