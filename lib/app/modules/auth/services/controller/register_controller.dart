import 'package:projeto_unloucker/app/modules/auth/services/model/register_model.dart';
import 'package:projeto_unloucker/app/modules/auth/services/repository/register.repository.dart';

class RegisterController {
  RegisterRepository repository = RegisterRepository();

  Future<bool> registerUser(RegisterModel registerModel) async {
    bool response = false;
    try {
      response = await repository.register(registerModel);
    } catch (err) {
      throw Exception(err);
    }
    return response;
  }
}
