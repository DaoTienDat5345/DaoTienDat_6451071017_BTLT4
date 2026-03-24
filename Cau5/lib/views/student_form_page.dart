import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../utils/validators.dart';
import '../widgets/custom_text_form_field.dart';

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  PlatformFile? _selectedCv;
  bool _isConfirmed = false;
  String? _fileError;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickCv() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['pdf', 'docx'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedCv = result.files.first;
        _fileError = null;
      });
    }
  }

  void _submitForm() {
    final bool isFormValid = _formKey.currentState?.validate() ?? false;

    setState(() {
      _fileError = _selectedCv == null ? 'Vui lòng upload CV của bạn!' : null;
    });

    if (!isFormValid || _selectedCv == null) {
      return;
    }

    if (!_isConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn cần xác nhận thông tin trước khi nộp')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Nộp hồ sơ thành công: ${_selectedCv!.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = _fileError == null ? Colors.grey : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 5: Form upload hồ sơ 6451071017'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextFormField(
                controller: _fullNameController,
                label: 'Họ và tên',
                validator: (String? value) =>
                    Validators.requiredField(value, 'Họ và tên'),
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                controller: _emailController,
                label: 'Email',
                validator: Validators.emailValidator,
              ),
              const SizedBox(height: 16),
              const Text(
                'File Picker',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text('CV (định dạng: PDF, DOCX)'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _pickCv,
                      child: const Text('Chọn Tệp CV'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _selectedCv?.name ?? 'Chưa chọn tệp',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (_fileError != null) ...<Widget>[
                const SizedBox(height: 6),
                Text(
                  _fileError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              const SizedBox(height: 12),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _isConfirmed,
                onChanged: (bool? value) {
                  setState(() {
                    _isConfirmed = value ?? false;
                  });
                },
                title: const Text('Tôi xác nhận thông tin là chính xác.'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Nộp Hồ Sơ'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
