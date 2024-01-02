import 'package:piano_admin/core/core.dart';

import '../../../authentication.dart';

class HiveAuthLocalDataSource implements AuthLocalDataSource {
  static const userCacheKey = '__user_cache_key';

  HiveAuthLocalDataSource({Cache? cache}) : _cache = cache ?? HiveCache();

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
