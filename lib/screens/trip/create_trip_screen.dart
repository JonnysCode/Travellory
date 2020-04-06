import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/date_form_field.dart';
import 'package:travellory/widgets/form_field.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';

class CreateTripScreen extends StatefulWidget {
  @override
  _CreateTripScreenState createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final _startDateFormFieldKey = GlobalKey<DateFormFieldState>();
  final TripModel tripModel = TripModel();

  static const  int _imageItemCount = 11;
  int _selectedIndex = 0;

  final createTripFormKey = GlobalKey<FormState>();

  final String alertText =
      "You've just created a new trip. You can see all the information in the home screen. "
      "Add bookings and costumize your trip with a click on it";

  @override
  Widget build(BuildContext context) {

    bool validateForm() {
      return (createTripFormKey.currentState.validate());
    }

    return Scaffold(
      key: Key('create_trip'),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: bookingSiteTitle(context, 'Create Trip', FontAwesomeIcons.suitcaseRolling)
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: FaIcon(FontAwesomeIcons.times),
                        iconSize: 30,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Form(
                  key: createTripFormKey,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: SectionTitle('Trip Details'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: DateFormField(
                          key: _startDateFormFieldKey,
                          labelText: "Start Date *",
                          icon: Icon(Icons.date_range),
                          optional: false,
                          chosenDateString: (value) => tripModel.startDate = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: DateFormField(
                          labelText: "End Date *",
                          icon: Icon(Icons.date_range),
                          beforeDateKey: _startDateFormFieldKey,
                          optional: false,
                          dateValidationMessage: "End Date cannot be before Start Date",
                          chosenDateString: (value) => tripModel.endDate = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: TravelloryFormField(
                          labelText: "Destination(s) *",
                          icon: Icon(Icons.directions_car),
                          optional: false,
                          onChanged: (value) => tripModel.destination = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: SectionTitle('General Information'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: TravelloryFormField(
                          labelText: "Trip Title *",
                          icon: Icon(Icons.supervised_user_circle),
                          optional: false,
                          onChanged: (value) => tripModel.name = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: _imageSelection(),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Container(
                          height: 32,
                          width: 120,
                          child: SubmitButton(
                              highlightColor: Theme.of(context).primaryColor,
                              fillColor: Theme.of(context).primaryColor,
                              validationFunction: validateForm,
                              onSubmit: () async {
                                _addTrip(tripModel);
                                showSubmittedBookingDialog(context, alertText, _returnToHomeScreen);
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          height: 32,
                          width: 120,
                          child: cancelButton("CANCEL", context, () {
                            cancellingDialog(context);
                          }),
                        ),
                      ),
                      SizedBox(height: 12),
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageSelection(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 96,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _imageItemCount,
          itemBuilder: (context, index) {
            return _imageItem(index);
          },
          separatorBuilder: (context, index) => const SizedBox(),
        ),
      ),
    );
  }

  _selectImage(index) {
    setState(() {
      _selectedIndex = index;
      //_tripModel.imageNr = _selectedIndex+1;
    });
  }

  Widget _imageItem(int index){
    return Center(
      child: GestureDetector(
        onTap: () => _selectImage(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: _selectedIndex == index ? 80 : 72,
          width: _selectedIndex == index ? 80 : 72,
          padding: _selectedIndex == index ? const EdgeInsets.all(8.0) : const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: _selectedIndex == index ? Colors.black26 : Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home/trip/trip_${(index + 1).toString()}.png'),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.circular(33.0),
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(.25), offset: Offset(2.0, 2.0))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _returnToHomeScreen() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _addTrip(TripModel trip) async {
    HttpsCallable callable =
    CloudFunctions.instance.getHttpsCallable(functionName: '...');
    try {
      final HttpsCallableResult result = await callable.call(tripModel.toMap());
      print(result.data);
    } on CloudFunctionsException catch (e) {
      print('caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }
  }
}
