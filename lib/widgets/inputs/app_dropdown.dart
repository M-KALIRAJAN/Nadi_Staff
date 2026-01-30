import 'package:flutter/material.dart';
import 'package:tech_app/core/constants/app_colors.dart';

class AppDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;

  const AppDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      validator: validator,
      style: const TextStyle(
        color: Colors.black, 
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.scoundry_clr,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white, 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF79747E)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.scoundry_clr,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(color: Colors.black), 
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
