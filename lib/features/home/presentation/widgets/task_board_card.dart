import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_assets.dart';
import '../../data/models/task_board_model.dart';

class TaskBoardCard extends StatelessWidget {
  const TaskBoardCard({required this.board, super.key});

  final TaskBoardModel board;

  @override
  Widget build(BuildContext context) {
    final remainingMembers = board.membersCount - board.memberImageUrls.length;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  size: 20,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  board.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _StatusBadge(status: board.ownershipStatus),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: Text(
              'Department: ${board.department}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 12,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            board.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Jost',
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.4),
              height: 1.35,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Creation Date: ${_formatDate(board.createdAt)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 10,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ),
              _MemberAvatars(
                imageUrls: board.memberImageUrls,
                remainingMembers: remainingMembers,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} '
        '${_monthName(date.month)} ${date.year}';
  }

  String _monthName(int month) {
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFBDBDBD),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        status == 'contributor' ? 'Contributor' : 'Owner',
        style: const TextStyle(
          fontFamily: 'Jost',
          fontSize: 10,
          color: Color(0xFF2D2D2D),
        ),
      ),
    );
  }
}

class _MemberAvatars extends StatelessWidget {
  const _MemberAvatars({
    required this.imageUrls,
    required this.remainingMembers,
  });

  final List<String> imageUrls;
  final int remainingMembers;

  @override
  Widget build(BuildContext context) {
    final visibleImages = imageUrls.take(3).toList();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final imageUrl in visibleImages)
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: CircleAvatar(
              radius: 11,
              backgroundColor: AppColors.offWhite,
              backgroundImage: imageUrl.isEmpty
                  ? const AssetImage(Assets.imagesPngProfile)
                  : NetworkImage(imageUrl),
            ),
          ),
        if (remainingMembers > 0)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              '+$remainingMembers',
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 12,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
      ],
    );
  }
}
