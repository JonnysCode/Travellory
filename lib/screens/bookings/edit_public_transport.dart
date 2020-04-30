import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/services/database/submit.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/trip/trip_header.dart';
import 'add_public_transport.dart';

class EditPublicTransport extends PublicTransport {
  EditPublicTransport({
    Key key,
  }) : super(key: key);

  @override
  _EditPublicTransportState createState() => _EditPublicTransportState();
}

class _EditPublicTransportState extends PublicTransportState<EditPublicTransport> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;

    final ActivityModel _activityModel = ModalRoute.of(context).settings.arguments;

    @override
    Widget build(BuildContext context) {
      final SingleTripProvider singleTripProvider =
          Provider.of<TripsProvider>(context, listen: false).selectedTrip;
      final TripModel tripModel = singleTripProvider.tripModel;
      publicTransportModel.tripUID = tripModel.uid;

      publicTransportList[publicTransportList.length - 3] = SubmitButton(
        highlightColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).primaryColor,
        validationFunction: validateForm,
        onSubmit: onSubmitBooking(singleTripProvider, publicTransportModel,
            'booking-addPublicTransportation', context, alertText),
      );

      publicTransportList[publicTransportList.length - 2] = CancelButton(
        text: 'CANCEL',
        onCancel: () {
          cancellingDialog(context, cancelText);
        },
      );

      return Scaffold(
        key: Key('EditPublicTransport'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              TripHeader(tripModel),
              Expanded(
                  //child: Form(
                  child: Container(
                height: double.infinity,
                child: Form(
                  key: publicTransportFormKey,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: AnimatedList(
                          key: _listKey,
                          initialItemCount: publicTransportList.length,
                          itemBuilder: itemBuilder,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      );
    }
  }
}
