import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_drop_down_button.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/models/task_board_model.dart';
import '../cubit/home_cubit.dart';

class AddBoardDialog extends StatefulWidget {
  const AddBoardDialog({required this.departments, super.key});

  final List<String> departments;

  @override
  State<AddBoardDialog> createState() => _AddBoardDialogState();
}

class _AddBoardDialogState extends State<AddBoardDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageLinksController = TextEditingController();
  final _membersCountController = TextEditingController(text: '1');

  String? _department;
  String _ownershipStatus = 'owner';
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageLinksController.dispose();
    _membersCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Board'),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: _nameController,
                  labelText: 'Board Name',
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 12),
                CustomDropDownButton(
                  label: 'Department',
                  value: _department,
                  items: widget.departments
                      .map(
                        (department) => DropdownMenuItem<String>(
                          value: department,
                          child: Text(department),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => _department = value),
                  validator: (value) =>
                      value == null ? 'Department is required' : null,
                ),
                const SizedBox(height: 12),
                CustomDropDownButton(
                  label: 'Owning Status',
                  value: _ownershipStatus,
                  items: const [
                    DropdownMenuItem(value: 'owner', child: Text('Owner')),
                    DropdownMenuItem(
                      value: 'contributor',
                      child: Text('Contributor'),
                    ),
                  ],
                  onChanged: (value) =>
                      setState(() => _ownershipStatus = value as String),
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  controller: _descriptionController,
                  labelText: 'Description',
                  maxLines: 3,
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  controller: _imageLinksController,
                  labelText: 'Member Image Links',
                  hintText: 'One URL per line (optional)',
                  maxLines: 3,
                  validator: _imageLinksValidator,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  controller: _membersCountController,
                  labelText: 'Total Members',
                  keyboardType: TextInputType.number,
                  validator: _membersCountValidator,
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        SizedBox(
          width: 150,
          child: CustomElevatedButton(
            text: _isSaving ? 'Saving...' : 'Create Board',
            onPressed: _isSaving ? null : _submit,
            borderRadius: 8,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final imageUrls = _imageLinksController.text
        .split(RegExp(r'[\n,]'))
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList();
    final board = TaskBoardModel(
      id: '',
      name: _nameController.text,
      department: _department!,
      ownershipStatus: _ownershipStatus,
      description: _descriptionController.text,
      createdAt: DateTime.now(),
      memberImageUrls: imageUrls,
      membersCount: int.parse(_membersCountController.text),
      createdBy: '',
    );

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      await context.read<HomeCubit>().addBoard(board);
      if (!mounted) return;
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Board created successfully')),
      );
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _errorMessage = error.toString();
      });
    }
  }

  String? _requiredValidator(String? value) {
    return value == null || value.trim().isEmpty ? 'Required field' : null;
  }

  String? _imageLinksValidator(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final links = value.split(RegExp(r'[\n,]')).map((item) => item.trim());
    for (final link in links) {
      final uri = Uri.tryParse(link);
      if (uri == null || !uri.hasAbsolutePath || !uri.hasScheme) {
        return 'Enter valid image URLs';
      }
    }
    return null;
  }

  String? _membersCountValidator(String? value) {
    final count = int.tryParse(value ?? '');
    final links = _imageLinksController.text
        .split(RegExp(r'[\n,]'))
        .where((item) => item.trim().isNotEmpty)
        .length;
    if (count == null || count < 1) return 'Enter a valid members count';
    if (count < links) return 'Count cannot be less than image links';
    return null;
  }
}
