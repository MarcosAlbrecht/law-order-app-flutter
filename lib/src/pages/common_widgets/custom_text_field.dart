// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/entypo_icons.dart';

import 'package:app_law_order/src/config/custom_colors.dart';

class CustomTextField extends StatefulWidget {
  final IconData? icon;
  final String? label;
  final String? hint;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  final bool removeFloatingLabelBehavior;
  final GlobalKey<FormFieldState>? formFieldKey;
  final IconData? suffixIcon;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final void Function()? suffixIconButtonAttach;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;

  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    this.icon,
    this.label,
    this.hint,
    this.isSecret = false,
    this.inputFormatters,
    this.initialValue,
    this.readOnly = false,
    this.removeFloatingLabelBehavior = false,
    this.formFieldKey,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.suffixIconButtonAttach,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
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
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        decoration: InputDecoration(
          floatingLabelBehavior: widget.removeFloatingLabelBehavior ? FloatingLabelBehavior.never : FloatingLabelBehavior.auto,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: CustomColors.blueColor,
            ), // Defina a cor desejada da borda
          ),
          prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
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
              : widget.suffixIconButtonAttach != null
                  ? IconButton(
                      onPressed: widget.suffixIconButtonAttach,
                      icon: const Icon(
                        Entypo.attach,
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
