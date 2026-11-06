import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/utils.dart';
import '../bottom_sheet_box.dart';
import 'input_styles.dart';

class SelectOption<T> {
  const SelectOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
  });

  final T value;
  final String label;
  final String? subtitle;
  final IconData? icon;
}

/// Select field that adapts to the list size:
/// up to [inlineLimit] items opens an inline dropdown; more opens a
/// searchable bottom sheet.
class AppSelectDropdown<T> extends StatelessWidget {
  const AppSelectDropdown({
    super.key,
    this.label,
    this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.isRequired = false,
    this.enabled = true,
    this.prefixIcon,
    this.validator,
    this.inlineLimit = 5,
  });

  final String? label;
  final String? hintText;
  final List<SelectOption<T>> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final bool isRequired;
  final bool enabled;
  final IconData? prefixIcon;
  final FormFieldValidator<T>? validator;
  final int inlineLimit;

  SelectOption<T>? get _selected {
    for (final item in items) {
      if (item.value == selectedValue) return item;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final styles = InputStyles.of(context);
    final hint = hintText ?? AppLocalizations.of(context).selectOption;
    final prefix = prefixIcon == null
        ? null
        : Icon(prefixIcon, size: 20, color: styles.hint);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) InputLabel(label!, isRequired: isRequired),
        if (items.length <= inlineLimit)
          DropdownButtonFormField<T>(
            key: ValueKey(selectedValue),
            initialValue: selectedValue,
            isExpanded: true,
            dropdownColor: styles.isDark ? AppColors.darkCard : AppColors.surface,
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: styles.hint),
            style: styles.textStyle,
            decoration: styles.decoration(hintText: hint, prefixIcon: prefix),
            validator: validator,
            onChanged: enabled ? onChanged : null,
            items: [
              for (final option in items)
                DropdownMenuItem<T>(
                  value: option.value,
                  child: Row(
                    children: [
                      if (option.icon != null) ...[
                        Icon(option.icon, size: 18, color: styles.accent),
                        const SizedBox(width: AppConstants.spacingS),
                      ],
                      Flexible(
                        child: Text(option.label, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
            ],
          )
        else
          FormField<T>(
            key: ValueKey(selectedValue),
            initialValue: selectedValue,
            validator: validator,
            builder: (field) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  onTap: enabled ? () => _openSheet(context, field) : null,
                  child: Container(
                    padding: InputStyles.contentPadding,
                    decoration: styles.box(hasError: field.hasError),
                    child: Row(
                      children: [
                        if (prefix != null) ...[
                          prefix,
                          const SizedBox(width: AppConstants.spacingM),
                        ],
                        Expanded(
                          child: Text(
                            _selected?.label ?? hint,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _selected == null
                                ? styles.hintStyle
                                : styles.textStyle,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down_rounded,
                            color: styles.hint),
                      ],
                    ),
                  ),
                ),
                if (field.hasError) InputErrorText(field.errorText!),
              ],
            ),
          ),
      ],
    );
  }

  void _openSheet(BuildContext context, FormFieldState<T> field) {
    BottomSheetBox.show<void>(
      context: context,
      title: label ?? hintText ?? AppLocalizations.of(context).selectOption,
      initialChildSize: 0.55,
      child: _OptionList<T>(
        items: items,
        selectedValue: selectedValue,
        onSelected: (value) {
          Navigator.of(context).pop();
          field.didChange(value);
          onChanged(value);
        },
      ),
    );
  }
}

class _OptionList<T> extends StatefulWidget {
  const _OptionList({
    required this.items,
    required this.selectedValue,
    required this.onSelected,
  });

  final List<SelectOption<T>> items;
  final T? selectedValue;
  final ValueChanged<T> onSelected;

  @override
  State<_OptionList<T>> createState() => _OptionListState<T>();
}

class _OptionListState<T> extends State<_OptionList<T>> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final styles = InputStyles.of(context);
    final query = _query.toLowerCase();
    final filtered = widget.items.where((item) {
      return query.isEmpty ||
          item.label.toLowerCase().contains(query) ||
          (item.subtitle?.toLowerCase().contains(query) ?? false);
    }).toList();

    return Column(
      children: [
        const SizedBox(height: AppConstants.spacingM),
        TextField(
          onChanged: (value) => setState(() => _query = value),
          style: styles.textStyle,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).search,
            hintStyle: styles.hintStyle,
            prefixIcon: Icon(Icons.search_rounded, size: 20, color: styles.hint),
            filled: true,
            fillColor: styles.fillMuted,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppConstants.spacingM,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingS),
        for (final option in filtered)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingXS,
            ),
            leading: option.icon == null
                ? null
                : Icon(option.icon, color: styles.accent),
            title: Text(
              option.label,
              style: AppConstants.body.copyWith(
                color: styles.text,
                fontWeight: option.value == widget.selectedValue
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            subtitle: option.subtitle == null
                ? null
                : Text(
                    option.subtitle!,
                    style: AppConstants.bodySmall.copyWith(color: styles.hint),
                  ),
            trailing: option.value == widget.selectedValue
                ? Icon(Icons.check_circle_rounded, color: styles.accent)
                : null,
            onTap: () => widget.onSelected(option.value),
          ),
        const SizedBox(height: AppConstants.spacingL),
      ],
    );
  }
}
