import 'package:flutter/material.dart';

class StudentFormPage extends StatefulWidget {
  @override
  State<StudentFormPage> createState() => _SurveyFormPageState();
}

class _SurveyFormPageState extends State<StudentFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController notesController = TextEditingController();

  // Checkboxes for interests
  Map<String, bool> interests = {
    'Phim ảnh (Movies)': false,
    'Thể thao (Sports)': false,
    'Âm nhạc (Music)': false,
    'Du lịch (Travel)': false,
  };

  // Radio button for satisfaction level
  String? satisfactionLevel;

  void submitForm() {
    // Validate that at least 1 checkbox is selected
    bool anyInterestSelected = interests.values.any((value) => value);

    if (!anyInterestSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bạn phải chọn ít nhất 1 sở thích')),
      );
      return;
    }

    // Validate satisfaction level
    if (satisfactionLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bạn phải chọn mức độ hài lòng')),
      );
      return;
    }

    // Validate form
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gửi khảo sát thành công 🎉')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Survey 6451071017')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Interests
              Text(
                'SỐ THÍCH (INTERESTS)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ...interests.entries.map((entry) {
                return CheckboxListTile(
                  title: Text(entry.key),
                  value: entry.value,
                  onChanged: (value) {
                    setState(() {
                      interests[entry.key] = value ?? false;
                    });
                  },
                );
              }).toList(),

              SizedBox(height: 16),

              // Section 2: Satisfaction Level
              Text(
                'MỨC ĐỘ HÀI LÒNG (SATISFACTION LEVEL)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              RadioListTile(
                title: Text('Hài lòng (Satisfied)'),
                value: 'Satisfied',
                groupValue: satisfactionLevel,
                onChanged: (value) {
                  setState(() {
                    satisfactionLevel = value;
                  });
                },
              ),
              RadioListTile(
                title: Text('Bình thường (Neutral)'),
                value: 'Neutral',
                groupValue: satisfactionLevel,
                onChanged: (value) {
                  setState(() {
                    satisfactionLevel = value;
                  });
                },
              ),
              RadioListTile(
                title: Text('Chưa hài lòng (Unsatisfied)'),
                value: 'Unsatisfied',
                groupValue: satisfactionLevel,
                onChanged: (value) {
                  setState(() {
                    satisfactionLevel = value;
                  });
                },
              ),

              SizedBox(height: 16),

              // Section 3: Additional Notes
              Text(
                'GHI CHÚ THÊM (ADDITIONAL NOTES)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: notesController,
                decoration: InputDecoration(
                  hintText: 'Ghi chú thêm...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),

              SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: submitForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                  ),
                  child: Text('Gửi Khảo Sát'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}
