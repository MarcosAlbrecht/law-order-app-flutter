// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app_law_order/src/config/custom_colors.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  final GlobalKey<FormFieldState>? formFieldKey;

  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final int? maxLength;

  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.icon,
    required this.label,
    this.isSecret = false,
    this.inputFormatters,
    this.initialValue,
    this.readOnly = false,
    this.formFieldKey,
    this.textInputType = TextInputType.text,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.maxLength,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();

    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        key: widget.formFieldKey,
        controller: widget.controller,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.textInputType,
        obscureText: isObscure,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: CustomColors.blueColor,
            ), // Defina a cor desejada da borda
          ),
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
          labelText: widget.label,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
