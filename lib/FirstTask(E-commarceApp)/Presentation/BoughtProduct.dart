import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/AppCubit/app_cubit.dart';
import '../Widget/FullProductWidget.dart';

class PurchasedScreen extends StatelessWidget {
  PurchasedScreen({Key? key}) : super(key: key);
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
            Taskslist: AppCubit.get(context).unCompleteProuduct,
            buttonHeight: mediaQuery.height / 16,
            addTask: false,
            showBody: false,
            changeStatus: true,
            isChecked: isChecked);
      },
    );
  }
}
