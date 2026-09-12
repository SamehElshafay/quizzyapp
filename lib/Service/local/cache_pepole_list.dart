// import 'package:hive/hive.dart';

// //   final List<ResultsModel> _peopleList = [];
// class CachePepoleList {
//   static CachePepoleList? _instance;
//   static CachePepoleList get instance => _instance ??= CachePepoleList._();
//   CachePepoleList._();

//   late Box<ResultsModel> myBox;

//   Future<void> init() async {
//     await Hive.openBox<ResultsModel>("peopleList");
//     myBox = Hive.box<ResultsModel>("peopleList");
//   }

//   List<ResultsModel> getPostsCache() {
//     return myBox.values.toList();
//   }

//   Future<void> udatePostsCache({required Iterable<ResultsModel> values}) async {
//     await myBox.addAll(values);
//   }

//   Future<void> clearAllPosts() async {
//     await myBox.clear();
//   }

//   void clearSinglton() {
//     _instance = null;
//   }
// }
