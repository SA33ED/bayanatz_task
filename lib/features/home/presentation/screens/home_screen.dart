import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/repo/home_repo.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/add_board_dialog.dart';
import '../widgets/task_board_card.dart';
import '../widgets/task_board_filter_dialog.dart';
import '../widgets/task_category_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _defaultDepartments = <String>[
    'Marketing',
    'Software',
    'Finance',
    'Research and Development',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(sl<HomeRepo>())..loadBoards(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 948 ? 30.0 : 16.0;
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 948),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 24,
                  ),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return _buildContent(context, state);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, HomeState state) {
    if (state is HomeLoading || state is HomeInitial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is HomeError) {
      return _StateMessage(
        message: state.message,
        actionLabel: 'Retry',
        onAction: context.read<HomeCubit>().loadBoards,
      );
    }

    final success = state is HomeSuccess ? state : null;
    final boards = success?.visibleBoards ?? const [];
    final departments =
        success?.departmentCounts.keys.toList() ??
        HomeScreen._defaultDepartments;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Task Management',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D2D2D),
                ),
              ),
            ),
            const SizedBox(width: 15),
            _HeaderButton(
              label: 'Create Board',
              icon: Icons.description_outlined,
              width: 150,
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<HomeCubit>(),
                  child: AddBoardDialog(departments: departments),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        if (success != null)
          TaskCategoryBar(
            counts: success.departmentCounts,
            selectedDepartment: success.selectedDepartment,
            onSelected: context.read<HomeCubit>().selectDepartment,
          ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
                borderRadius: 8,
                maxLines: 1,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                onChanged: context.read<HomeCubit>().updateSearch,
              ),
            ),
            const SizedBox(width: 15),
            _HeaderButton(
              label: 'Filter',
              icon: Icons.tune,
              onPressed: success == null
                  ? null
                  : () => showDialog<void>(
                      context: context,
                      builder: (_) => TaskBoardFilterDialog(
                        departments: departments,
                        initialDate: success.creationDate,
                        initialDepartment: success.selectedDepartment,
                        initialOwnershipStatus: success.ownershipStatus,
                        onApply: (date, department, status) {
                          context.read<HomeCubit>().selectDepartment(
                            department,
                          );
                          context.read<HomeCubit>().applyFilters(
                            creationDate: date,
                            ownershipStatus: status,
                            clearCreationDate: date == null,
                            clearOwnershipStatus: status == null,
                          );
                        },
                        onReset: context.read<HomeCubit>().resetFilters,
                      ),
                    ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        if (state is HomeEmpty)
          _StateMessage(
            message: 'No boards found yet.',
            actionLabel: 'Create Board',
            onAction: () => showDialog<void>(
              context: context,
              builder: (_) => BlocProvider.value(
                value: context.read<HomeCubit>(),
                child: const AddBoardDialog(
                  departments: HomeScreen._defaultDepartments,
                ),
              ),
            ),
          )
        else if (boards.isEmpty)
          const _StateMessage(message: 'No boards match your search.')
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: boards.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 286,
              mainAxisExtent: 164,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (_, index) => TaskBoardCard(board: boards[index]),
          ),
      ],
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.width,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 38,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9E9E9E),
          foregroundColor: const Color(0xFF2D2D2D),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class _StateMessage extends StatelessWidget {
  const _StateMessage({required this.message, this.actionLabel, this.onAction});

  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
