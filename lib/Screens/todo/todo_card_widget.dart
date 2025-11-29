import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/state_extensions.dart';
import '../../firebase/services/data_service.dart';
import '../../network/models/todo/task.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../theme/theme_utils.dart';

class ToDoCardWidget extends ConsumerStatefulWidget {
  const ToDoCardWidget({required this.docId, required this.task, this.onTap, super.key});

  final String docId;
  final Task task;
  final VoidCallback? onTap;

  @override
  ConsumerState<ToDoCardWidget> createState() => _ToDoCardWidgetState();
}

class _ToDoCardWidgetState extends ConsumerState<ToDoCardWidget> with SingleTickerProviderStateMixin {
  late ThemeProvider theme;

  final _dataService = DataService.instance;

  late AnimationController _scaleController;
  bool _isPressed = false;

  String get docId => widget.docId;

  Task get task => widget.task;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _changePressState(bool isPressed) {
    _isPressed = isPressed;
    refresh;
    if (_isPressed) {
      _scaleController.forward();
    } else {
      _scaleController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = ref.watch(themeProvider);

    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.98).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          onTapDown: (_) {
            _changePressState(true);
          },
          onTapUp: (_) {
            _changePressState(false);
          },
          onTapCancel: () {
            _changePressState(false);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.themeData?.cardTheme.color,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.textColor.withValues(alpha: 0.08), width: 1),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: theme.getBottomSheetActionColor(true)?.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: task.emoji != null
                                    ? Text(task.emoji!, style: theme.ts.extTs16.weightBold)
                                    : Icon(FluentIcons.lightbulb_24_filled, size: 16, color: theme.getBottomSheetActionColor(true)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(task.title, style: theme.ts.extTs16.weightBold, maxLines: 2, overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildStatusBadge,
                  ],
                ),

                const SizedBox(height: 12),
                Text(
                  task.description,
                  style: theme.ts.extTs14.copyWith(color: theme.textColor.withValues(alpha: 0.7), height: 1.5),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: theme.getBottomSheetActionColor(true)?.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(FluentIcons.person_48_regular, size: 16, color: theme.getBottomSheetActionColor(true)),
                          const SizedBox(width: 6),
                          Text(
                            '${task.userCount}',
                            style: theme.ts.extTs12.copyWith(color: theme.getBottomSheetActionColor(true), fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (task.category != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.getBottomSheetActionColor(true).withValues(alpha: 0.15) ?? Colors.blue.withValues(alpha: 0.15),
                              theme.getBottomSheetActionColor(true).withValues(alpha: 0.08) ?? Colors.blue.withValues(alpha: 0.08),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.getBottomSheetActionColor(true).withValues(alpha: 0.3) ?? Colors.blue.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(FluentIcons.tag_24_regular, size: 12, color: theme.getBottomSheetActionColor(true)),
                            const SizedBox(width: 4),
                            Text(
                              task.category!,
                              style: theme.ts.extTs10.copyWith(color: theme.getBottomSheetActionColor(true), fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildStatusBadge {
    final taskStatus = task.taskStatus;
    final color = taskStatus.color;

    return InkWell(
      onTap: () {
        task.toggleCompleted();
        _dataService.updateToDo(docId: docId, task: task);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.08)]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(taskStatus.icon, size: 12, color: color),
            const SizedBox(width: 4),
            Text(
              taskStatus.label,
              style: theme.ts.extTs10.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
