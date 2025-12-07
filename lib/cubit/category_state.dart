class CategoryState {
  final bool isLoading;
  final List categories;
  final String? errorMessage;
  final bool? isAddedSuccessfully;
  final bool? isDeletedSuccessfully;
  final bool? isEditedSuccessfully;

  CategoryState(
      {required this.isLoading,
      required this.categories,
      this.errorMessage,
      this.isAddedSuccessfully,
      this.isDeletedSuccessfully,
      this.isEditedSuccessfully});
  CategoryState copyWith({
    bool? isLoading,
    List? categories,
    String? errorMessage,
    bool? isAddedSuccessfully,
    bool? isDeletedSuccessfully,
    bool? isEditedSuccessfully,
    bool clearError = false,
    bool clearSuccessFalg = false,
  }) {
    return CategoryState(
        isLoading: isLoading ?? this.isLoading,
        categories: categories ?? this.categories,
        errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
        isAddedSuccessfully: clearSuccessFalg
            ? null
            : isAddedSuccessfully ?? this.isAddedSuccessfully,
        isDeletedSuccessfully: clearSuccessFalg
            ? null
            : isDeletedSuccessfully ?? this.isDeletedSuccessfully,
        isEditedSuccessfully: clearSuccessFalg
            ? null
            : isEditedSuccessfully ?? this.isEditedSuccessfully);
  }
}
