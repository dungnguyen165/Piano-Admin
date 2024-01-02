import 'package:piano_admin/core/core.dart';
import 'package:piano_admin/core/data/local/cache/hive_secure_cache.dart';

class CacheUserLocalDataSource implements UserLocalDataSource {
  static const userCacheKey = '__user_cache_key';

  CacheUserLocalDataSource({Cache? cache})
      : _cache = cache ?? HiveSecureCache();

  final Cache _cache;

  @override
  Future<void> saveCurrentUser(UserModel user) {
    return _cache.write(key: userCacheKey, value: user);
  }

  @override
  UserModel getCurrentUser() {
    return _cache.read<UserModel>(key: userCacheKey) ?? UserModel.empty;
  }
}
