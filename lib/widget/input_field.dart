import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isDateField;
  final bool isTimeField;

  const InputField({
    super.key,
    required this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.isDateField = false,
    this.isTimeField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        maxLines: label == "Description" ? null : 1,
        controller: controller,
        keyboardType: keyboardType,
        readOnly: isDateField || isTimeField,
        onTap: () async {
          if (isDateField) {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            }
          } else if (isTimeField) {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              controller.text = pickedTime.format(context);
            }
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF063454)),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFbfdee9), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFbfdee9), width: 3),
          ),
        ),
      ),
    );
  }
}
