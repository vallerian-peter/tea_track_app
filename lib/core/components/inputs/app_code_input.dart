import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/utils.dart';
import 'input_styles.dart';

/// Row of single-digit boxes for OTP / PIN codes.
///
/// Typing moves forward, clearing a box moves back, and a pasted code is
/// spread across the boxes. Give it a new [Key] to clear it.
class AppCodeInput extends StatefulWidget {
  const AppCodeInput({
    super.key,
    required this.onChanged,
    this.onCompleted,
    this.length = 6,
    this.autofocus = true,
    this.obscure = false,
  });

  final int length;
  final bool autofocus;

  /// Shows dots instead of digits, e.g. for a PIN.
  final bool obscure;

  /// Called with the joined digits whenever any box changes.
  final ValueChanged<String> onChanged;

  /// Called once every box is filled.
  final ValueChanged<String>? onCompleted;

  @override
  State<AppCodeInput> createState() => _AppCodeInputState();
}

class _AppCodeInputState extends State<AppCodeInput> {
  late final List<TextEditingController> _controllers =
      List.generate(widget.length, (_) => TextEditingController());
  late final List<FocusNode> _focusNodes =
      List.generate(widget.length, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focusNodes.first.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      _fillFrom(index, value);
    } else if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final code = _controllers.map((c) => c.text).join();
    widget.onChanged(code);
    if (code.length == widget.length) {
      FocusScope.of(context).unfocus();
      widget.onCompleted?.call(code);
    }
  }

  void _fillFrom(int index, String value) {
    var target = index;
    for (final digit in value.replaceAll(RegExp(r'\D'), '').split('')) {
      if (target >= widget.length) break;
      _controllers[target].text = digit;
      target++;
    }
    if (target < widget.length) _focusNodes[target].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final styles = InputStyles.of(context);
    const gap = 10.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final fitWidth =
            (constraints.maxWidth - gap * (widget.length - 1)) / widget.length;
        final boxWidth = fitWidth.clamp(36.0, 54.0);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < widget.length; i++)
              Container(
                width: boxWidth,
                height: boxWidth + 8,
                margin: EdgeInsets.only(left: i == 0 ? 0 : gap),
                child: TextField(
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  onChanged: (value) => _onChanged(i, value),
                  obscureText: widget.obscure,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: AppConstants.title.copyWith(color: styles.text),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: styles.fill,
                    enabledBorder: styles.outline(styles.border),
                    focusedBorder: styles.outline(styles.focus, 1.6),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
