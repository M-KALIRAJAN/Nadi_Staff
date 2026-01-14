import 'package:flutter/material.dart';
import 'package:tech_app/core/constants/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final Icon? surfixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)?validator;
  final int? maxLines;
  final bool readOnly;
  final bool enabled;
  const AppTextField({
    super.key,
    required this.label,
    this.keyboardType,
    this.surfixIcon,
    this.isPassword = false,
     this.controller, 
      this.validator, 
      this.maxLines,
       this.enabled = true,
        this.readOnly = false, 
  
  });

  @override
  Widget build(BuildContext context) {
    bool _obscure = true;
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
            readOnly: readOnly,
      enabled: enabled,
      maxLines: maxLines ?? 1,
      obscureText: isPassword? _obscure :false,
      decoration: InputDecoration(
        labelText: label,

        labelStyle: TextStyle(fontSize: 14, color: Color(0xFF79747E)),
        floatingLabelStyle: TextStyle(fontSize: 12,color: AppColors.scoundry_clr),
       
        filled: true,
        fillColor: Colors.white, 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF79747E)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.scoundry_clr,
            width: 1.5
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red)
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius:BorderRadius.circular(12) ,
          borderSide: const BorderSide(color: Colors.red,width: 1.5)

        ),
        suffixIcon: isPassword ? IconButton(
          icon: Icon( 
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
           onPressed: (){
           
          }, 

          ) : null
      )
  
    );
  }
}
