import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompleteModal extends StatelessWidget {
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
              child: SvgPicture.asset('assets/images/ThumbUp.svg'),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              '평가 완료',
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
