import 'package:appnote/cubit/category_cubit.dart';
import 'package:appnote/cubit/category_state.dart';
import 'package:appnote/main.dart';
import 'package:appnote/model/category_model.dart';
import 'package:appnote/widgets/my_button.dart';
import 'package:appnote/widgets/my_indicator.dart';
import 'package:appnote/widgets/my_text_form_field_email.dart';
import 'package:appnote/widgets/valid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final TextEditingController categoryNameController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    categoryNameController.text = widget.categoryModel.categoryName!;
    super.initState();
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CategoryCubit, CategoryState>(
            builder: (context, state) {
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
                    "Edit Category",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 41, 120, 185),
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  )
                ],
              ),
              const SizedBox(
                height: 120,
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
                  controller: categoryNameController,
                  validator: validateUserName,
                  hintText: "Category Name",
                  icon: Icons.folder),
              const SizedBox(
                height: 20,
              ),
              state.isLoading
                  ? MyIndicator()
                  : MyButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          context.read<CategoryCubit>().editCategory(
                              sharedPref.getString("id")!,
                              categoryNameController.text,
                              widget.categoryModel.categoryId.toString());
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
          SnackBar(content: Text("Category edited successfully")),
        );
        categoryNameController.text = "";
      }
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      }
    }));
  }
}
