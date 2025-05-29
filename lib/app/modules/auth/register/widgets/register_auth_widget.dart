import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:projeto_unloucker/app/modules/auth/register/widgets/register_formfield_widget.dart';
import 'package:projeto_unloucker/app/modules/auth/services/controller/register_controller.dart';
import 'package:projeto_unloucker/app/modules/auth/services/model/register_model.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class WidgetRegisterForm extends StatefulWidget {
  const WidgetRegisterForm({super.key});

  @override
  State<WidgetRegisterForm> createState() => _WidgetRegisterFormState();
}

class _WidgetRegisterFormState extends State<WidgetRegisterForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RegisterController controller = RegisterController();

  final FocusNode focusName = FocusNode();
  final FocusNode focusmail = FocusNode();
  final FocusNode focusPass = FocusNode();

  bool isPasswordVisible = false;
  bool isLoading = false;

  void clearForm() {
    nameController.clear();
    mailController.clear();
    passwordController.clear();
    _formKey.currentState?.reset();
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) return;

    setState(() => isLoading = true);

    try {
      final data = _formKey.currentState!.value;
      final model = RegisterModel(name: data['nome'], email: data['email'], password: data['senha'], role: "user");

      final success = await controller.registerUser(model);

      if (success) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cadastro realizado com sucesso!')));
        clearForm();
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Falha no cadastro. Tente novamente.')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          WigetFormField(
            child: FormBuilderTextField(
              name: 'nome',
              controller: nameController,
              focusNode: focusName,
              onSubmitted: (_) => focusmail.requestFocus(),
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.required(errorText: 'Nome é obrigatório!'),
              decoration: _inputDecoration('Nome'),
            ),
          ),
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
                onPressed: isLoading ? null : _submitForm,
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
