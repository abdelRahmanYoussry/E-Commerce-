import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/AppCubit/app_cubit.dart';
import '../Widget/FullProductWidget.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return MyProductFullWidget(
            height: mediaQuery.height / 6,
            Taskslist: AppCubit.get(context).favouriteProuduct,
            changeStatus: true,
            showBody: false,
            buttonHeight: mediaQuery.height / 16,
            addTask: false,
            isChecked: isChecked);
      },
    );
  }
}
