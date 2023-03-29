import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/styles/textstyle.dart';

class Reuseable_button extends StatelessWidget {
  Reuseable_button(this.txt, this.clr, this.picture, @required this.onPress, {Key? key}) : super(key: key);

  dynamic txt;
  Color clr;
  SvgPicture? picture;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            shape:
            MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
            backgroundColor: MaterialStateProperty.all<Color>(clr)),
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 19),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (picture != null) picture!,
              const SizedBox(width: 9),
              txt is String ? Text(txt, style: AppTextStyles.kPrimaryS3W4) : txt,
            ],
          ),
        ),
      ),
    );
  }
}