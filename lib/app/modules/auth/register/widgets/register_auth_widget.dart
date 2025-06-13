import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:projeto_unloucker/app/modules/auth/register/widgets/register_formfield_widget.dart';
import 'package:projeto_unloucker/app/modules/auth/services/cubit/auth_controller.dart';
import 'package:projeto_unloucker/app/modules/auth/services/model/auth_model.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';
import 'package:projeto_unloucker/app/utils/utils.dart';

class WidgetRegisterForm extends StatefulWidget {
  const WidgetRegisterForm({super.key});

  @override
  State<WidgetRegisterForm> createState() => _WidgetRegisterFormState();
}

class _WidgetRegisterFormState extends State<WidgetRegisterForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode focusmail = FocusNode();
  final FocusNode focusPass = FocusNode();

  bool isPasswordVisible = false;

  void clearForm() {
    mailController.clear();
    passwordController.clear();
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) return;

    final data = _formKey.currentState!.value;

    final model = AuthModel(email: data['email'], password: data['senha']);

    await context.read<AuthController>().performSignUp(model);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthController, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Utils.showSuccess(context: context, message: 'Cadastro realizado com sucesso');
          clearForm();
        } else if (state is AuthFailure) {
          Utils.showInfo(context: context, message: state.error);
        }
      },
      child: BlocBuilder<AuthController, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                WigetFormField(
                  child: FormBuilderTextField(
                    name: 'email',
                    controller: mailController,
                    focusNode: focusmail,
                    onSubmitted: (_) => focusPass.requestFocus(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'E-mail é obrigatório!'),
                      FormBuilderValidators.email(errorText: 'Digite um e-mail válido!'),
                    ]),
                    decoration: _inputDecoration('Endereço de email'),
                  ),
                ),
                const SizedBox(height: 16.0),
                WigetFormField(
                  child: FormBuilderTextField(
                    name: 'senha',
                    controller: passwordController,
                    focusNode: focusPass,
                    obscureText: !isPasswordVisible,
                    textInputAction: TextInputAction.done,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'A senha é obrigatória!'),
                      FormBuilderValidators.minLength(6, errorText: 'A senha deve ter pelo menos 6 caracteres!'),
                    ]),
                    decoration: _inputDecoration(
                      'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey.withOpacity(0.8)),
                        onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                      ),
                    ),
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
                      onPressed: isLoading ? null : () => {_submitForm()},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryMedium,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child:
                          isLoading
                              ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                              : const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      border: InputBorder.none,
      labelText: label,
      labelStyle: TextStyle(height: 0.2, color: Colors.grey.withOpacity(0.8)),
      suffixIcon: suffixIcon,
    );
  }
}
