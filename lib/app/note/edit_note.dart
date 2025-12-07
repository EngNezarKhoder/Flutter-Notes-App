import 'dart:io';

import 'package:appnote/cubit/note_cubit.dart';
import 'package:appnote/cubit/note_state.dart';
import 'package:appnote/model/note_model.dart';
import 'package:appnote/widgets/my_button.dart';
import 'package:appnote/widgets/my_dialog.dart';
import 'package:appnote/widgets/my_indicator.dart';
import 'package:appnote/widgets/my_text_form_field_email.dart';
import 'package:appnote/widgets/valid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditNote extends StatefulWidget {
  const EditNote(
      {super.key, required this.categoryId, required this.noteModel});
  final String categoryId;
  final NoteModel noteModel;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final TextEditingController noteTitleController = TextEditingController();
  final TextEditingController noteContentController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    noteTitleController.text = widget.noteModel.noteTitle!;
    noteContentController.text = widget.noteModel.noteContent!;
    super.initState();
  }

  @override
  void dispose() {
    noteContentController.dispose();
    noteTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<NoteCubit, NoteState>(builder: (context, state) {
      return Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    "Edit Note",
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
                  controller: noteTitleController,
                  validator: validateUserName,
                  hintText: "Note Title",
                  icon: Icons.folder),
              const SizedBox(
                height: 20,
              ),
              MyTextFormFieldEmail(
                  controller: noteContentController,
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
                    XFile? xfile =
                        await ImagePicker().pickImage(source: ImageSource.camera);
                    context.read<NoteCubit>().selectImage(File(xfile!.path));
                  }, onTapGallery: () async {
                    Navigator.of(context).pop();
                    XFile? xfile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    context.read<NoteCubit>().selectImage(File(xfile!.path));
                  });
                },
                title: state.imageSelected == null
                    ? "+ Edit Image"
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
                          context.read<NoteCubit>().editNote(
                              widget.categoryId,
                              noteTitleController.text,
                              noteContentController.text,
                              widget.noteModel.noteId.toString(),
                              widget.noteModel.noteImage!);
                        }
                      },
                      title: "Save")
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state.isEditedSuccessfully == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Note edited successfully")),
        );
        noteContentController.text = "";
        noteTitleController.text = "";
      }
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      }
    }));
  }
}
