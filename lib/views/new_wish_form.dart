import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wishlist_app/bloc/wishlist_bloc.dart';
import 'package:wishlist_app/models/wish.dart';
import 'package:wishlist_app/providers/user_provider.dart';
import 'package:wishlist_app/services/wishlist_repository.dart';
import 'package:wishlist_app/services/wishlist_service.dart';
import 'package:wishlist_app/views/widgets/default_themes.dart';

class NewWishForm extends StatefulWidget {
  static const String id = "/NewWish";

  const NewWishForm({Key? key}) : super(key: key);

  @override
  _NewWishFormState createState() => _NewWishFormState();
}

class _NewWishFormState extends State<NewWishForm> {
  File? _pickedFile;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    WishlistBloc wishlistBloc = WishlistBloc();
    return RepositoryProvider(
      create: (context) => WishlistRepository(service: WishlistService()),
      child: MultiBlocProvider(
        providers: [BlocProvider<WishlistBloc>(create: (context) => wishlistBloc)],
        child: BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text(AppLocalizations.of(context)!.addNewWish)),
            body: ListView(padding: const EdgeInsets.all(20), children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: DefaultThemes.defaultContainerTheme(context),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        foregroundImage: _pickedFile != null ? FileImage(_pickedFile!) : null,
                        child: _pickedFile == null
                            ? IconButton(
                                onPressed: () async {
                                  try {
                                    _pickedFile = File((await ImagePicker().pickImage(source: ImageSource.gallery))!.path);
                                    setState(() {});
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                },
                                icon: const Icon(Icons.attach_file))
                            : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(controller: titleController, decoration: InputDecoration(hintText: AppLocalizations.of(context)!.title)),
                      const SizedBox(height: 20),
                      TextFormField(controller: descriptionController, decoration: InputDecoration(hintText: AppLocalizations.of(context)!.description), minLines: 3, maxLines: 5),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  wishlistBloc.add(AddToWishlist(
                                      userId: userProvider.user!.id,
                                      wish: Wish(userId: userProvider.user!.id, title: titleController.text, description: descriptionController.text),
                                      file: _pickedFile));
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(AppLocalizations.of(context)!.addNewWish, style: Theme.of(context).textTheme.button)))
                    ],
                  ),
                ),
              ),
            ]),
          );
        }),
      ),
    );
  }
}
