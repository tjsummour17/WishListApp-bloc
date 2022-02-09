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

class EditWishForm extends StatefulWidget {
  final Wish wish;

  const EditWishForm({Key? key, required this.wish}) : super(key: key);

  @override
  _EditWishFormState createState() => _EditWishFormState();
}

class _EditWishFormState extends State<EditWishForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String imageUrl = "";
  File? _pickedFile;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.wish.title;
    descriptionController.text = widget.wish.description ?? "";
    getImage();
  }

  getImage() async {
    imageUrl = await WishlistService.getImageUrl(widget.wish.imageRef);
    setState(() {});
  }

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
            appBar: AppBar(title: Text(AppLocalizations.of(context)!.editWish)),
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
                        backgroundImage: _pickedFile == null
                            ? imageUrl.isEmpty
                                ? null
                                : NetworkImage(imageUrl)
                            : FileImage(_pickedFile!) as ImageProvider,
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
                                  wishlistBloc.add(EditWish(
                                      userId: userProvider.user!.id,
                                      wish: Wish(userId: userProvider.user!.id, title: titleController.text, description: descriptionController.text, docId: widget.wish.docId)));
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(AppLocalizations.of(context)!.editWish, style: Theme.of(context).textTheme.button)))
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
