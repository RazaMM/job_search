import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends StatefulWidget {
  DateFormField({
    super.key,
    this.initialValue,
    this.validator,
    this.decoration,
    required this.onChange,
  }) : formatter = DateFormat.yMMMd();

  final DateTime? initialValue;
  final Function(DateTime?) onChange;
  final InputDecoration? decoration;
  final String? Function(DateTime?)? validator;
  final DateFormat formatter;

  @override
  State<DateFormField> createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  DateTime? date;
  late final TextEditingController controller;

  @override
  void initState() {
    date = widget.initialValue;

    final initialValueText = widget.initialValue == null
        ? ""
        : widget.formatter.format(widget.initialValue!);

    controller = TextEditingController(text: initialValueText);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void promptForDate() async {
    final now = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );

    widget.onChange(selectedDate);
    setState(() {
      date = selectedDate;
    });

    controller.text =
        selectedDate == null ? "" : widget.formatter.format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: promptForDate,
      decoration: widget.decoration,
      validator: (value) {
        return widget.validator?.call(date);
      },
    );
  }
}
