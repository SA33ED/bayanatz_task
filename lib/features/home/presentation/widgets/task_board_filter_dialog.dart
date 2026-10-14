import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_drop_down_button.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class TaskBoardFilterDialog extends StatefulWidget {
  const TaskBoardFilterDialog({
    super.key,
    required this.departments,
    this.initialDate,
    this.initialDepartment,
    this.initialOwnershipStatus,
    required this.onApply,
    required this.onReset,
  });

  final List<String> departments;
  final DateTime? initialDate;
  final String? initialDepartment;
  final String? initialOwnershipStatus;
  final void Function(DateTime? date, String? department, String? status)
  onApply;
  final VoidCallback onReset;

  @override
  State<TaskBoardFilterDialog> createState() => _TaskBoardFilterDialogState();
}

class _TaskBoardFilterDialogState extends State<TaskBoardFilterDialog> {
  DateTime? _date;
  String? _department;
  String? _status;

  @override
  void initState() {
    super.initState();
    _date = widget.initialDate;
    _department = widget.initialDepartment;
    _status = widget.initialOwnershipStatus;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: _date ?? DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Boards'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(8),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Creation Date',
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  child: Text(
                    _date == null
                        ? 'Any date'
                        : '${_date!.day}/${_date!.month}/${_date!.year}',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomDropDownButton(
                label: 'Department',
                value: _department,
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('All departments'),
                  ),
                  ...widget.departments.map(
                    (department) => DropdownMenuItem<String>(
                      value: department,
                      child: Text(department),
                    ),
                  ),
                ],
                onChanged: (value) =>
                    setState(() => _department = value as String?),
              ),
              const SizedBox(height: 16),
              CustomDropDownButton(
                label: 'Owning Status',
                value: _status,
                items: const [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text('Any status'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'owner',
                    child: Text('Owner'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'contributor',
                    child: Text('Contributor'),
                  ),
                ],
                onChanged: (value) =>
                    setState(() => _status = value as String?),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onReset();
            Navigator.pop(context);
          },
          child: const Text('Reset'),
        ),
        CustomElevatedButton(
          text: 'Apply',
          onPressed: () {
            widget.onApply(_date, _department, _status);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
