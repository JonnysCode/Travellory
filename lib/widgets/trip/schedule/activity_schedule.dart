import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/schedule_entry.dart';
import 'package:travellory/widgets/font_widgets.dart';

class ActivitySchedule extends StatelessWidget {
  const ActivitySchedule(this.scheduleEntry, {Key key}) : super(key: key);

  final ScheduleEntry scheduleEntry;

  @override
  Widget build(BuildContext context) {
    ActivityModel activity = scheduleEntry.booking;

    return Row(
      key: Key('activity'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 16),
          child: FaIcon(
            FontAwesomeIcons.theaterMasks,
            size: 26,
            color: Colors.black54,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FashionFetishText(
                text: activity.title,
                size: 15,
                fontWeight: FashionFontWeight.heavy,
                height: 1.2,
                color: Colors.black54,
              ),
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.locationArrow,
                    size: 12,
                    color: Colors.white70,
                  ),
                  SizedBox(width: 4),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      activity.location,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (activity.startTime.isNotEmpty)
          Center(
          child: SizedBox(
            width: 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${activity.startTime}',
                  style: TextStyle(
                    color: Colors.black38,
                  ),
                ),
                if (activity.endTime.isNotEmpty)
                  Text(
                    'to',
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                if (activity.endTime.isNotEmpty)
                  Text(
                    '${activity.endTime}',
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10)
      ],
    );
  }
}
