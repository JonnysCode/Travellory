import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/font_widgets.dart';

class CreateTripScreen extends StatefulWidget {
  @override
  _CreateTripScreenState createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final int _imageItemCount = 11;
  int _selectedIndex = 0;

  TripModel _tripModel;

  @override
  void initState() {
    _tripModel = TripModel(
        name: '',
        startDate: DateTime(2000, 1, 1),
        endDate: DateTime(2000, 1, 1),
        destination: '',
        imageNr: _selectedIndex+1
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FashionFetishText(
          text: 'Create a Trip',
          size: 26,
          fontWeight: FashionFontWeight.HEAVY,
          height: 1.2,
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black26,
              size: 38,
            ),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _imageItemCount,
                itemBuilder: (BuildContext context, int index) {
                  return _imageItem(index);
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(),
              ),
            ),
          ),
          Expanded(
            child: Container(

            ),
          ),
        ],
      ),
    );
  }

  _selectImage(index) {
    setState(() {
      _selectedIndex = index;
      _tripModel.imageNr = _selectedIndex+1;
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
                image: AssetImage('assets/images/home/trip/trip_' + (index + 1).toString() + '.png'),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.circular(33.0),
              boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(.25), offset: Offset(2.0, 2.0))],
            ),
          ),
        ),
      ),
    );
  }
}
