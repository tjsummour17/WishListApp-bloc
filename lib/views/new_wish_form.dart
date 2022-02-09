import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class NewWishForm extends StatefulWidget {
  static const String id = "/NewWish";

  const NewWishForm({Key? key}) : super(key: key);

  @override
  _NewWishFormState createState() => _NewWishFormState();
}

class _NewWishFormState extends State<NewWishForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(AppLocalizations.of(context)!.addNewWish),),);
  }
}
