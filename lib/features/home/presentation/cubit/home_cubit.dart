import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/task_board_model.dart';
import '../../data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo) : super(HomeInitial());

  final HomeRepo _repo;

  Future<void> loadBoards() async {
    emit(HomeLoading());
    try {
      final boards = await _repo.getTaskBoards();
      if (boards.isEmpty) {
        emit(HomeEmpty());
        return;
      }
      emit(_buildSuccess(boards));
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }

  Future<void> addBoard(TaskBoardModel board) async {
    await _repo.addTaskBoard(board);
    await loadBoards();
  }

  void updateSearch(String value) {
    final current = state;
    if (current is! HomeSuccess) return;

    emit(_filterState(current, searchQuery: value.trim()));
  }

  void selectDepartment(String? department) {
    final current = state;
    if (current is! HomeSuccess) return;

    if (department == null || department == 'All') {
      emit(_filterState(current, clearDepartment: true));
      return;
    }
    emit(_filterState(current, selectedDepartment: department));
  }

  void applyFilters({
    DateTime? creationDate,
    String? ownershipStatus,
    bool clearCreationDate = false,
    bool clearOwnershipStatus = false,
  }) {
    final current = state;
    if (current is! HomeSuccess) return;

    emit(
      _filterState(
        current,
        creationDate: creationDate,
        ownershipStatus: ownershipStatus,
        clearCreationDate: clearCreationDate,
        clearOwnershipStatus: clearOwnershipStatus,
      ),
    );
  }

  void resetFilters() {
    final current = state;
    if (current is! HomeSuccess) return;

    emit(
      _filterState(
        current,
        clearDepartment: true,
        clearCreationDate: true,
        clearOwnershipStatus: true,
      ),
    );
  }

  HomeSuccess _buildSuccess(List<TaskBoardModel> boards) {
    final counts = <String, int>{};
    for (final board in boards) {
      counts.update(board.department, (value) => value + 1, ifAbsent: () => 1);
    }
    return HomeSuccess(
      allBoards: boards,
      visibleBoards: boards,
      departmentCounts: counts,
    );
  }

  HomeSuccess _filterState(
    HomeSuccess current, {
    String? selectedDepartment,
    bool clearDepartment = false,
    String? searchQuery,
    DateTime? creationDate,
    String? ownershipStatus,
    bool clearCreationDate = false,
    bool clearOwnershipStatus = false,
  }) {
    final department = clearDepartment
        ? null
        : selectedDepartment ?? current.selectedDepartment;
    final query = searchQuery ?? current.searchQuery;
    final date = clearCreationDate
        ? null
        : creationDate ?? current.creationDate;
    final status = clearOwnershipStatus
        ? null
        : ownershipStatus ?? current.ownershipStatus;
    final visibleBoards = current.allBoards.where((board) {
      final matchesDepartment =
          department == null || board.department == department;
      final matchesSearch = board.name.toLowerCase().contains(
        query.toLowerCase(),
      );
      final matchesDate =
          date == null ||
          (board.createdAt.year == date.year &&
              board.createdAt.month == date.month &&
              board.createdAt.day == date.day);
      final matchesStatus = status == null || board.ownershipStatus == status;
      return matchesDepartment && matchesSearch && matchesDate && matchesStatus;
    }).toList();

    return current.copyWith(
      visibleBoards: visibleBoards,
      selectedDepartment: department,
      clearDepartment: clearDepartment,
      searchQuery: query,
      creationDate: date,
      ownershipStatus: status,
      clearCreationDate: clearCreationDate,
      clearOwnershipStatus: clearOwnershipStatus,
    );
  }
}
