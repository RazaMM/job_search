import 'package:flutter/material.dart';
import 'package:job_search/data/models/job.dart';
import 'package:job_search/ui/core/widgets/date_form_field.dart';

class JobEditingForm extends StatefulWidget {
  const JobEditingForm({
    super.key,
    required this.job,
    required this.onSubmit,
    required this.onCancel,
  });

  final Job job;
  final void Function(Job) onSubmit;
  final void Function() onCancel;

  @override
  State<JobEditingForm> createState() => _JobEditingFormState();
}

class _JobEditingFormState extends State<JobEditingForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _companyController;
  late DateTime? _date;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.job.title);
    _companyController = TextEditingController(text: widget.job.company);
    _date = widget.job.dateApplied;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    print(_date);

    widget.onSubmit(widget.job.copyWith(
      title: _titleController.text,
      company: _companyController.text,
      dateApplied: _date!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Title input box
            TextFormField(
              decoration: InputDecoration(
                label: Text("Job Title"),
              ),
              controller: _titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the title of the position.';
                }
                return null;
              },
            ),
            // Company name
            TextFormField(
              decoration: InputDecoration(
                label: Text("Company Name"),
              ),
              controller: _companyController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the name of the company.';
                }
                return null;
              },
            ),
            // Date Applied Picker
            DateFormField(
              onChange: (date) {
                setState(() {
                  _date = date;
                });
              },
              initialValue: widget.job.dateApplied,
              decoration: InputDecoration(
                label: Text("Applied On"),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please enter the date you applied to this job';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: widget.onCancel,
                  child: const Text('Cancel'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
