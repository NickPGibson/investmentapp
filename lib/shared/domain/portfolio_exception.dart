class PortfolioException implements Exception {
  final Object? cause;
  final StackTrace? stackTrace;
  const PortfolioException({this.cause, this.stackTrace});
}
