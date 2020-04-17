import 'package:flutter/material.dart';
import 'package:travellory/widgets/bookings/banner.dart';
import 'package:travellory/widgets/font_widgets.dart';

class BookingHeader extends StatefulWidget {
  const BookingHeader(this.title, this.bannerUrl, {Key key}) : super(key: key);

  final String title;
  final String bannerUrl;

  @override
  _BookingHeaderState createState() => _BookingHeaderState();
}

class _BookingHeaderState extends State<BookingHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      key: Key('ViewBookingHeader'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: BannerImage(this.widget.bannerUrl),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: FashionFetishText(
                        text: this.widget.title,
                        size: 24,
                        fontWeight: FashionFontWeight.heavy,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
