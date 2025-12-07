import 'package:appnote/cubit/note_cubit.dart';
import 'package:appnote/cubit/note_state.dart';
import 'package:appnote/main.dart';
import 'package:appnote/model/note_model.dart';
import 'package:appnote/widgets/empty_data.dart';
import 'package:appnote/widgets/my_dialog.dart';
import 'package:appnote/widgets/my_indicator.dart';
import 'package:appnote/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAllNotes extends StatelessWidget {
  const ViewAllNotes({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoteCubit>().fetchAllNotes(sharedPref.getString("id")!);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Notes",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 41, 120, 185),
        centerTitle: true,
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
                noteModel: NoteModel.fromJson(state.notes[index]),
              );
            });
      }, listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage != 'empty') {
          showCustomDialog(context,
              icon: Icons.error,
              title: "Error",
              content: state.errorMessage!,
              color: Colors.red);
        }
      }),
    );
  }
}
