import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class DateFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool autofocus;
  final bool enabled;

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  final void Function(DateTime) onChanged;
  final String Function(DateTime) additionalValidator;
  final bool skipValidation;

  DateFormField({
    Key key,
    this.controller,
    this.labelText,
    this.autofocus = false,
    this.enabled = true,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.additionalValidator,
    this.skipValidation = false,
  }) : super(key: key);

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  DateTime _date;
  DateTime _firstDate;
  DateTime _lastDate;

  @override
  void initState() {
    super.initState();

    _date = widget.initialDate;
    _firstDate = widget.firstDate ??
        DateTime.now().subtract(const Duration(days: 365 * 20));
    _lastDate =
        widget.lastDate ?? DateTime.now().add(const Duration(days: 365 * 20));
  }

  DateTime _tryParseDate(String value) {
    try {
      return DateFormat.yMd().parseLoose(value);
    } on FormatException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: widget.autofocus,
      decoration: InputDecoration(labelText: widget.labelText),
      enabled: widget.enabled,
      onChanged: (value) {
        final date = _tryParseDate(value);

        if (date != null &&
            date.isAfter(_firstDate) &&
            date.isBefore(_lastDate)) {
          setState(() {
            _date = date;
            widget.onChanged?.call(date);
          });
        }
      },
      onTap: () async {
        if (_date != null &&
            (_date.isBefore(_firstDate) || _date.isAfter(_lastDate))) return;

        final date = await showDatePicker(
          context: context,
          initialDate: _date ?? DateTime.now(),
          firstDate: _firstDate,
          lastDate: _lastDate,
        );

        if (date != null) {
          setState(() {
            _date = date;
            widget.controller.text = DateFormat.yMd().format(date);
            widget.onChanged?.call(date);
          });
        }
      },
      validator: (value) {
        if (widget.skipValidation) return null;

        final appLocalizations = AppLocalizations.of(context);

        if (value.isEmpty) {
          return appLocalizations.enterDate;
        }

        final date = _tryParseDate(value);

        if (date == null) {
          return appLocalizations.enterDate;
        }

        if (date.isBefore(_firstDate) || date.isAfter(_lastDate)) {
          return appLocalizations.enterDate;
        }

        return widget.additionalValidator?.call(date);
      },
    );
  }
}
