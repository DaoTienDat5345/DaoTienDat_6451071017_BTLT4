import 'package:flutter/material.dart';

import '../utils/validators.dart';
import '../widget/custom_text_form_field.dart';
import '../widget/custom_dropdown_form_field.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  // Form fields
  String? gender; // Dropdown
  String? maritalStatus = 'Độc thân'; // Radio - mặc định
  double salary = 15.0; // Slider - mức thu nhập

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void submitForm() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid && gender != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form hợp lệ 🎉')),
      );
      print('Tên: ${nameController.text}');
      print('Tuổi: ${ageController.text}');
      print('Giới tính: $gender');
      print('Tình trạng hôn nhân: $maritalStatus');
      print('Mức thu nhập: $salary tr VND');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORM THÔNG TIN CÁ NHÂN 6451071017'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Họ và tên
                CustomTextFormField(
                  controller: nameController,
                  label: 'Họ và tên',
                  validator: (value) => Validators.requiredField(value, 'Họ và tên'),
                ),
                const SizedBox(height: 16),

                // Tuổi
                CustomTextFormField(
                  controller: ageController,
                  label: 'Tuổi',
                  validator: Validators.ageValidator,
                ),
                const SizedBox(height: 16),

                // Giới tính (Dropdown)
                CustomDropdownFormField(
                  label: 'Giới tính',
                  value: gender,
                  items: ['Nam', 'Nữ', 'Khác'],
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng chọn giới tính';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Tình trạng hôn nhân (Radio)
                const Text(
                  'Tình trạng hôn nhân',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                RadioListTile<String>(
                  title: const Text('Độc thân'),
                  value: 'Độc thân',
                  groupValue: maritalStatus,
                  onChanged: (value) {
                    setState(() {
                      maritalStatus = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Kết hôn'),
                  value: 'Kết hôn',
                  groupValue: maritalStatus,
                  onChanged: (value) {
                    setState(() {
                      maritalStatus = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Ly hôn'),
                  value: 'Ly hôn',
                  groupValue: maritalStatus,
                  onChanged: (value) {
                    setState(() {
                      maritalStatus = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Mức thu nhập (Slider)
                const Text(
                  'Mức thu nhập',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Column(
                  children: [
                    Slider(
                      value: salary,
                      min: 0,
                      max: 30,
                      divisions: 60,
                      label: 'Mức: ${salary.toStringAsFixed(1)} tr VND',
                      onChanged: (value) {
                        setState(() {
                          salary = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('0 tr VND'),
                          Text('10 tr VND'),
                          Text('20 tr VND'),
                          Text('30 tr VND'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Nút Submit
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Gửi',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}