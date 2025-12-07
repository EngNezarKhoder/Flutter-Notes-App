import 'package:appnote/app/category/add_category.dart';
import 'package:appnote/app/category/edit_category.dart';
import 'package:appnote/app/note/note_view.dart';
import 'package:appnote/app/note/view_all_notes.dart';
import 'package:appnote/cubit/category_cubit.dart';
import 'package:appnote/cubit/category_state.dart';
import 'package:appnote/cubit/sign_out_cubit.dart';
import 'package:appnote/main.dart';
import 'package:appnote/model/category_model.dart';
import 'package:appnote/widgets/card_category.dart';
import 'package:appnote/widgets/empty_data.dart';
import 'package:appnote/widgets/my_dialog.dart';
import 'package:appnote/widgets/my_drawer.dart';
import 'package:appnote/widgets/my_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CategoryCubit>()
          .fetchCategories(sharedPref.getString("id")!);
    });

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AddCategory(userId: sharedPref.getString("id")!)));
          },
          backgroundColor: const Color.fromARGB(255, 41, 120, 185),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        drawer: MyDrawer(
          addCategory: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AddCategory(userId: sharedPref.getString("id")!)));
          },
          viewNotes: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ViewAllNotes()));
          },
          signOut: () {
            context.read<SignOutCubit>().signOut();
          },
          email: sharedPref.getString("email")!,
        ),
        appBar: AppBar(
          title: const Text(
            "App Note",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 41, 120, 185),
          centerTitle: true,
        ),
        body: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state.errorMessage != null && state.errorMessage != "empty") {
              showCustomDialog(context,
                  icon: Icons.error,
                  title: "Error",
                  content: state.errorMessage!,
                  color: Colors.red);
            }
            if (state.isDeletedSuccessfully == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Category Is Deleted Successfully.")),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return MyIndicator();
            }
            if (state.categories.isEmpty) {
              return EmptyData(
                  title: 'No Categories Yet.',
                  content: 'Start In Adding New Categories.');
            }
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  return CardCategory(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NoteView(
                                categoryModel: CategoryModel.fromJson(
                                    state.categories[index]),
                              )));
                    },
                    onLongPress: () {
                      showCustomDialogWarning(context,
                          icon: Icons.warning,
                          title: 'warning',
                          content: 'Choose The Operation', onPressedEdit: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => EditCategory(
                                  categoryModel: CategoryModel.fromJson(
                                      state.categories[index]),
                                )));
                      }, onPressedDelete: () {
                        Navigator.of(context).pop();
                        context.read<CategoryCubit>().deleteCategory(
                            sharedPref.getString("id")!,
                            CategoryModel.fromJson(state.categories[index])
                                .categoryId
                                .toString());
                      });
                    },
                    categoryModel:
                        CategoryModel.fromJson(state.categories[index]),
                  );
                });
          },
        ));
  }
}
