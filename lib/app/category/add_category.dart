import 'package:appnote/cubit/category_cubit.dart';
import 'package:appnote/cubit/category_state.dart';
import 'package:appnote/main.dart';
import 'package:appnote/widgets/my_button.dart';
import 'package:appnote/widgets/my_indicator.dart';
import 'package:appnote/widgets/my_text_form_field_email.dart';
import 'package:appnote/widgets/valid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key, required this.userId});
  final String userId;
  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController categoryName = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  void dispose() {
    categoryName.dispose();
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    "Add Category",
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
                  controller: categoryName,
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
                          context.read<CategoryCubit>().addCategory(
                              sharedPref.getString("id")!, categoryName.text);
                        }
                      },
                      title: "Add")
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state.isAddedSuccessfully == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Category added successfully")),
        );
        categoryName.text = "";
      }
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      }
    }));
  }
}
