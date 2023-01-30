class Result {
  late bool status;
  late String? errorCode;
  late String? errorMessage;
  Result({
    required this.status,
    this.errorCode,
    this.errorMessage,
  });
}
