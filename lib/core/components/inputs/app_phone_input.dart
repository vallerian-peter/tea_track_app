import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/utils.dart';
import '../bottom_sheet_box.dart';
import 'input_styles.dart';

class CountryDialCode {
  const CountryDialCode({
    required this.name,
    required this.dialCode,
    required this.flag,
  });

  final String name;
  final String dialCode;
  final String flag;
}

/// Phone number field with a country dial-code picker.
class AppPhoneInput extends StatefulWidget {
  const AppPhoneInput({
    super.key,
    this.label,
    this.hintText = '712 345 678',
    this.controller,
    this.initialDialCode = '+254',
    this.onChanged,
    this.onCountryChanged,
    this.validator,
    this.isRequired = false,
    this.enabled = true,
  });

  final String? label;
  final String hintText;
  final TextEditingController? controller;
  final String initialDialCode;

  /// Called with the full number, e.g. `+254712345678`.
  final ValueChanged<String>? onChanged;
  final ValueChanged<CountryDialCode>? onCountryChanged;
  final FormFieldValidator<String>? validator;
  final bool isRequired;
  final bool enabled;

  static const List<CountryDialCode> supportedCountries = [
    CountryDialCode(name: 'Kenya', dialCode: '+254', flag: '🇰🇪'),
    CountryDialCode(name: 'Tanzania', dialCode: '+255', flag: '🇹🇿'),
    CountryDialCode(name: 'Uganda', dialCode: '+256', flag: '🇺🇬'),
    CountryDialCode(name: 'Rwanda', dialCode: '+250', flag: '🇷🇼'),
    CountryDialCode(name: 'Burundi', dialCode: '+257', flag: '🇧🇮'),
    CountryDialCode(name: 'Malawi', dialCode: '+265', flag: '🇲🇼'),
  ];

  @override
  State<AppPhoneInput> createState() => _AppPhoneInputState();
}

class _AppPhoneInputState extends State<AppPhoneInput> {
  late CountryDialCode _country = AppPhoneInput.supportedCountries.firstWhere(
    (c) => c.dialCode == widget.initialDialCode,
    orElse: () => AppPhoneInput.supportedCountries.first,
  );
  String _localNumber = '';

  void _notify() {
    final digits = _localNumber.replaceFirst(RegExp(r'^0+'), '');
    widget.onChanged?.call('${_country.dialCode}$digits');
  }

  void _showCountryPicker() {
    if (!widget.enabled) return;
    final styles = InputStyles.of(context);

    BottomSheetBox.show<void>(
      context: context,
      title: AppLocalizations.of(context).selectCountryCode,
      initialChildSize: 0.5,
      child: Column(
        children: [
          for (final country in AppPhoneInput.supportedCountries)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(country.flag, style: const TextStyle(fontSize: 24)),
              title: Text(
                country.name,
                style: AppConstants.body.copyWith(
                  color: styles.text,
                  fontWeight: country.dialCode == _country.dialCode
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              trailing: Text(
                country.dialCode,
                style: AppConstants.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: country.dialCode == _country.dialCode
                      ? styles.accent
                      : styles.hint,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                setState(() => _country = country);
                widget.onCountryChanged?.call(country);
                _notify();
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final styles = InputStyles.of(context);

    final dialCodeChip = GestureDetector(
      onTap: _showCountryPicker,
      child: Container(
        margin: const EdgeInsets.only(
          left: AppConstants.spacingS,
          right: AppConstants.spacingS,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingS,
          vertical: AppConstants.spacingXS + 2,
        ),
        decoration: BoxDecoration(
          color: styles.fillMuted,
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_country.flag, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: AppConstants.spacingXS),
            Text(
              _country.dialCode,
              style: AppConstants.label.copyWith(color: styles.text),
            ),
            Icon(Icons.arrow_drop_down_rounded, size: 18, color: styles.hint),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          InputLabel(widget.label!, isRequired: widget.isRequired),
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          style: styles.textStyle,
          validator: widget.validator,
          onChanged: (value) {
            _localNumber = value;
            _notify();
          },
          decoration: styles.decoration(
            hintText: widget.hintText,
            prefixIcon: dialCodeChip,
          ),
        ),
      ],
    );
  }
}
