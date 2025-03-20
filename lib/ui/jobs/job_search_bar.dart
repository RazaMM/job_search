import 'package:flutter/material.dart';

class JobSearchBar extends StatelessWidget {
  const JobSearchBar({
    super.key,
    this.controller,
    required this.onChanged,
  });

  final TextEditingController? controller;
  final Function(String) onChanged;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Filter Job List',
      ),
    );
  }
}
