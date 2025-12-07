import 'dart:io';

import 'package:appnote/cubit/note_cubit.dart';
import 'package:appnote/cubit/note_state.dart';
import 'package:appnote/widgets/my_button.dart';
import 'package:appnote/widgets/my_dialog.dart';
import 'package:appnote/widgets/my_indicator.dart';
import 'package:appnote/widgets/my_text_form_field_email.dart';
import 'package:appnote/widgets/valid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.categoryId});
  final String categoryId;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController noteTitle = TextEditingController();
  final TextEditingController noteContent = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  void dispose() {
    noteTitle.dispose();
    noteContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<NoteCubit, NoteState>(builder: (context, state) {
      return Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: const Color.fromARGB(255, 41, 120, 185),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 65,
                  ),
                  Text(
                    "Add Note",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 41, 120, 185),
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                "images/logo.png",
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 60,
              ),
              MyTextFormFieldEmail(
                  controller: noteTitle,
                  validator: validateUserName,
                  hintText: "Note title",
                  icon: Icons.folder),
              const SizedBox(
                height: 20,
              ),
              MyTextFormFieldEmail(
                  controller: noteContent,
                  validator: validateUserName,
                  hintText: "Note Content",
                  icon: Icons.folder),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                onPressed: () {
                  showImagePickerSheet(context, onTapCamera: () async {
                    Navigator.of(context).pop();
                    XFile? xfile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    context.read<NoteCubit>().selectImage(File(xfile!.path));
                  }, onTapGallery: () async {
                    Navigator.of(context).pop();
                    XFile? xfile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    context.read<NoteCubit>().selectImage(File(xfile!.path));
                  });
                },
                title: state.imageSelected == null
                    ? "+ Add Image"
                    : "Image Selected ✔️",
              ),
              const SizedBox(
                height: 20,
              ),
              state.isLoading
                  ? MyIndicator()
                  : MyButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          if (state.imageSelected != null) {
                            context.read<NoteCubit>().addNote(
                                  widget.categoryId,
                                  noteTitle.text,
                                  noteContent.text,
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("No Choosen File.")),
                            );
                          }
                        }
                      },
                      title: "Add")
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state.isAddedSuccessfully == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Note added successfully")),
        );
        noteTitle.text = "";
        noteContent.text = "";
      }
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      }
    }));
  }
}
