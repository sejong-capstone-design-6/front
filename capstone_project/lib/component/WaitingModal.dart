import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class WaitingModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromRGBO(30, 30, 30, 0.75),
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 72,
              height: 72,
              child: LoadingIndicator(
                indicatorType: Indicator.circleStrokeSpin,
                strokeWidth: 5,
                colors: [Color(0xff2BD0F1)],
              ),
            ),
            SizedBox(
              height: 14,
              width: 150,
            ),
            Text(
              '평가 중',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
