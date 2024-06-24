import 'package:dio/dio.dart';
import 'package:trying_storing/model/bird_model.dart';
import 'package:trying_storing/model/cat_model.dart';
import 'package:trying_storing/model/handle_model.dart';

abstract class Service {
  Dio req = Dio();
  late Response response;
  String baseurl = "https://freetestapi.com/api/v1/";
}

abstract class CatService extends Service {
  Future<ResultModel> getCat();
  Future<ResultModel> getAllCat();
}

class CatServiceImp extends CatService {
  CatModel? cat;

  List<CatModel> cats = [];

  @override
  Future<ResultModel> getCat() async {
    try {
      if (cat != null) {
        print("From Cache");
        return cat!;
      } else {
        print("From Server");
        response = await req.get(baseurl + 'cats/1');
        if (response.statusCode == 200) {
          cat = CatModel.fromMap(response.data);

          return cat!;
        } else {
          return ErrorModel(message: "There is no Internet");
        }
      }
    } catch (e) {
      return ExceptionModel(message: e.toString());
    }
  }

  @override
  Future<ResultModel> getAllCat() async {
    try {
      if (cats.isNotEmpty) {
        return ListOf(modelList: cats);
      } else {
        response = await req.get(baseurl + "cats");
        if (response.statusCode == 200) {
          return ListOf<CatModel>(
              modelList: List.generate(
            response.data.length,
            (index) => CatModel.fromMap(response.data[index]),
          ));
        } else {
          return ErrorModel(message: 'There Is a Problem');
        }
      }
    } catch (e) {
      return ExceptionModel(message: e.toString());
    }
  }
}

abstract class BirdService extends Service {
  Future<ResultModel> getAllBird();
}

// // class BirdServiceImp extends BirdService {
//   final Box<BirdModel> birdBox = Hive.box<BirdModel>('birdBox');
//   int currentIndex = 0;

//   @override
//   Future<ResultModel> getAllBird() async {
//     try {
//       if (birdBox.isNotEmpty) {
//         return ListOf<BirdModel>(modelList: _getBirdsFromCache());
//       } else {
//         response = await req.get(baseurl + "birds");
//         if (response.statusCode == 200) {
//           List<BirdModel> birds = List.generate(
//             response.data.length,
//             (index) => BirdModel.fromMap(response.data[index]),
//           );
//           await _storeBirdsToCache(birds);
//           return ListOf<BirdModel>(modelList: _getBirdsFromCache());
//         } else {
//           return ErrorModel(message: 'There Is a Problem');
//         }
//       }
//     } catch (e) {
//       return ExceptionModel(message: e.toString());
//     }
//   }

//   Future<void> _storeBirdsToCache(List<BirdModel> birds) async {
//     await birdBox.clear();
//     for (var bird in birds) {
//       await birdBox.add(bird);
//     }
//   }

//   List<BirdModel> _getBirdsFromCache() {
//     final List<BirdModel> birds = [];
//     for (int i = currentIndex; i < currentIndex + 5 && i < birdBox.length; i++) {
//       birds.add(birdBox.getAt(i)!);
//     }
//     currentIndex += 5;
//     if (currentIndex >= birdBox.length) {
//       currentIndex = 0;
//     }
//     return birds;
//   }
// }