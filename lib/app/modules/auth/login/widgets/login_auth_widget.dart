import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:projeto_unloucker/app/modules/auth/login/widgets/login_form_widget.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';
import 'package:projeto_unloucker/app/utils/utils.dart';

class WidgetFormLogin extends StatefulWidget {
  const WidgetFormLogin({super.key});

  @override
  State<WidgetFormLogin> createState() => _WidgetRegisterFormState();
}

class _WidgetRegisterFormState extends State<WidgetFormLogin> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode focusmail = FocusNode();
  FocusNode focusPass = FocusNode();

  bool isValidForm = false;
  bool isPasswordVisible = false;

  void clearForm() {
    setState(() {
      mailController.clear();
      passwordController.clear();
      isValidForm = false;
    });
  }

  void validateForm() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final values = formKey.currentState!.value;
      if (values['email'] == Constants.user && values['senha'] == Constants.password) {
        clearForm();
        Navigator.pushNamed(context, '/shop');
      } else {
        Utils.showToast(context: context, message: "Usuário e/ou senha inválidos!");
      }
    }
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          WigetFormField(
            child: FormBuilderTextField(
              controller: mailController,
              focusNode: focusmail,
              onSubmitted: (value) => focusPass.requestFocus(),
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'E-mail é obrigatório!'),
                FormBuilderValidators.email(errorText: 'Digite um e-mail válido!'),
              ]),
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Endereço de email',
                labelStyle: TextStyle(height: 0.2, color: Colors.grey.withOpacity(0.8)),
              ),
              keyboardType: TextInputType.emailAddress,
              name: 'email',
            ),
          ),
          const SizedBox(height: 16.0),
          WigetFormField(
            child: FormBuilderTextField(
              controller: passwordController,
              focusNode: focusPass,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'A senha é obrigatória!'),
                FormBuilderValidators.minLength(6, errorText: 'A senha deve ter pelo menos 6 caracteres!'),
              ]),
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Senha',
                labelStyle: TextStyle(height: 0.2, color: Colors.grey.withOpacity(0.8)),
                suffixIcon: IconButton(
                  icon: Icon(isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey.withOpacity(0.8)),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !isPasswordVisible,
              textInputAction: TextInputAction.done, // Finaliza a entrada de texto
              name: 'senha',
            ),
          ),
          TextButton(
            child: const Text("Esqueceu a senha?", style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
            onPressed: () => null,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.025),
            child: SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.07,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.primaryMedium,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => validateForm(),
                child: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(width: size.width * 0.3, height: size.height * 0.003, decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1))),
              const Text("Ou entre com", style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
              Container(width: size.width * 0.3, height: size.height * 0.003, decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1))),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.38,
                  child: ElevatedButton(
                    onPressed: () => null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/google_icon.png', height: 24),
                        const SizedBox(width: 8),
                        const Text('Google', style: TextStyle(color: Colors.black87, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: size.width * 0.38,
                  child: ElevatedButton(
                    onPressed: () => null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/steam_icon.png', height: 24),
                        const SizedBox(width: 8),
                        const Text('Steam', style: TextStyle(color: Colors.black87, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
