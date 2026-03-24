import 'package:flutter/material.dart';

import '../utils/validators.dart';
import '../widget/custom_text_form_field.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _agreePolicy = false;
  bool _isFormValid = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateFormValidState() {
    final isValidFields =
        Validators.requiredField(_fullNameController.text, 'Họ và tên') == null &&
        Validators.emailValidator(_emailController.text) == null &&
        Validators.passwordValidator(_passwordController.text) == null;

    setState(() {
      _isFormValid = isValidFields && _agreePolicy;
    });
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!_agreePolicy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn phải đồng ý với điều khoản & chính sách')),
      );
      return;
    }

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký tài khoản'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Icon(
                Icons.account_circle,
                size: 80,
                color: Colors.teal,
              ),
              const SizedBox(height: 24),

              CustomTextFormField(
                controller: _fullNameController,
                label: 'Họ và tên',
                validator: (value) =>
                    Validators.requiredField(value, 'Họ và tên'),
                onChanged: (_) => _updateFormValidState(),
              ),

              const SizedBox(height: 16),

              CustomTextFormField(
                controller: _emailController,
                label: 'Email',
                validator: Validators.emailValidator,
                onChanged: (_) => _updateFormValidState(),
              ),

              const SizedBox(height: 16),

              CustomTextFormField(
                controller: _passwordController,
                label: 'Mật khẩu',
                obscureText: true,
                validator: Validators.passwordValidator,
                onChanged: (_) => _updateFormValidState(),
              ),

              const SizedBox(height: 16),

              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tôi đồng ý với các Điều khoản & Chính sách'),
                value: _agreePolicy,
                onChanged: (value) {
                  setState(() {
                    _agreePolicy = value ?? false;
                  });
                  _updateFormValidState();
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _isFormValid ? _submitForm : null,
                  child: const Text('Đăng ký'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

