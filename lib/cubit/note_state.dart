import 'dart:io';

class NoteState {
  final bool isLoading;
  final List notes;
  final String? errorMessage;
  final bool? isAddedSuccessfully;
  final bool? isDeletedSuccessfully;
  final bool? isEditedSuccessfully;
  final File? imageSelected;
  NoteState(
      {required this.isLoading,
      required this.notes,
      this.errorMessage,
      this.isAddedSuccessfully,
      this.isDeletedSuccessfully,
      this.isEditedSuccessfully,
      this.imageSelected});
  NoteState copyWith({
    bool? isLoading,
    List? notes,
    String? errorMessage,
    bool? isAddedSuccessfully,
    bool? isDeletedSuccessfully,
    bool? isEditedSuccessfully,
    File? imageSelected,
    bool clearError = false,
    bool clearSuccessFalg = false,
    bool clearImage = false,
  }) {
    return NoteState(
        isLoading: isLoading ?? this.isLoading,
        notes: notes ?? this.notes,
        errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
        isAddedSuccessfully: clearSuccessFalg
            ? null
            : isAddedSuccessfully ?? this.isAddedSuccessfully,
        isEditedSuccessfully: clearSuccessFalg
            ? null
            : isEditedSuccessfully ?? this.isEditedSuccessfully,
        isDeletedSuccessfully: clearSuccessFalg
            ? null
            : isDeletedSuccessfully ?? this.isDeletedSuccessfully,
        imageSelected: clearImage ? null : imageSelected ?? this.imageSelected);
  }
}
