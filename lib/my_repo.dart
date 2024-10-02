import 'package:sample_app_with_dio/web_service.dart';
import 'package:sample_app_with_dio/user.dart';

class MyRepo {
  final WebService webServices;

  MyRepo(this.webServices);

  Future<List<User>> getAllUsers() async {
    var response = await webServices.getAllUsers();
    return response.map((user) => User.fromJson(user.toJson())).toList();
  }
}
