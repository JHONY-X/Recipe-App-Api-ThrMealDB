class CacheEntry<T> {
  final T data;
  final DateTime expiry;

  CacheEntry({required this.data, required this.expiry});

  bool get isExpired => DateTime.now().isAfter(expiry);
}

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  final Map<String, CacheEntry<dynamic>> _cache = {};
  final Duration _ttl = const Duration(minutes: 5);

  void save(String key, dynamic data) {
    _cache[key] = CacheEntry(
      data: data,
      expiry: DateTime.now().add(_ttl),
    );
  }

  T? get<T>(String key) {
    final entry = _cache[key];
    if (entry != null && !entry.isExpired) {
      return entry.data as T;
    }
    _cache.remove(key);
    return null;
  }

  void invalidate(String key) {
    _cache.remove(key);
  }

  void clear() {
    _cache.clear();
  }
}
