import 'package:shared_preferences/shared_preferences.dart';

abstract class Storage {
  Future<SharedPreferences> get instance;
}

class StorageImpl implements Storage {
  const StorageImpl();

  @override
  Future<SharedPreferences> get instance async =>
      await SharedPreferences.getInstance();
}
