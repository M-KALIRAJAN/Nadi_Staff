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
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        floatingLabelStyle: const TextStyle(
          color: AppColors.scoundry_clr,
          fontWeight: FontWeight.w400,
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.scoundry_clr,
            width: 1.5
          )
        ),
        errorBorder:OutlineInputBorder(
           borderRadius: BorderRadius.circular(12),
           borderSide: const BorderSide(
                 color: Colors.red
           )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red
          )
        ),
        
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map(
          (item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item))
        ).toList(),
        onChanged:onChanged,
    );
  }
}
