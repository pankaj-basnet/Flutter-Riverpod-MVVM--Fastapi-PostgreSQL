 
import 'package:trekkingmap/features/home/models/product_model.dart';
 import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trekkingmap/features/home/repositories/home_repository.dart';
part 'home_viewmodel.g.dart';

@riverpod
Future<List<ProductModel>> getAllProducts(GetAllProductsRef ref) async {
   
  final res = await ref.watch(homeRepositoryProvider).getAllProducts( );

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}
 

// @riverpod
// class HomeViewModel extends _$HomeViewModel {
//   late HomeRepository _homeRepository;
 
//   @override
//   AsyncValue? build() {
//     // _homeRepository = ref.watch(homeRepositoryProvider);
//      return null;
//   }
 
// }
