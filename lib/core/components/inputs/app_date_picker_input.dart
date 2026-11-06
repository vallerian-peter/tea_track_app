import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/utils.dart';
import 'input_styles.dart';

/// Tap-to-pick date field. Works inside a [Form] through [validator].
class AppDatePickerInput extends StatelessWidget {
  const AppDatePickerInput({
    super.key,
    this.label,
    this.hintText,
    required this.selectedDate,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
    this.dateFormat = 'dd/MM/yyyy',
    this.isRequired = false,
    this.enabled = true,
    this.allowClear = true,
    this.validator,
  });

  final String? label;
  final String? hintText;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String dateFormat;
  final bool isRequired;
  final bool enabled;
  final bool allowClear;
  final FormFieldValidator<DateTime>? validator;

  Future<void> _pick(BuildContext context, FormFieldState<DateTime> field) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );
    if (picked == null) return;
    field.didChange(picked);
    onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final styles = InputStyles.of(context);
    final hint = hintText ?? AppLocalizations.of(context).selectDate;
    final text = selectedDate == null
        ? null
        : DateFormat(dateFormat).format(selectedDate!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) InputLabel(label!, isRequired: isRequired),
        FormField<DateTime>(
          key: ValueKey(selectedDate),
          initialValue: selectedDate,
          validator: validator,
          builder: (field) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
                onTap: enabled ? () => _pick(context, field) : null,
                child: Container(
                  padding: InputStyles.contentPadding,
                  decoration: styles.box(hasError: field.hasError),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 19,
                        color: text == null ? styles.hint : styles.accent,
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      Expanded(
                        child: Text(
                          text ?? hint,
                          style: text == null
                              ? styles.hintStyle
                              : styles.textStyle,
                        ),
                      ),
                      if (text != null && enabled && allowClear)
                        GestureDetector(
                          onTap: () {
                            field.didChange(null);
                            onChanged(null);
                          },
                          child: Icon(
                            Icons.cancel_rounded,
                            size: 18,
                            color: styles.hint,
                          ),
                        ),
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
}
