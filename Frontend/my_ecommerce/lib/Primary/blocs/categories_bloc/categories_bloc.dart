import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';
import 'package:my_ecommerce/Primary/data/repositories/category_repo.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final CategoryRepository categoryRepository =
        locator.get<CategoryRepository>();
    on<LoadCategories>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CategoriesLoading());
        await categoryRepository.fetchCategories().then((value) => value.fold(
            (l) => null, (categories) => emit(CategoriesLoaded(categories))));
      }
    });
  }
}
