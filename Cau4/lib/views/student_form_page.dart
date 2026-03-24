import 'package:flutter/material.dart';

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedService;

  final List<String> _services = <String>[
    'Kiểm tra tổng quát',
    'Dịch vụ 2',
    'Dịch vụ 3',
  ];

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime initial = _selectedDate ?? now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1, 1, 1),
      lastDate: DateTime(now.year + 2, 12, 31),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
        '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay initial = _selectedTime ?? TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  String? _dateValidator(String? _) {
    if (_selectedDate == null) {
      return 'Vui lòng chọn ngày';
    }

    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final DateTime selected = DateUtils.dateOnly(_selectedDate!);

    if (selected.isBefore(today)) {
      return 'Ngày không hợp lệ (trong quá khứ)';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Đặt lịch thành công: ${_dateController.text} - ${_timeController.text} - $_selectedService',
          ),
        ),
      );
    }
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ĐẶT LỊCH HẸN 6451071017'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0F5A67),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: _pickDate,
                    decoration: _inputDecoration(
                      label: 'Chọn ngày',
                      icon: Icons.calendar_today_outlined,
                    ),
                    validator: _dateValidator,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _timeController,
                    readOnly: true,
                    onTap: _pickTime,
                    decoration: _inputDecoration(
                      label: 'Chọn giờ',
                      icon: Icons.access_time_outlined,
                    ),
                    validator: (_) {
                      if (_selectedTime == null) {
                        return 'Vui lòng chọn giờ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    value: _selectedService,
                    decoration: _inputDecoration(
                      label: 'Chọn dịch vụ',
                      icon: Icons.medical_services_outlined,
                    ),
                    items: _services
                        .map(
                          (String service) => DropdownMenuItem<String>(
                        value: service,
                        child: Text(service),
                      ),
                    )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedService = value;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng chọn dịch vụ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF39C12),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Xác nhận Đặt lịch',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
