
import 'package:flutter/material.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector(
      {Key key,
        @required this.images,
        this.initialValue,
        this.onChanged,
      })
      : super(key: key);

  final int initialValue;
  final ValueChanged<int> onChanged;
  final List<ImageProvider> images;

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin{
  @override
  bool get wantKeepAlive => true;

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: widget.images.length);
    controller.index = widget.initialValue ?? 0;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 96,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return _imageItem(index);
          },
          separatorBuilder: (context, index) => const SizedBox(),
        ),
      ),
    );;
  }

  void _selectImage(index) {
    setState(() {
      controller.index = index;
      widget.onChanged(index);
    });
  }

  Widget _imageItem(int index) {
    return Center(
      child: GestureDetector(
        onTap: () => _selectImage(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: controller.index == index ? 80 : 72,
          width: controller.index == index ? 80 : 72,
          padding: controller.index == index ? const EdgeInsets.all(8.0) : const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: controller.index == index ? Colors.black26 : Colors.transparent,
          ),
          child: Container(
            key: Key('image_icon'),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: widget.images[index],
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.circular(33.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 4, color: Colors.black.withOpacity(.25), offset: Offset(2.0, 2.0))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
