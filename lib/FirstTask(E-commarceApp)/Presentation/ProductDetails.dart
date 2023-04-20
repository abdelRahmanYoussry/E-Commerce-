import 'package:ecommarce/FirstTask(E-commarceApp)/Presentation/Board.dart';
import 'package:ecommarce/FirstTask(E-commarceApp)/Shared/Componets/Componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../Shared/AppCubit/app_cubit.dart';
import '../Shared/Componets/ElevatedButton.dart';
import '../Shared/Componets/PaymentCardWidget.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Map detailsModel;
  Color taskColor;

  TaskDetailsScreen(
      {Key? key, required this.detailsModel, required this.taskColor})
      : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  int? totalMinutes;

  int? totalSeconds;

  bool reminderFinish = false;

  int totalMinutesPerDay = 1440;
  final _paymentCard = PaymentCard();
  var numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DateTime? dateTime;
    DateFormat formatDate = DateFormat("yMMMd");
    DateFormat finalFormatDate = DateFormat("yMMd HH:mm a");
    var mediaQuery = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            toolbarHeight: mediaQuery.height / 10,
            title: const Text('Task Details'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: mediaQuery.height / 2,
                decoration: BoxDecoration(
                  color: widget.taskColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 10, right: 10, top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.detailsModel['startDate']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Created Date',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${widget.detailsModel['title']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.detailsModel['description']}',
                              maxLines: 6,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.detailsModel['price']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${widget.detailsModel['discount'] + '%'}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.discount,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Visibility(
                        visible: true,
                        child: MyElevatedButton(
                          radius: 10,
                          borderWidth: 1,
                          textColor: Colors.white,
                          fontSize: 16,
                          borderColor:
                              widget.detailsModel['status'] == "complete"
                                  ? Colors.red
                                  : Colors.green,
                          height: mediaQuery.height / 20,
                          width: double.infinity,
                          buttonColor:
                              widget.detailsModel['status'] == "complete"
                                  ? Colors.red
                                  : Colors.green,
                          onTap: () {
                            showMyBottomSheet(context: context);
                          },
                          buttonName: 'Buy Now',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  showMyBottomSheet({required BuildContext context}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 3),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      filled: true,
                      icon: Icon(
                        Icons.person_outline_sharp,
                        size: 40.0,
                        color: Colors.grey,
                      ),
                      hintText: 'card Holder name ',
                      labelText: 'card Holder name',
                    ),
                    onSaved: (String? value) {
                      // _card.name = value;
                    },
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                        value!.isEmpty ? 'Please insert card name' : null,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      // CardNumberInputFormatter()
                    ],
                    controller: numberController,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 3),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      icon: CardUtils.getCardIcon(_paymentCard.type),
                      hintText: 'cardNumberLabelText',
                      labelText: "cardNumber",
                    ),
                    onSaved: (String? value) {
                      _paymentCard.number = CardUtils.getCleanedNumber(value!);
                    },
                    validator: CardUtils.validateCardNum,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 100,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 3),
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            filled: true,
                            icon: Image.asset(
                              'assets/image/card_cvv.png',
                              width: 40.0,
                              color: Colors.grey,
                            ),
                            hintText: 'cvvCardNumber',
                            labelText: 'CVV',
                          ),
                          validator: CardUtils.validateCVV,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            _paymentCard.cvv = int.parse(value!);
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.80,
                        height: 100,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            // CardMonthInputFormatter()
                          ],
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 3),
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            filled: true,
                            icon: Image.asset(
                              'assets/image/calender.png',
                              width: 40.0,
                              color: Colors.grey,
                            ),
                            hintText: 'MM/YY',
                            labelText: 'expiryDate',
                          ),
                          validator: CardUtils.validateDate,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            List<int> expiryDate =
                                CardUtils.getExpiryDate(value!);
                            _paymentCard.month = expiryDate[0];
                            _paymentCard.year = expiryDate[1];
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  MyElevatedButton(
                    height: MediaQuery.of(context).size.height / 15,
                    width: 80,
                    radius: 20,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        AppCubit.get(context).changeStatus(
                            status: 'unComplete',
                            id: widget.detailsModel['id']);
                        showToast(
                            text: 'Item has been Bought',
                            state: ToastState.Success);
                        navigateAndFinish(context, BoardScreen());
                      }
                    },
                    buttonName: 'Buy',
                    buttonColor: Colors.red,
                    borderColor: Colors.red,
                    borderWidth: 2,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
