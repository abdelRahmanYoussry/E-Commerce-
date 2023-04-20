import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/AppCubit/app_cubit.dart';
import '../Widget/FullProductWidget.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
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
            changeStatus: true,
            Taskslist: AppCubit.get(context).completeProuduct,
            addTask: false,
            showBody: false,
            buttonHeight: mediaQuery.height / 16,
            isChecked: isChecked);
      },
    );
  }
}
