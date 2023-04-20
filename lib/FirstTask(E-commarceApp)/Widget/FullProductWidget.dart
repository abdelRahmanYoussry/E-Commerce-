import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../Presentation/AddProduct.dart';
import '../Shared/AppCubit/app_cubit.dart';
import '../Shared/Componets/Componets.dart';
import '../Shared/Componets/ElevatedButton.dart';
import 'Divider.dart';
import 'ProductWidget.dart';

class MyTaskFullWidget extends StatelessWidget {
  Color taskColor = Colors.red;
  double height;
  double buttonHeight;
  List<Map> Taskslist;
  bool isChecked;
  bool addTask;
  bool changeStatus;
  bool showBody;
  bool isFavourite = false;

  MyTaskFullWidget({
    Key? key,
    required this.height,
    required this.Taskslist,
    required this.buttonHeight,
    required this.isChecked,
    required this.changeStatus,
    required this.showBody,
    required this.addTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ConditionalBuilder(
            builder: (context) => ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (Taskslist[index]['status'] == 'complete') {
                    taskColor = Colors.green;
                    isFavourite = false;
                  } else if (Taskslist[index]['status'] == 'unComplete' ||
                      Taskslist[index]['status'] == 'all') {
                    taskColor = Colors.red;
                    isFavourite = false;
                  } else if (Taskslist[index]['status'] == 'favourite') {
                    taskColor = Colors.blue;
                    // taskColor=taskColor;
                    isFavourite = true;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: TasksWidget(
                        model: Taskslist[index],
                        height: height,
                        showBody: showBody,
                        isFavourite: isFavourite,
                        changeStatus: changeStatus,
                        isChecked: Taskslist[index]['status'] == 'complete'
                            ? true
                            : false,
                        popUpMenuColor: Theme.of(context).backgroundColor,
                        taskTitleColor: Colors.white,
                        checkBorderColor: Colors.white,
                        taskName: Taskslist[index]['title'],
                        taskColor: taskColor,
                        onChanged: (value) {
                          isChecked = true;
                          if (value == true) {
                            AppCubit.get(context).changeStatus(
                                status: 'complete', id: Taskslist[index]['id']);
                          } else {
                            AppCubit.get(context).changeStatus(
                                status: 'unComplete',
                                id: Taskslist[index]['id']);
                          }
                        },
                        checkBoxFillColor: Colors.white,
                        checkColor: Colors.black),
                  );
                },
                separatorBuilder: (context, index) => const MyDivider(),
                itemCount: Taskslist.length),
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 100,
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                  Text(
                    'No Product Yet Please add Some Products',
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.subtitle1!.color,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            condition: Taskslist.isNotEmpty,
          ),
        ),
        if (addTask == true)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyElevatedButton(
                radius: 6,
                borderWidth: 1,
                textColor: Colors.white,
                fontSize: 16,
                borderColor: Colors.green,
                height: buttonHeight,
                width: double.infinity,
                onTap: () {
                  navigateTo(context, widget: AddProductScreen());
                },
                buttonName: 'Add Product',
                buttonColor: Colors.green),
          )
      ],
    );
  }
}
