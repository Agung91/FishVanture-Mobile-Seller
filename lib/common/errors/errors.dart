abstract class Errors {
  const Errors({
    this.code,
    required this.message,
    this.detail,
  });

  final String? code;
  final String message;
  final String? detail;
}
