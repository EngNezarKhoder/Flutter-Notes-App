import 'dart:io';

import 'package:appnote/constant/link_server.dart';
import 'package:appnote/cubit/note_state.dart';
import 'package:appnote/model/note_model.dart';
import 'package:appnote/widgets/crud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteState(isLoading: false, notes: []));
  final Crud _crud = Crud();
  Future<void> fetchNotes(String categoryId) async {
    emit(state.copyWith(
        isLoading: true,
        clearError: true,
        clearSuccessFalg: true,
        clearImage: true));
    try {
      var res = await _crud.postRequest(viewNotes, {"id": categoryId});
      if (res['status'] == 'success') {
        emit(state.copyWith(isLoading: false, notes: res['data']));
      } else if (res['status'] == 'empty') {
        emit(
            state.copyWith(isLoading: false, notes: [], errorMessage: 'empty'));
      } else {
        emit(state.copyWith(
            isLoading: false, errorMessage: 'Failed to load notes'));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Connection error",
      ));
    }
  }

  Future<void> addNote(
    String categoryId,
    String noteTitle,
    String noteContent,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      clearError: true,
      clearSuccessFalg: true,
    ));
    try {
      var res = await _crud.postRequestWithFile(
          addNotes,
          {'title': noteTitle, 'content': noteContent, 'id': categoryId},
          state.imageSelected!);
      if (res['status'] == 'success') {
        emit(state.copyWith(
            isLoading: false, isAddedSuccessfully: true, clearError: true));
        await fetchNotes(categoryId);
      } else if (res['status'] == 'error') {
        emit(state.copyWith(
            errorMessage: res['errors'][0],
            isLoading: false,
            clearSuccessFalg: true));
      } else {
        emit(state.copyWith(
            errorMessage: "Failed to add notes",
            isLoading: false,
            clearSuccessFalg: true));
      }
    } catch (e) {
      emit(state.copyWith(
          errorMessage: "Connection error",
          isLoading: false,
          clearSuccessFalg: true));
    }
  }

  Future<void> editNote(String categoryId, String noteTitle, String noteContent,
      String noteId, String noteImage) async {
    emit(state.copyWith(
      isLoading: true,
      clearError: true,
      clearSuccessFalg: true,
    ));
    try {
      var res;
      if (state.imageSelected == null) {
        res = await _crud.postRequest(editNotes, {
          'title': noteTitle,
          'content': noteContent,
          'id': noteId,
          'note_image': noteImage
        });
      } else {
        res = await _crud.postRequestWithFile(
            editNotes,
            {
              'title': noteTitle,
              'content': noteContent,
              'id': noteId,
              'note_image': noteImage
            },
            state.imageSelected!);
      }
      if (res['status'] == 'success') {
        emit(state.copyWith(
            isLoading: false, isEditedSuccessfully: true, clearError: true));
        await fetchNotes(categoryId);
      } else {
        emit(state.copyWith(
            errorMessage: "Failed to edit notes",
            isLoading: false,
            clearSuccessFalg: true));
      }
    } catch (e) {
      emit(state.copyWith(
          errorMessage: "Connection error",
          isLoading: false,
          clearSuccessFalg: true));
    }
  }

  Future<void> deleteNote(String categoryId, NoteModel noteModel) async {
    emit(state.copyWith(
        isLoading: true,
        clearError: true,
        clearSuccessFalg: true,
        clearImage: true));
    try {
      var res = await _crud.postRequest(deleteNotes,
          {"id": noteModel.noteId.toString(), "image_name": noteModel.noteImage});
      if (res['status'] == 'success') {
        emit(state.copyWith(
            isLoading: false, isDeletedSuccessfully: true, clearError: true));
        await fetchNotes(categoryId);
      } else {
        emit(state.copyWith(
            isLoading: false,
            clearSuccessFalg: true,
            errorMessage: 'Failed To Delete notes'));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          clearSuccessFalg: true,
          errorMessage: 'Error Connection'));
    }
  }

  Future<void> fetchAllNotes(String userId) async {
    emit(state.copyWith(
        isLoading: true,
        clearError: true,
        clearSuccessFalg: true,
        clearImage: true));
    try {
      var res = await _crud.postRequest(viewAllNotes, {"id": userId});
      if (res['status'] == 'success') {
        emit(state.copyWith(isLoading: false, notes: res['data']));
      } else if (res['status'] == 'empty') {
        emit(
            state.copyWith(isLoading: false, notes: [], errorMessage: 'empty'));
      } else {
        emit(state.copyWith(
            isLoading: false, errorMessage: 'Failed to load notes'));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Connection error",
      ));
    }
  }

  void selectImage(File file) {
    emit(state.copyWith(
        imageSelected: file, clearError: true, clearSuccessFalg: true));
  }
}
