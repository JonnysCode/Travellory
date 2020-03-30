import 'package:flutter/material.dart';

class CreateTripScreen extends StatefulWidget {
  @override
  _CreateTripScreenState createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final int _imageItemCount = 11;
  int _selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
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
            Expanded(
              child: Container(

              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectImage(index) {
    setState(() {
      _selectedImage = index;
    });
  }

  Widget _imageItem(int index){
    return GestureDetector(
      onTap: () => _selectImage(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _selectedImage == index ? 80 : 72,
        width: _selectedImage == index ? 80 : 72,
        padding: _selectedImage == index ? const EdgeInsets.all(6.0) : const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: _selectedImage == index ? Theme.of(context).primaryColor : Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home/trip/trip_' + (index + 1).toString() + '.png'),
                fit: BoxFit.fitWidth
            ),
          ),
        ),
      ),
    );
  }
}
