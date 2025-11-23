// import 'package:hive_flutter/adapters.dart';

// class HiveDatabase {
//   HiveDatabase._();

//   static final HiveDatabase instance = HiveDatabase._();

//   factory HiveDatabase() => instance;

//   Box<PopularMoviesModel>? moviesBox;
//   Box<String>? moviesCacheTimeBox;

//   Future<void> setup() async {
//     await Hive.initFlutter();

//     Hive
//       ..registerAdapter(PopularMoviesModelAdapter())
//       ..registerAdapter(MoviesResultAdapter());

//     moviesBox = await Hive.openBox<PopularMoviesModel>('moviesBox');
//     moviesCacheTimeBox = await Hive.openBox<String>('moviesCacheTimeBox');
//   }

//   Future<void> clearAllBoxs() async {
//     await moviesBox!.clear();
//     await moviesCacheTimeBox!.clear();
//   }
// }
