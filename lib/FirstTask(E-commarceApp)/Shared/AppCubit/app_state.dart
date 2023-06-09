part of 'app_cubit.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class InitialCreateDataBase extends AppState {}

class CreateDataBase extends AppState {}

class OpenDataBase extends AppState {}

class InsertToDataBase extends AppState {}

class GetFromDataBase extends AppState {}

class GetFromScheduleTable extends AppState {}

class DataBaseLoading extends AppState {}

class ChangeStatus extends AppState {}

class UpdateTask extends AppState {}

class DeleteFromDataBase extends AppState {}

class ChangeAppMode extends AppState {}

class ChangeCheckBox extends AppState {}

class PickImageSuccessState extends AppState {}

class SortSuccessState extends AppState {}

class PickImageErrorState extends AppState {}
