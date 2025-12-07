import 'package:appnote/app/note/add_note.dart';
import 'package:appnote/app/note/edit_note.dart';
import 'package:appnote/cubit/note_cubit.dart';
import 'package:appnote/cubit/note_state.dart';
import 'package:appnote/model/category_model.dart';
import 'package:appnote/model/note_model.dart';
import 'package:appnote/widgets/empty_data.dart';
import 'package:appnote/widgets/my_dialog.dart';
import 'package:appnote/widgets/my_indicator.dart';
import 'package:appnote/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<NoteCubit>()
          .fetchNotes(widget.categoryModel.categoryId.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddNote(
                    categoryId: widget.categoryModel.categoryId.toString())));
          },
          backgroundColor: const Color.fromARGB(255, 41, 120, 185),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text(
            widget.categoryModel.categoryName!,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 41, 120, 185),
        ),
        body: BlocConsumer<NoteCubit, NoteState>(builder: (context, state) {
          if (state.isLoading) {
            return MyIndicator();
          }
          if (state.notes.isEmpty) {
            return EmptyData(
                title: 'No Notes Yet.', content: 'Start In Adding New Notes');
          }
          return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return NoteCard(
                  onLongPress: () {
                    showCustomDialogWarning(context,
                        icon: Icons.warning,
                        title: 'warning',
                        content: 'Choose the operation', onPressedEdit: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => EditNote(
                                categoryId:
                                    widget.categoryModel.categoryId.toString(),
                                noteModel:
                                    NoteModel.fromJson(state.notes[index]),
                              )));
                    }, onPressedDelete: () {
                      Navigator.of(context).maybePop();
                      context.read<NoteCubit>().deleteNote(
                          widget.categoryModel.categoryId.toString(),
                          NoteModel.fromJson(state.notes[index]));
                    });
                  },
                  noteModel: NoteModel.fromJson(state.notes[index]),
                );
              });
        }, listener: (context, state) {
          if (state.isDeletedSuccessfully == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Note Is Deleted Successfully.")),
            );
          }
          if (state.errorMessage != null && state.errorMessage != 'empty') {
            showCustomDialog(context,
                icon: Icons.error,
                title: "Error",
                content: state.errorMessage!,
                color: Colors.red);
          }
        }));
  }
}
