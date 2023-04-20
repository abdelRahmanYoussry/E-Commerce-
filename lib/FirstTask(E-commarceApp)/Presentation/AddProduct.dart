import 'package:ecommarce/FirstTask(E-commarceApp)/Shared/AppCubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../Shared/Componets/Componets.dart';
import '../Shared/Componets/ElevatedButton.dart';
import '../Shared/Componets/TextFormField.dart';
import 'Board.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // late final LocalNotificationService service;
  DateTime? startDateTime;

  //new

  @override
  void initState() {
    // service = LocalNotificationService();
    // service.initialize();
    // listenToNotifications();
    // service.pendingNotification();
    // notifications.intializationNotification();
    super.initState();
  }

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var discountController = TextEditingController();
  var quantityController = TextEditingController();
  var dateController = TextEditingController();
  var imagePathController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: mediaQuery.height / 10,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0.0,
            title: const Text('Add Product'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Title',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle1!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextFormField(
                      textInputFormat: "[a-z A-Z0-9 ]",
                      labelColor: Colors.white,
                      enable: true,
                      onChanged: (value) {},
                      onTap: () {},
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Title Can't be Empty";
                        }
                        if (value.toString().length > 20) {
                          return "Title Can't be More than 20 character";
                        }
                        return null;
                      },
                      readOnly: false,
                      onSubmit: (value) {
                        value = titleController.text;
                      },
                      borderColor: Colors.grey[200]!,
                      backgroundColor: Colors.grey[200]!,
                      type: TextInputType.text,
                      hint: 'Product Title',
                      control: titleController,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      isPassword: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle1!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextFormField(
                      textInputFormat: "[a-z A-Z0-9 ]",
                      labelColor: Colors.white,
                      enable: true,
                      onChanged: (value) {},
                      onTap: () {},
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Product Details Can't be Empty";
                        }
                        return null;
                      },
                      readOnly: false,
                      onSubmit: (value) {
                        value = titleController.text;
                      },
                      borderColor: Colors.grey[200]!,
                      backgroundColor: Colors.grey[200]!,
                      type: TextInputType.text,
                      hint: 'Product description',
                      control: descriptionController,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      isPassword: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Price',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.subtitle1!.color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Quantity',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.subtitle1!.color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 4.3)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: MyTextFormField(
                            textInputFormat: "[a-z A-Z0-9 ]",
                            labelColor: Colors.white,
                            enable: true,
                            onChanged: (value) {},
                            suffix: Icons.monetization_on,
                            suffixIconColor: Colors.grey[400],
                            onTap: () {},
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Product price Details Can't be Empty";
                              }
                              return null;
                            },
                            readOnly: false,
                            onSubmit: (value) {
                              value = priceController.text;
                            },
                            borderColor: Colors.grey[200]!,
                            backgroundColor: Colors.grey[200]!,
                            type: TextInputType.text,
                            hint: 'price',
                            control: priceController,
                            textColor:
                                Theme.of(context).textTheme.subtitle1!.color!,
                            isPassword: false,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: MyTextFormField(
                            textInputFormat: "[a-z A-Z0-9 ]",
                            labelColor: Colors.white,
                            enable: true,
                            onChanged: (value) {},
                            onTap: () {},
                            suffix: Icons.calculate_outlined,
                            suffixIconColor: Colors.grey[400],
                            validator: (value) {
                              if (value.isEmpty) {
                                return "quantity Can't be Empty";
                              }
                              return null;
                            },
                            readOnly: false,
                            onSubmit: (value) {
                              value = quantityController.text;
                            },
                            borderColor: Colors.grey[200]!,
                            backgroundColor: Colors.grey[200]!,
                            type: TextInputType.text,
                            hint: 'Quantity',
                            control: quantityController,
                            textColor:
                                Theme.of(context).textTheme.subtitle1!.color!,
                            isPassword: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Discount',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.subtitle1!.color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Date',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.subtitle1!.color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 3.2)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: MyTextFormField(
                            textInputFormat: "[a-z A-Z0-9 ]",
                            labelColor: Colors.white,
                            enable: true,
                            suffix: Icons.discount,
                            suffixIconColor: Colors.grey[400],
                            onChanged: (value) {},
                            onTap: () {},
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Discount Can't be Empty";
                              }
                              return null;
                            },
                            readOnly: false,
                            onSubmit: (value) {
                              value = discountController.text;
                            },
                            borderColor: Colors.grey[200]!,
                            backgroundColor: Colors.grey[200]!,
                            type: TextInputType.text,
                            hint: 'Discount ',
                            control: discountController,
                            textColor:
                                Theme.of(context).textTheme.subtitle1!.color!,
                            isPassword: false,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: MyTextFormField(
                              textInputFormat: "[a-z A-Z0-9 ]",
                              labelColor: Colors.white,
                              enable: true,
                              onChanged: (value) {},
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2100-12-01'),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                  ;
                                }).catchError((error) {});
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "date Can't be Empty";
                                }
                                return null;
                              },
                              readOnly: true,
                              onSubmit: (value) {
                                value = dateController.text;
                              },
                              borderColor: Colors.grey[200]!,
                              backgroundColor: Colors.grey[200]!,
                              type: TextInputType.text,
                              hint: 'Date ',
                              control: dateController,
                              textColor:
                                  Theme.of(context).textTheme.subtitle1!.color!,
                              isPassword: false,
                              suffix: Icons.calendar_today,
                              suffixIconColor: Colors.grey[400]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (cubit.productImageFile != null)
                      MyTextFormField(
                        textInputFormat: "[a-z A-Z0-9 ]",
                        labelColor: Colors.white,
                        enable: false,
                        onChanged: (value) {},
                        onTap: () {},
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Product Details Can't be Empty";
                          }
                          return null;
                        },
                        readOnly: false,
                        onSubmit: (value) {},
                        borderColor: Colors.grey[200]!,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        type: TextInputType.text,
                        hint: 'Image Path',
                        control: imagePathController,
                        textColor:
                            Theme.of(context).textTheme.subtitle1!.color!,
                        isPassword: false,
                      ),
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: MyElevatedButton(
                            radius: 6,
                            borderWidth: 1,
                            textColor: Colors.white,
                            fontSize: 16,
                            borderColor: Colors.green,
                            height: mediaQuery.height / 16,
                            width: MediaQuery.of(context).size.width / 4,
                            onTap: () async {
                              cubit.pickAProfileImage();
                              setState(() {
                                imagePathController.text =
                                    cubit.productImageFile!.path.split('/')[7];
                                showToast(
                                    text: 'Image Has been Picked',
                                    state: ToastState.Success);
                              });
                            },
                            buttonName: 'Image',
                            buttonColor: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.height / 14,
                    ),
                    MyElevatedButton(
                        radius: 6,
                        borderWidth: 1,
                        textColor: Colors.white,
                        fontSize: 16,
                        borderColor: Colors.green,
                        height: mediaQuery.height / 16,
                        width: double.infinity,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            cubit.insertToDataBase(
                                title: titleController.text,
                                StartDate: dateController.text,
                                description: descriptionController.text,
                                price: int.parse(priceController.text),
                                discount: discountController.text,
                                image: cubit.imgString!,
                                quantity: int.parse(quantityController.text));

                            showToast(
                                text: 'remainingEndTimeFormat',
                                state: ToastState.Success);
                            navigateAndFinish(context, const BoardScreen());
                          }
                        },
                        buttonName: 'Create task',
                        buttonColor: Colors.green)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

// void listenToNotifications() =>
// service.onNotificationClick.listen(onNotificationsListener);

// void onNotificationsListener(String? payload) {
//   if (payload != null && payload.isNotEmpty) {
//     debugPrint("payLoad   $payload");
//     navigateTo(context, widget: ScheduleScreen());
//   }
// }
}
