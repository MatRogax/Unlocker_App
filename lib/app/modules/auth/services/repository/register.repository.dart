// lib/repositories/register_repository.dart
import 'package:dio/dio.dart';
import 'package:projeto_unloucker/app/modules/auth/services/model/register_model.dart';
import 'package:projeto_unloucker/app/utils/utils.dart';

abstract class AbstractRegisterRepository{
  Future<bool> register(RegisterModel registerModel);
  
}

class RegisterRepository implements AbstractRegisterRepository {
  final Dio _dio = Utils.dioIstance;

  @override
  Future<bool> register(RegisterModel registerModel) async{
    bool response = false;
     await _dio.post(
        '/user/create',
        data: registerModel.toMap(),
      ).then((value) {
        response = true;
      });
      return response;
  }

}
