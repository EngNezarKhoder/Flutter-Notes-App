import 'package:appnote/constant/link_server.dart';
import 'package:appnote/cubit/category_state.dart';
import 'package:appnote/model/category_model.dart';
import 'package:appnote/widgets/crud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryState(isLoading: false, categories: []));
  final Crud _crud = Crud();
  Future<void> fetchCategories(String userId) async {
    emit(state.copyWith(
        isLoading: true, clearSuccessFalg: true, clearError: true));
    try {
      var res = await _crud.postRequest(viewCategories, {"id": userId});
      if (res['status'] == 'success') {
        emit(state.copyWith(isLoading: false, categories: res['data']));
      } else if (res['status'] == 'empty') {
        emit(state.copyWith(
          isLoading: false,
          categories: [],
          errorMessage: "empty",
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Failed to load categories.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Connection error",
      ));
    }
  }

  Future<void> addCategory(String userId, String name) async {
    try {
      emit(state.copyWith(
          isLoading: true, clearError: true, clearSuccessFalg: true));
      var res = await _crud
          .postRequest(addCategories, {"user_id": userId, "name": name});
      if (res['status'] == 'success') {
        emit(state.copyWith(
            isLoading: false, isAddedSuccessfully: true, clearError: true));
        await fetchCategories(userId);
      } else if (res['status'] == 'category_exist') {
        emit(state.copyWith(
            errorMessage: "The category is already existed",
            isLoading: false,
            clearSuccessFalg: true));
      } else {
        emit(state.copyWith(
            errorMessage: "Failed to add categories",
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

  Future<void> editCategory(
      String userId, String categoryName, String categoryId) async {
    try {
      emit(state.copyWith(
          isLoading: true, clearError: true, clearSuccessFalg: true));
      var res = await _crud.postRequest(editCategories,
          {"category_name": categoryName, "category_id": categoryId});
      if (res['status'] == 'success') {
        emit(state.copyWith(
            isLoading: false, isEditedSuccessfully: true, clearError: true));
        await fetchCategories(userId);
      } else {
        emit(state.copyWith(
            errorMessage: "Failed to edit categories",
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

  Future<void> deleteCategory(String userId, CategoryModel categoryModel) async {
    try {
      emit(state.copyWith(
          isLoading: true, clearError: true, clearSuccessFalg: true));
      var res = await _crud
          .postRequest(deleteCategories, {"category_id": categoryModel.categoryId.toString()});
      if (res['status'] == 'success') {
        emit(state.copyWith(
            isLoading: false, isDeletedSuccessfully: true, clearError: true));
        await fetchCategories(userId);
      } else {
        emit(state.copyWith(
            errorMessage: "Failed to delete category",
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
}
