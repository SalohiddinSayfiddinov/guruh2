import 'package:guruh2/features/home/data/models/category_model.dart';
import 'package:guruh2/features/home/data/models/vendor_model.dart';

abstract class VendorsState {
  const VendorsState();
}

class VendorsInit extends VendorsState {
  const VendorsInit();
}

class VendorsLoading extends VendorsState {
  const VendorsLoading();
}

class VendorsError extends VendorsState {
  final String message;
  const VendorsError({required this.message});
}

class VendorsCategorySuccess extends VendorsState {
  final List<CategoryModel> categories;
  const VendorsCategorySuccess({required this.categories});
}

class VendorsSuccess extends VendorsState {
  final List<VendorModel> vendors;
  const VendorsSuccess({required this.vendors});
}
