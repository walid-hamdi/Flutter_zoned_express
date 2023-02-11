import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zoned_express/utils/theme/theme_provider.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SpinKitRotatingCircle(
          color: getTheme(context).primaryColorLight,
          size: 50.0,
        ),
      ),
    );
  }
}
