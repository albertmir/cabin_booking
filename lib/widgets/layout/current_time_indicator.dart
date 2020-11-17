import 'package:cabin_booking/constants.dart';
import 'package:cabin_booking/model/day_handler.dart';
import 'package:cabin_booking/utils/time_of_day.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_builder/timer_builder.dart';

class CurrentTimeIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(
      Duration(seconds: 5),
      builder: (context) {
        final viewStartDateTime = tryParseDateTimeWithFormattedTimeOfDay(
          dateTime: Provider.of<DayHandler>(context).dateTime,
          formattedTimeOfDay: timeTableStartTime.format(context),
        );

        final viewEndDateTime = tryParseDateTimeWithFormattedTimeOfDay(
          dateTime: Provider.of<DayHandler>(context).dateTime,
          formattedTimeOfDay: timeTableEndTime.format(context),
        );

        final int _differenceFromViewStartTime =
            DateTime.now().difference(viewStartDateTime).inMinutes;

        final int _differenceFromViewEndTime =
            DateTime.now().difference(viewEndDateTime).inMinutes;

        return _differenceFromViewStartTime > 0 &&
                _differenceFromViewEndTime < 0
            ? Column(
                children: [
                  SizedBox(
                    height: _differenceFromViewStartTime * bookingHeightRatio,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        TimeOfDay.fromDateTime(DateTime.now()).format(context),
                        style: TextStyle(
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red[400],
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(3, 4),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container();
      },
    );
  }
}
