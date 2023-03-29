import 'package:flutter/material.dart';

class Divider_con extends StatelessWidget {
  const Divider_con({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      width: double.infinity,
      height: 0.5,
      color: Color(0xffC9C8C8
      ),
    );
  }
}
