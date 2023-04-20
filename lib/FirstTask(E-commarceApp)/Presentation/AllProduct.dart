import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/AppCubit/app_cubit.dart';
import '../Widget/FullProductWidget.dart';

class AllTasksScreen extends StatelessWidget {
  AllTasksScreen({Key? key}) : super(key: key);
  bool isChecked = false;
  Color? taskColor;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  icon: Icon(
                    Icons.sort_sharp,
                    color: Colors.green,
                    size: 35,
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                        value: MenuItem.item1,
                        child: Container(
                          width: double.infinity,
                          height: mediaQuery.height / 20,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              'Price',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                    PopupMenuItem(
                        value: MenuItem.item2,
                        child: Container(
                          width: double.infinity,
                          height: mediaQuery.height / 20,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              'A-Z',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                    PopupMenuItem(
                        value: MenuItem.item3,
                        child: Container(
                          width: double.infinity,
                          height: mediaQuery.height / 20,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              'Date',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                  onSelected: (value) {
                    AppCubit.get(context).sortItem(value: value.toString());
                    print(value);
                  },
                ),
              ],
            ),
            Expanded(
              child: MyProductFullWidget(
                height: mediaQuery.height / 6,
                changeStatus: true,
                addTask: true,
                showBody: true,
                Taskslist: AppCubit.get(context).allProuduct,
                buttonHeight: mediaQuery.height / 16,
                isChecked: isChecked,
              ),
            ),
          ],
        );
      },
    );
  }
}

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}
