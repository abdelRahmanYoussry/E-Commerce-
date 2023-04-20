import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'FirstTask(E-commarceApp)/Presentation/Board.dart';
import 'FirstTask(E-commarceApp)/Shared/AppCubit/BlocObserver.dart';
import 'FirstTask(E-commarceApp)/Shared/AppCubit/app_cubit.dart';
import 'FirstTask(E-commarceApp)/Shared/Local/cash_helper.dart';
import 'FirstTask(E-commarceApp)/Style/Themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  bool? isDark;
  if (CashHelper.getData(key: 'isDark') == null) {
    isDark = false;
  } else {
    isDark = CashHelper.getData(key: 'isDark');
  }

  runApp(MyApp(
    isDark: isDark!,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({Key? key, required this.isDark}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..createDataBase()
              ..changeDarkMode(fromShared: isDark)),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TaskAway',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: BoardScreen(),
            navigatorKey: navigatorKey,
          );
        },
      ),
    );
  }
}
