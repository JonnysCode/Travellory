import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:travellory/widgets/map/map_widget.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/g_map/map_style.json').then((string) {
      if (this.mounted) {
        mapStyle = string;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: Container(
          key: Key('map_page'),
          child: GoogleMapWidget(),
        ),
      ),
    );
  }
}
