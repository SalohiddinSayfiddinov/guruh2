import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/presentation/home/cubit/category_state.dart';
import 'package:guruh2/presentation/home/data/repo/category_repo.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryInit());

  Future<void> getCategories() async {
    emit(const CategoryLoading());
    try {
      final categories = await CategoryRepo().getCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryError(error: e.toString()));
    }
  }
}
