import 'package:flutter/material.dart';

class NimbleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NimbleAppBar({Key? key}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 150,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: SizedBox(
            width: 150,
            child: Image.asset('assets/images/nimblerx_logo.png'),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
