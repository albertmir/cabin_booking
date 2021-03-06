import 'package:cabin_booking/model/booking.dart';
import 'package:cabin_booking/model/recurring_booking.dart';
import 'package:cabin_booking/widgets/booking/booking_form.dart';
import 'package:cabin_booking/widgets/layout/data_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingDialog extends StatefulWidget {
  final Booking booking;

  const BookingDialog(this.booking);

  @override
  _BookingDialogState createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  bool _isRecurring = false;

  @override
  void initState() {
    super.initState();

    _isRecurring = RecurringBooking.isRecurringBooking(widget.booking);
  }

  void _setIsRecurring(bool isRecurring) {
    setState(() => _isRecurring = isRecurring);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return DataDialog(
      title: Text(
        widget.booking.isDisabled
            ? appLocalizations.lockedRange
            : _isRecurring
                ? appLocalizations.recurringBooking
                : appLocalizations.booking,
      ),
      content: SizedBox(
        width: 320.0,
        child: BookingForm(
          booking: widget.booking,
          isRecurring: _isRecurring,
          setIsRecurring: _setIsRecurring,
        ),
      ),
    );
  }
}
