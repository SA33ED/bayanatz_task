// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_text_styles.dart';

// class CustomSnackbar {
//   static void show(
//     BuildContext context,
//     String message, {
//     IconData? icon,
//     ToastStates state = ToastStates.success,
//   }) {
//     final overlay = Overlay.of(context);
//     late OverlayEntry overlayEntry;

//     overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: MediaQuery.of(context).padding.top + 20,
//         left: 10,
//         right: 10,
//         child: Material(
//           color: Colors.transparent,
//           child: Dismissible(
//             key: const ValueKey("dismiss_snackbar"),
//             direction: DismissDirection.horizontal,
//             onDismissed: (direction) {
//               overlayEntry.remove(); // Now overlayEntry is correctly referenced
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                 vertical: 16.h,
//                 horizontal: 20.w,
//               ),
//               decoration: BoxDecoration(
//                 color: getState(context, state),
//                 borderRadius: BorderRadius.circular(10.r),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 6.0,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//                 border: Border.all(color: AppColors.primary, width: 1.5),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   if (icon != null) Icon(icon, color: Colors.white, size: 26),
//                   Expanded(
//                     child: Text(
//                       message,
//                       textAlign: TextAlign.center,
//                       style: CustomTextStyle.font500sized16White.copyWith(
//                         color: AppColors.primary,
//                         overflow: TextOverflow.fade,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);

//     // Automatically remove after 3 seconds if not swiped
//     Future.delayed(const Duration(seconds: 2), () {
//       if (overlayEntry.mounted) {
//         overlayEntry.remove();
//       }
//     });
//   }
// }

// void showToast({
//   required BuildContext context,
//   required String message,
//   ToastStates? state,
//   IconData? icon,
// }) {
//   CustomSnackbar.show(
//     context,
//     message,
//     state: state ?? ToastStates.success,
//     icon: icon,
//   );
// }

// enum ToastStates { error, success, warning }

// Color getState(BuildContext context, ToastStates state) {
//   switch (state) {
//     case ToastStates.error:
//       return Colors.red;
//     case ToastStates.success:
//       return AppColors.white;
//     case ToastStates.warning:
//       return Colors.orange;
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

void showToast({
  required BuildContext context,
  required String message,
  required ToastStates state,
  Duration duration = const Duration(seconds: 3),
}) {
  late OverlayEntry toast;

  toast = OverlayEntry(
    builder: (context) => _ToastOverlay(
      message: message,
      state: state,
      duration: duration,
      onDismiss: () {
        toast.remove();
      },
    ),
  );

  Overlay.of(context).insert(toast);
}

class _ToastOverlay extends StatefulWidget {
  final String message;
  final ToastStates state;
  final Duration duration;
  final VoidCallback onDismiss;

  const _ToastOverlay({
    required this.message,
    required this.state,
    required this.duration,
    required this.onDismiss,
  });

  @override
  _ToastOverlayState createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isDismissing = false;

  double _dragOffsetX = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, -1),
          end: const Offset(0, 0.1),
        ),
        weight: 75,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: const Offset(0, 0),
        ),
        weight: 25,
      ),
    ]).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();

    Future.delayed(widget.duration, () {
      if (mounted && !_isDismissing) {
        _dismissToast();
      }
    });
  }

  void _dismissToast() {
    if (_isDismissing) return;
    _isDismissing = true;
    _animationController.reverse().then((_) {
      if (mounted) widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          top: 50.h,
          left: 16.w + _dragOffsetX,
          right: 16.w - _dragOffsetX,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    _dismissToast();
                  }
                },
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _dragOffsetX += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  // Swipe threshold to dismiss
                  if (_dragOffsetX.abs() > 100) {
                    _dismissToast();
                  } else {
                    // Animate back to center if not enough swipe
                    setState(() => _dragOffsetX = 0);
                  }
                },
                child: Transform.translate(
                  offset: Offset(_dragOffsetX, 0),
                  child: Opacity(
                    opacity: (1 - (_dragOffsetX.abs() / 200)).clamp(0.4, 1.0),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: _getStateColor(widget.state),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                              spreadRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _getStateColor(widget.state)
                                    .withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getIconForState(widget.state),
                                color: _getStateColor(widget.state),
                                size: 20.h,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                widget.message,
                                style: CustomTextStyle.font400sized16Black,
                                overflow: TextOverflow.clip,
                                maxLines: 3,
                              ),
                            ),
                            GestureDetector(
                              onTap: _dismissToast,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 16.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForState(ToastStates state) {
    switch (state) {
      case ToastStates.success:
        return Icons.check_circle;
      case ToastStates.error:
        return Icons.error;
      case ToastStates.warning:
        return Icons.warning_amber;
      case ToastStates.info:
        return Icons.info;
    }
  }

  Color _getStateColor(ToastStates state) {
    switch (state) {
      case ToastStates.success:
        return AppColors.primary;
      case ToastStates.error:
        return Colors.red;
      case ToastStates.warning:
        return Colors.amber;
      case ToastStates.info:
        return Colors.blue;
    }
  }
}

enum ToastStates {
  success,
  error,
  warning,
  info,
}
