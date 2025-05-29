import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:projeto_unloucker/app/modules/auth/login/widgets/login_form_widget.dart'; // Wrapper de estilo
import 'package:projeto_unloucker/app/modules/auth/services/cubit/auth_cubit.dart';
import 'package:projeto_unloucker/app/modules/auth/services/model/auth_model.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';
import 'package:projeto_unloucker/app/utils/utils.dart';

class WidgetFormLogin extends StatefulWidget {
  const WidgetFormLogin({super.key});

  @override
  State<WidgetFormLogin> createState() => _WidgetFormLoginState(); // Nome do State corrigido
}

class _WidgetFormLoginState extends State<WidgetFormLogin> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode focusmail = FocusNode();
  final FocusNode focusPass = FocusNode();

  bool isPasswordVisible = false;

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) return;

    final data = _formKey.currentState!.value;

    final model = AuthModel(email: data['email'], password: data['senha']);

    await context.read<AuthCubit>().performSignIn(model);
  }

  void clearForm() {
    mailController.clear();
    passwordController.clear();
    _formKey.currentState?.reset();
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    focusmail.dispose();
    focusPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthSuccess) {
          Utils.showSuccess(context: context, message: 'Login realizado com sucesso');
          clearForm();
          Navigator.pushNamedAndRemoveUntil(context, '/shop', (route) => false);
          await Future.delayed(const Duration(seconds: 5));
        } else if (state is AuthFailure) {
          Utils.showInfo(context: context, message: state.error);
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                WigetFormField(
                  child: FormBuilderTextField(
                    name: 'email',
                    controller: mailController,
                    focusNode: focusmail,
                    enabled: !isLoading,
                    onSubmitted: (_) => focusPass.requestFocus(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'E-mail é obrigatório!'),
                      FormBuilderValidators.email(errorText: 'Digite um e-mail válido!'),
                    ]),
                    decoration: const InputDecoration(border: InputBorder.none, labelText: 'Endereço de email'),
                  ),
                ),
                const SizedBox(height: 16.0),
                WigetFormField(
                  child: FormBuilderTextField(
                    name: 'senha',
                    controller: passwordController,
                    focusNode: focusPass,
                    enabled: !isLoading,
                    obscureText: !isPasswordVisible,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submitForm(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'A senha é obrigatória!'),
                      FormBuilderValidators.minLength(6, errorText: 'A senha deve ter pelo menos 6 caracteres!'),
                    ]),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: isLoading ? null : () {},
                  child: const Text("Esqueceu a senha?", style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: size.height * 0.025),
                  child: SizedBox(
                    width: size.width * 0.8,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryMedium,
                        disabledBackgroundColor: Constants.primaryMedium.withOpacity(0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: isLoading ? null : _submitForm,
                      child:
                          isLoading
                              ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                              : const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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
}
