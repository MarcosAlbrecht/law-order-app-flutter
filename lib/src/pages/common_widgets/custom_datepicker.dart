// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final DateFormat dateFormart;
  final String label;
  final GlobalKey<FormFieldState>? formFieldKey;
  final void Function(DateTime?)? onSaved;
  final DateTime? initialValue;
  final String? Function(DateTime?)? validator;
  final Function(DateTime?)? onChanged;

  const CustomDatePicker({
    Key? key,
    required this.dateFormart,
    required this.label,
    this.formFieldKey,
    this.onSaved,
    this.initialValue,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DateTimeField(
        validator: widget.validator,
        initialValue: widget.initialValue,
        format: widget.dateFormart,
        key: widget.formFieldKey,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_month),
          //labelStyle: TextStyle(color: CustomColors.black),
          labelText: widget.label,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: CustomColors.blueColor,
            ),
          ),
        ),
        onShowPicker: (context, currentValue) async {
          return await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime.now(),
            initialDatePickerMode: DatePickerMode.year,
          );
        },
      ),
    );
  }
}
