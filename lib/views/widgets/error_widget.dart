import 'package:flutter/material.dart';

class SomethingWentWrongWidget extends StatelessWidget {
  const SomethingWentWrongWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text('Something was wrong', style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }
}
