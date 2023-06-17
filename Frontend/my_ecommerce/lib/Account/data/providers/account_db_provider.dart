import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/services/database_service.dart';
import '../models/user.dart';

class AccountDatabaseProvider extends DatabaseService {
  AccountDatabaseProvider(super.secureStorage,super.prefs) : super();
Future<void> setToken(String token) async => await secureStorage.write(
        key: 'token',
        value: token,
      );
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    return await secureStorage.delete(key: 'token');
  }

   Future<User?> getUser() async {
    final userBox = await Boxes.getUserBox();
    return userBox.get('currentUser');
  }

    Future<void> setUser(User user) async {
    final userBox = await Boxes.getUserBox();
    await userBox.put('currentUser', user);
  }
}
