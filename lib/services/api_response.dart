class ApiResponse<T> {
  final T data;
  final bool isFromCache;

  ApiResponse({required this.data, required this.isFromCache});
}
