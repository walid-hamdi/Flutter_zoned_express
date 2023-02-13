import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/theme/theme_provider.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getTheme(context),
      child: Center(
        child: SpinKitRotatingCircle(
          color: Colors.blue[600],
          size: 50.0,
        ),
      ),
    );
  }
}
