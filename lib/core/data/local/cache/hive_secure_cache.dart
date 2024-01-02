import 'package:hive/hive.dart';
import 'cache.dart';

class HiveSecureCache extends Cache {
  final Box _box;

  HiveSecureCache({Box? box}) : _box = box ?? Hive.box('secureAppBox');

  @override
  T? read<T extends Object>({required String key}) {
    final value = _box.get(key);
    if (value is T) return value;
    return null;
  }

  @override
  Future<void> write<T extends Object>(
      {required String key, required T value}) {
    return _box.put(key, value);
  }
}
