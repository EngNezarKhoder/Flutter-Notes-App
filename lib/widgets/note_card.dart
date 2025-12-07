import 'package:appnote/constant/link_server.dart';
import 'package:appnote/model/note_model.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, this.onLongPress, required this.noteModel});
  final void Function()? onLongPress;
  final NoteModel noteModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "$linkImageRoute/${noteModel.noteImage}",
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Expanded(
                flex: 3,
                child: ListTile(
                  title: Text(
                    noteModel.noteTitle!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(noteModel.noteContent!),
                )),
          ],
        ),
      ),
    );
  }
}
