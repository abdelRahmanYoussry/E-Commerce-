import 'package:ecommarce/FirstTask(E-commarceApp)/Shared/Componets/Unlity.dart';
import 'package:flutter/material.dart';

import '../Presentation/ProductDetails.dart';
import '../Shared/AppCubit/app_cubit.dart';
import '../Shared/Componets/Componets.dart';

class TasksWidget extends StatelessWidget {
  String taskName;
  bool isChecked;
  bool changeStatus;
  bool showBody;
  bool isFavourite;
  Function onChanged;
  Color checkBoxFillColor;
  Color checkColor;
  Color checkBorderColor;
  Color popUpMenuColor;
  Color taskColor;
  Color taskTitleColor;
  double height;
  Map model;

  TasksWidget({
    Key? key,
    required this.isChecked,
    required this.taskName,
    required this.onChanged,
    required this.changeStatus,
    required this.showBody,
    required this.checkBoxFillColor,
    required this.isFavourite,
    required this.checkColor,
    required this.height,
    required this.checkBorderColor,
    required this.popUpMenuColor,
    required this.taskColor,
    required this.taskTitleColor,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        height: 400,
        padding: const EdgeInsets.only(left: 5.0, right: 5, top: 5),
        decoration: BoxDecoration(
            color: taskColor, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: mediaQuery.width,
              height: mediaQuery.height / 5.5,
              child: Center(
                child: Column(
                  children: [
                    Utility.imageFromBase64String(model['image']),
                    // Container(
                    //   width: 200,
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image:
                    //               AssetImage('assets/image/delivery 3.png'))),
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      model['title'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          model['description'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Row(
                children: [
                  Text(
                    model['price'].toString() + r'$',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        model['discount'] + '%' + 'off',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (changeStatus == true)
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => checkBoxFillColor),
                        checkColor: checkColor,
                        splashRadius: 1,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        side: BorderSide(
                            style: BorderStyle.solid, color: checkBorderColor),
                        value: isChecked,
                        onChanged: (value) {
                          onChanged(value);
                          if (value == true) {
                            showToast(
                                text: 'Item add to Cart',
                                state: ToastState.Success);
                          } else {
                            showToast(
                                text: 'Item removed from Cart',
                                state: ToastState.Success);
                          }
                        }),
                  ),
                Spacer(),
                InkWell(
                    onTap: () {
                      AppCubit.get(context).deleteData(id: model['id']);
                    },
                    child: Icon(Icons.delete))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isFavourite == true
                    ? IconButton(
                        onPressed: () {
                          AppCubit.get(context)
                              .changeStatus(status: 'all', id: model['id']);
                          showToast(
                              text: 'Item removed from Favourite',
                              state: ToastState.Success);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ))
                    : IconButton(
                        onPressed: () {
                          AppCubit.get(context).changeStatus(
                              status: 'favourite', id: model['id']);
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.redAccent,
                          size: 30,
                        )),
                Spacer(),
                // SizedBox.expand(),
                InkWell(
                    onTap: () {
                      navigateTo(context,
                          widget: TaskDetailsScreen(
                            detailsModel: model,
                            taskColor: taskColor,
                          ));
                    },
                    child: model['status'] == 'unComplete'
                        ? Text(
                            'buy Again',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                        : Text(
                            'buy Now',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                SizedBox(
                  width: 5,
                ),
              ],
            )
          ],
        ),
      ),
      onLongPress: () {
        navigateTo(context,
            widget: TaskDetailsScreen(
              detailsModel: model,
              taskColor: taskColor,
            ));
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
