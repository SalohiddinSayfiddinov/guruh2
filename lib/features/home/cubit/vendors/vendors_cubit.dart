import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/features/home/cubit/vendors/vendors_state.dart';
import 'package:guruh2/features/home/data/repo/vendor_repo.dart';

class VendorsCubit extends Cubit<VendorsState> {
  VendorsCubit() : super(const VendorsInit());

  Future<void> getVendors({String? category}) async {
    emit(const VendorsLoading());
    try {
      final vendors = await VendorRepo().getVendors(category: category);
      emit(VendorsSuccess(vendors: vendors));
    } catch (e) {
      emit(VendorsError(message: e.toString()));
    }
  }
}
