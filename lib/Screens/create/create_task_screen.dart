import 'dart:async';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inSTA/navigation/navigation_utils.dart';
import 'package:inSTA/network/models/todo/task.dart';

import '../../constants/margin.dart';
import '../../extensions/state_extensions.dart';
import '../../firebase/services/data_service.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/router_configs.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../theme/theme_utils.dart';
import '../../utilities/print_util.dart';
import '../bottom_sheets/bottomsheet_emoji_picker.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({this.routeObject, super.key});

  final CreateTaskScreenRouteObject? routeObject;

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> with SingleTickerProviderStateMixin {
  late final _localizations = AppLocalizations.of(context)!;

  late ThemeProvider theme;

  final _dataService = DataService.instance;

  String? get docId => widget.routeObject?.docId;

  Task? get task => widget.routeObject?.task;

  bool get isEditFlow => docId != null && task != null;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emojiController = EmojiPickerController();

  String? _selectedCategory;
  String? _selectedEmoji;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialiseAnimation();
    _initialiseData();
  }

  void _initialiseAnimation() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward();
  }

  void _initialiseData() {
    if (isEditFlow) {
      _titleController.text = task!.title;
      _descriptionController.text = task!.description;
      _selectedCategory = task!.category;
      _selectedEmoji = task!.emoji;
    }
  }

  final List<String> _categories = ['UI/UX', 'Functionality', 'Performance', 'Security', 'Integration', 'Other'];

  @override
  void dispose() {
    _animationController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _emojiController.dispose();
    super.dispose();
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    refresh;
  }

  @override
  Widget build(BuildContext context) {
    theme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: theme.themeData?.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.themeData?.scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(FluentIcons.dismiss_24_regular, color: theme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Todo', style: theme.ts.extTs18.weightBold),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _taskIcon,
                  Margin.vertical32,
                  _buildTitleField,
                  Margin.vertical32,
                  _buildDescriptionField,
                  Margin.vertical32,
                  _buildCategorySection,
                  Margin.vertical40,
                  _buildSubmitButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle get _headingTextStyle => theme.ts.extTs14.weightBold;

  Widget get _taskIcon {
    return InkWell(
      //child: Assets.svg.iconEmoji.svg(width: 18, height: 18, colorFilter: ColorFilter.mode(_theme.actionIconColor, BlendMode.srcIn)),
      child: Row(
        children: [
          Expanded(child: Text(_localizations.addIconToTask, style: _headingTextStyle)),
          Margin.horizontal8,
          _selectedEmoji != null
              ? Text(_selectedEmoji!, style: theme.ts.copyWith(fontSize: 28))
              : Icon(FluentIcons.emoji_16_regular, size: 28, color: theme.actionIconColor),
        ],
      ),
      onTap: () {
        BottomSheetEmojiPicker.show(
          context,
          onEmojiSelected: (category, emoji) {
            final selectedEmoji = emoji.emoji;
            PrintUtils.instance.printLog('Emoji Selected: $emoji');
            _selectedEmoji = selectedEmoji;
            refresh;
          },
        );
      },
    );
  }

  Widget _buildCommonField({
    required String title,
    required String hintText,
    required String infoNoteText,
    required int maxLength,
    required int maxLines,
    required String? Function(String?)? validator,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _headingTextStyle),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: theme.textColor.withValues(alpha: 0.4)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.textColor.withValues(alpha: 0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.textColor.withValues(alpha: 0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.getBottomSheetActionColor(true), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: theme.textFieldColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          style: theme.ts.extTs16,
          maxLines: maxLines,
          maxLength: maxLength,
          validator: validator,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text('💡', style: theme.ts.extTs12),
            const SizedBox(width: 6),
            Expanded(
              child: Text(infoNoteText, style: theme.ts.extTs12.copyWith(color: theme.textColor.withValues(alpha: 0.6), height: 1.4)),
            ),
          ],
        ),
      ],
    );
  }

  Widget get _buildTitleField {
    final title = 'Enter Title';
    final validator = (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Please enter a title';
      }
      if (value.trim().length < 5) {
        return 'Title must be at least 5 characters';
      }
      return null;
    };

    return _buildCommonField(
      title: title,
      hintText: title,
      infoNoteText: 'Add short and precise title for the feature.',
      maxLength: 100,
      maxLines: 1,
      validator: validator,
      controller: _titleController,
    );
  }

  Widget get _buildDescriptionField {
    final title = 'Enter Description';
    final validator = (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Please enter a description';
      }
      if (value.trim().length < 20) {
        return 'Description must be at least 20 characters';
      }
      return null;
    };

    return _buildCommonField(
      title: title,
      hintText: title,
      infoNoteText: 'Explain the key aspects of it with short details.',
      maxLength: 1000,
      maxLines: 6,
      validator: validator,
      controller: _descriptionController,
    );
  }

  Widget get _buildCategorySection {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category (Optional)', style: theme.ts.extTs14.weightBold.copyWith(color: theme.textColor.withValues(alpha: 0.8))),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _categories.map((category) {
            final isSelected = _selectedCategory == category;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCategory = isSelected ? null : category;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      ///gradient: isSelected ? LinearGradient(colors: [theme.getBottomSheetActionColor(true), theme.getBottomSheetActionColor(true)]) : null,
                      color: isSelected ? theme.primaryColor : theme.themeColorGrey,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSelected ? Colors.transparent : theme.textColor.withValues(alpha: 0.15), width: 1.5),
                      boxShadow: isSelected
                          ? [BoxShadow(color: theme.getBottomSheetActionColor(true).withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2))]
                          : null,
                    ),
                    child: Text(
                      category,
                      style: theme.ts.extTs13.copyWith(
                        color: isSelected ? Colors.white : theme.textColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget get _buildSubmitButton {
    return _isLoading
        ? Center(
            child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
          )
        : SizedBox(
            width: double.infinity,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _isLoading ? null : _submitFeatureRequest,
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [theme.primaryColor, theme.primaryColor]),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: theme.getBottomSheetActionColor(false).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: Text(
                    'Add',
                    textAlign: TextAlign.center,
                    style: theme.ts.extTs16.weightBold.copyWith(color: Colors.white, letterSpacing: 0.5),
                  ),
                ),
              ),
            ),
          );
  }

  Future<void> _submitFeatureRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _setLoadingState(true);

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (isEditFlow) {
      task!.update(title: title, description: description, category: _selectedCategory, emoji: _selectedEmoji);
      _dataService.updateTask(docId: docId!, task: task!);
    } else {
      final task = Task.newTask(title: title, description: description, category: _selectedCategory, emoji: _selectedEmoji);
      _dataService.addTask(task);
    }

    Timer.periodic(const Duration(seconds: 1), (_timer) {
      _timer.cancel();
      _setLoadingState(false);
      NavigationUtils.instance.pop(context: context);
    });
  }
}
