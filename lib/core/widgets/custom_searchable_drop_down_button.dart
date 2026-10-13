import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../locale/app_locale.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/app_text_styles.dart';

class CustomSearchableDropDownButton<T> extends StatefulWidget {
  const CustomSearchableDropDownButton({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.labelStyle,
    this.validator,
    required this.value,
    this.enabled = true,
    this.searchHint = 'Search...',
    this.itemLabelBuilder,
  });

  final String label;
  final TextStyle? labelStyle;
  final List<DropdownMenuItem<T>>? items;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final T? value;
  final bool enabled;
  final String searchHint;
  final String Function(T)? itemLabelBuilder;

  @override
  State<CustomSearchableDropDownButton<T>> createState() =>
      _CustomSearchableDropDownButtonState<T>();
}

class _CustomSearchableDropDownButtonState<T>
    extends State<CustomSearchableDropDownButton<T>> {
  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  List<DropdownMenuItem<T>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items ?? [];
  }

  @override
  void didUpdateWidget(CustomSearchableDropDownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _filteredItems = widget.items ?? [];
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOpen = false;
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {});
  }

  void _showOverlay() {
    _searchController.clear();
    _filteredItems = widget.items ?? [];

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
            child: StatefulBuilder(
              builder: (context, setStateOverlay) {
                return Container(
                  constraints: BoxConstraints(maxHeight: 300.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.lightGrey, width: 0.5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: widget.searchHint,
                            hintStyle: CustomTextStyle.font400sized14Black
                                .copyWith(color: AppColors.lightGrey),
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.lightGrey,
                                width: 0.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.lightGrey,
                                width: 0.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.lightGrey,
                                width: 0.5,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                          ),
                          onChanged: (query) {
                            setStateOverlay(() {
                              _filterItems(query);
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: _filteredItems.isEmpty
                            ? Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Text(
                                  AppStrings.noDataFound.tr(context),
                                  style: CustomTextStyle.font400sized14Black
                                      .copyWith(color: AppColors.lightGrey),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: _filteredItems.length,
                                itemBuilder: (context, index) {
                                  final item = _filteredItems[index];
                                  final isSelected = item.value == widget.value;
                                  return InkWell(
                                    onTap: () {
                                      widget.onChanged?.call(item.value);
                                      _removeOverlay();
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 12.h,
                                      ),
                                      color: isSelected
                                          ? AppColors.lightGrey.withOpacity(0.2)
                                          : null,
                                      child: item.child,
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isOpen = true;
  }

  void _filterItems(String query) {
    if (query.isEmpty) {
      _filteredItems = widget.items ?? [];
    } else {
      _filteredItems = (widget.items ?? []).where((item) {
        final itemText = _getItemText(item);
        return itemText.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  String _getItemText(DropdownMenuItem<T> item) {
    if (widget.itemLabelBuilder != null && item.value != null) {
      return widget.itemLabelBuilder!(item.value as T);
    }
    if (item.child is Text) {
      return (item.child as Text).data ?? '';
    }
    return item.value?.toString() ?? '';
  }

  String _getSelectedText() {
    if (widget.value == null) return widget.label;
    final selectedItem = widget.items?.firstWhere(
      (item) => item.value == widget.value,
      orElse: () => DropdownMenuItem<T>(value: null, child: Text(widget.label)),
    );
    if (selectedItem != null) {
      return _getItemText(selectedItem);
    }
    return widget.label;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: widget.validator,
      initialValue: widget.value,
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompositedTransformTarget(
              link: _layerLink,
              child: GestureDetector(
                onTap: _toggleDropdown,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: formFieldState.hasError
                          ? Colors.red
                          : AppColors.lightGrey,
                      width: 0.5.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getSelectedText(),
                          style: widget.value == null
                              ? CustomTextStyle.font400sized14Black
                              : CustomTextStyle.font400sized14Black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        _isOpen
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_outlined,
                        color: widget.enabled ? null : AppColors.lightGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (formFieldState.hasError)
              Padding(
                padding: EdgeInsets.only(top: 8.h, left: 12.w),
                child: Text(
                  formFieldState.errorText ?? '',
                  style: TextStyle(color: Colors.red, fontSize: 12.sp),
                ),
              ),
          ],
        );
      },
    );
  }
}
