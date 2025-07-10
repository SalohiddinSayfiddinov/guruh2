import 'package:guruh2/features/home/data/models/category_model.dart';

abstract class CategoryState {
  const CategoryState();
}

class CategoryInit extends CategoryState {
  const CategoryInit();
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  const CategoryLoaded({required this.categories});
}

class CategoryError extends CategoryState {
  final String error;
  const CategoryError({required this.error});
}
