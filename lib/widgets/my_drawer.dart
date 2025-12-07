import 'package:appnote/cubit/sign_out_cubit.dart';
import 'package:appnote/cubit/sign_out_state.dart';
import 'package:appnote/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer(
      {super.key,
      required this.addCategory,
      required this.viewNotes,
      required this.signOut,
      required this.email});
  final void Function()? addCategory;
  final void Function()? viewNotes;
  final void Function()? signOut;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          const Color.fromARGB(255, 41, 120, 185),
          const Color.fromARGB(255, 144, 170, 192),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
                child: Column(
              children: [
                Image.asset(
                  "images/logo.png",
                  width: 90,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  email,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            )),
            DrawerItem(
                onTap: addCategory,
                icon: Icons.folder,
                color: Colors.white,
                title: "Add Category"),
            DrawerItem(
              onTap: viewNotes,
              icon: Icons.note,
              color: Colors.white,
              title: "Notes",
            ),
            const Spacer(),
            const Divider(
              color: Colors.white,
              thickness: .5,
            ),
            BlocConsumer<SignOutCubit, SignOutState>(
                listener: (context, state) {
              if (state.message == 'done') {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("loginPage", (route) => false);
              }
            }, builder: (context, state) {
              if (state.isLoading) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
                return DrawerItem(
                    onTap: signOut,
                    icon: Icons.exit_to_app,
                    color: Colors.red[200] ?? Colors.white,
                    title: "Sign Out");
              }
            })
          ],
        )),
      ),
    );
  }
}
