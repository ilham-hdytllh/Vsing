import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlaceLocation extends StatefulWidget {
  const PlaceLocation({Key? key, this.active, this.index, this.location})
      : super(key: key);

  final bool? active;
  final int? index;
  final PlaceLocation? location;

  @override
  State<PlaceLocation> createState() => _PlaceLocationState();
}

class _PlaceLocationState extends State<PlaceLocation> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
