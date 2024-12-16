import 'dart:convert';
 
import 'package:trekkingmap/core/constants/server_constant.dart';
import 'package:trekkingmap/core/failure/failure.dart';
import 'package:trekkingmap/features/home/models/product_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
   

  Future<Either<AppFailure, List<ProductModel>>> getAllProducts( ) async {
    try {

        final res = await http
          .get(Uri.parse('${ServerConstant.serverURL}/product/'), headers: {
        'Content-Type': 'application/json'
      
      });
       
      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(AppFailure(resBodyMap['detail']));
      }
      resBodyMap = resBodyMap as List;

      List<ProductModel> products = [];

      for (final map in resBodyMap) {
        products.add(ProductModel.fromMap(map));
      }

      return Right(products);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

}
 