import '../../data/models/task_board_model.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeEmpty extends HomeState {}

final class HomeError extends HomeState {
  HomeError(this.message);

  final String message;
}

final class HomeSuccess extends HomeState {
  HomeSuccess({
    required this.allBoards,
    required this.visibleBoards,
    required this.departmentCounts,
    this.selectedDepartment,
    this.searchQuery = '',
    this.creationDate,
    this.ownershipStatus,
  });

  final List<TaskBoardModel> allBoards;
  final List<TaskBoardModel> visibleBoards;
  final Map<String, int> departmentCounts;
  final String? selectedDepartment;
  final String searchQuery;
  final DateTime? creationDate;
  final String? ownershipStatus;

  HomeSuccess copyWith({
    List<TaskBoardModel>? visibleBoards,
    Map<String, int>? departmentCounts,
    String? selectedDepartment,
    bool clearDepartment = false,
    String? searchQuery,
    DateTime? creationDate,
    String? ownershipStatus,
    bool clearCreationDate = false,
    bool clearOwnershipStatus = false,
  }) {
    return HomeSuccess(
      allBoards: allBoards,
      visibleBoards: visibleBoards ?? this.visibleBoards,
      departmentCounts: departmentCounts ?? this.departmentCounts,
      selectedDepartment: clearDepartment
          ? null
          : selectedDepartment ?? this.selectedDepartment,
      searchQuery: searchQuery ?? this.searchQuery,
      creationDate: clearCreationDate
          ? null
          : creationDate ?? this.creationDate,
      ownershipStatus: clearOwnershipStatus
          ? null
          : ownershipStatus ?? this.ownershipStatus,
    );
  }
}
