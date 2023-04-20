import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

import '../Componets/Unlity.dart';
import '../Local/cash_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;
  int? productId;
  bool isChecked = false;
  int? differenceDaysMinutes;
  int? differenceDaysSeconds;
  List<Map> allProuduct = [];
  List<Map> completeProuduct = [];
  List<Map> unCompleteProuduct = [];
  List<Map> favouriteProuduct = [];
  List<Map> scheduleProuduct = [];

  void changeCheckBox(bool checked) {
    isChecked = checked;
    emit(ChangeCheckBox());
  }

  void createDataBase() {
    openDatabase(
      'CommerceNew.db',
      version: 4,
      onCreate: (database, version) {
        debugPrint("database has created");
        //CREATE TABLE CommerceNew (id INTEGER PRIMARY KEY,title TEXT,endDate TEXT,endTime TEXT,status TEXT,startTime TEXT,reminder TEXT,body TEXT,'
        //   //               'remainingMinutes INTEGER,remainingHours INTEGER,remainingDays INTEGER,startDate Text)')
        database
            .execute(
                'CREATE TABLE CommerceNew (id INTEGER PRIMARY KEY,title TEXT,status TEXT,description TEXT,'
                'price INTEGER,discount Text,quantity INTEGER,startDate Text,image Text)')
            .then((value) {
          debugPrint("Table has created");
        }).catchError((error) {
          debugPrint("error is : ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        debugPrint("database has opened");
      },
    ).then((value) {
      database = value;
      emit(CreateDataBase());
    });
  }

  // Future<int> daysBetween(DateTime from, DateTime to) async {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   int resultInMinutes;
  //   int resultInSecond;
  //   resultInMinutes = (to.difference(from).inHours / 24).round();
  //   resultInSecond = (to.difference(from).inSeconds).round();
  //   differenceDaysMinutes = resultInMinutes;
  //   differenceDaysSeconds = resultInSecond;
  //   debugPrint('${differenceDaysMinutes} Dayessssssssssssssssssss in minutes');
  //   debugPrint('${differenceDaysSeconds} Dayessssssssssssssssssss in Seconds');
  //   return resultInMinutes;
  // }
  //
  // Future<int> hoursBetween(DateTime from, DateTime to) async {
  //   from = DateTime(
  //     from.hour,
  //     from.minute,
  //   );
  //   to = DateTime(
  //     to.hour,
  //     to.minute,
  //   );
  //   int result;
  //   result = (to.difference(from).inMinutes).round();
  //   debugPrint('${result} Hoursssssssssssssss');
  //   return result;
  // }
  //
  // String differenceFormattedString(int minute) {
  //   try {
  //     DateTime now = DateTime.now();
  //     Duration difference = Duration(minutes: minute);
  //     final today =
  //         DateTime(now.year).add(difference).subtract(const Duration(days: 1));
  //     var result = '${today.day} Days ${today.hour} Hours ${today.minute} Min';
  //     debugPrint(result);
  //     return '${today.day} Days ${today.hour} Hours ${today.minute} Min';
  //   } catch (e) {
  //     return '';
  //   }
  // }

  insertToDataBase({
    required String title,
    required String StartDate,
    required String description,
    required String image,
    required int price,
    required String discount,
    required int quantity,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO CommerceNew(title , status , description , price , discount , quantity , startDate, image ) '
              'VALUES( "$title", "all", "$description" , "$price" , "$discount" , "$quantity" , "$StartDate" , "$image")')
          .then((value) async {
        debugPrint("$value inserted successfully");
        // debugPrint("$value [id]");
        await getDataFromDataBase(database);

        emit(InsertToDataBase());
      }).catchError((onError) {
        debugPrint('The Error while insert is ${onError.toString()}');
      });
    });
  }

  Future<void> getDataFromDataBase(dataBase) async {
    allProuduct = [];
    completeProuduct = [];
    favouriteProuduct = [];
    unCompleteProuduct = [];
    dataBase.rawQuery('SELECT * FROM CommerceNew').then((value) {
      value.forEach((element) async {
        debugPrint(element['status'] + '======>status');
        allProuduct.add(element);
        // debugPrint('${element['id']}   this is Id');
        productId = element['id'];
        debugPrint('$productId   this is productId');
        // debugPrint('${element['title']}   this is title');
        if (element['status'] == 'complete') {
          completeProuduct.add(element);
        } else if (element['status'] == 'unComplete') {
          unCompleteProuduct.add(element);
        } else if (element['status'] == 'favourite') {
          favouriteProuduct.add(element);
        } else if (element['status'] == 'all') {
          if (allProuduct.contains(element['id'])) {
            allProuduct.add(element);
          }
        }
        // debugPrint(element['status']);
      });
      emit(GetFromDataBase());
    });
  }

  void getDateToScheduleTable(dataBase, {required String date}) {
    scheduleProuduct.clear();
    dataBase.rawQuery(
        'SELECT * FROM CommerceNew WHERE startDate = ?', [date]).then((value) {
      value.forEach((element) {
        // debugPrint(element['date']+'abbbbbbbbbbbbbbbbbbbbb');
        if (element['startDate'] == date) {
          scheduleProuduct.add(element);
          // debugPrint(element['schedule table']);
        }
      });

      emit(GetFromScheduleTable());
    });
  }

  void changeStatus({required String status, required int id}) {
    database.rawUpdate('UPDATE CommerceNew SET status = ? WHERE id = ?',
        [status, id]).then((value) {
      debugPrint(value.toString());
      getDataFromDataBase(database);
      // getDateToScheduleTable(database, date: DateFormat.yMMMd().format(DateTime.now()));
      emit(ChangeStatus());
    });
  }

  Future<void> updateData({
    required String title,
    required String description,
    required String startTime,
    required String endTime,
    required String reminder,
    required String endDate,
    required String startDate,
    required int id,
    required int price,
    required int discount,
    required int quantity,
  }) async {
    await database.rawUpdate(
        'UPDATE CommerceNew SET title = ?, description = ?, startTime = ?, endTime = ?, reminder = ? , endDate = ? , price = ? , discount = ? , quantity = ? , startDate = ? WHERE id = ?',
        [
          title,
          description,
          startTime,
          endTime,
          reminder,
          endDate,
          price,
          discount,
          quantity,
          startDate,
          id
        ]).then((value) async {
      debugPrint(value.toString());
      await getDataFromDataBase(database);
      emit(UpdateTask());
    });
  }

  void deleteData({required int id}) {
    database
        .rawDelete('DELETE FROM CommerceNew WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(DeleteFromDataBase());
    });
  }

  bool isDark = false;
  void changeDarkMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;

      emit(ChangeAppMode());
    } else {
      isDark = !isDark;
      CashHelper.putBool(key: 'isDark', value: isDark).then((value) {
        debugPrint(isDark.toString());
        emit(ChangeAppMode());
      });
    }
  }

  File? productImageFile;
  var picker = ImagePicker();
  String? imgString;
  // pickImageFromGallery() {
  //   ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) async {
  //     String imgString = Utility.base64String(await imgFile!.readAsBytes());
  //     print(imgString);
  //     photo photo1 = photo(0, imgString);
  //     cash.save(photo1);
  //     refreshImages();
  //   });
  // }
  Future pickAProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      productImageFile = File(pickedFile.path);
      imgString = Utility.base64String(await productImageFile!.readAsBytes());
      print(pickedFile.path.toString());
      emit(PickImageSuccessState());
    } else {
      print('No Image Selected');
      emit(PickImageErrorState());
    }
  }

  void sortItem({required String value}) {
    switch (value) {
      case 'MenuItem.item2':
        allProuduct.sort(
            (a, b) => a['title'].toString().compareTo(b['title'].toString()));
        allProuduct.forEach((element) {
          print(element['title']);
        });
        break;
      case 'MenuItem.item1':
        allProuduct.sort(
            (a, b) => a['price'].toString().compareTo(b['price'].toString()));
        allProuduct.forEach((element) {
          print(element['price']);
        });
        break;
      case 'MenuItem.item3':
        allProuduct.sort((a, b) =>
            a['startDate'].toString().compareTo(b['startDate'].toString()));
        allProuduct.forEach((element) {
          print(element['startDate']);
        });
        break;
    }

    emit(SortSuccessState());
  }
}
