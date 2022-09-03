import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget {
  final String lable;
  final VoidCallback onTap;
  const MyButton({
    Key? key,
    required this.lable,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: primaryClr,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: SizedBox(
        height: 60,
        child: Center(
          child: Text(
            lable,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     width: 100,
    //     height: 60,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20),
    //       color: primaryClr,
    //     ),
    //     child: Center(
    //       child: Text(
    //         lable,
    //         style: const TextStyle(
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
