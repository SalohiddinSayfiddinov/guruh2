import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/presentation/home/cubit/vendors/vendors_state.dart';
import 'package:guruh2/presentation/home/data/repo/vendor_repo.dart';

class VendorsCategoriesCubit extends Cubit<VendorsState> {
  VendorsCategoriesCubit() : super(const VendorsInit());

  Future<void> getVendorCategories() async {
    emit(const VendorsLoading());

    try {
      final categories = await VendorRepo().getVendorCategories();
      emit(VendorsCategorySuccess(categories: categories));
    } catch (e) {
      emit(VendorsError(message: e.toString()));
    }
  }
}
