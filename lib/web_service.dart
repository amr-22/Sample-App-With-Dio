import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sample_app_with_dio/user.dart';

part 'web_service.g.dart';

@RestApi(baseUrl: 'https://gorest.co.in/public/v2/')
abstract class WebService {
  factory WebService(Dio dio, {String? baseUrl}) = _WebService;

  @GET('users')
  Future<List<User>> getAllUsers();
}
