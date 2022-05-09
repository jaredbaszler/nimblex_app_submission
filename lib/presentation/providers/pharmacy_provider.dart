import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimblerx_app/data/models/medication.dart';
import 'package:nimblerx_app/data/models/pharmacy_details.dart';
import 'package:nimblerx_app/data/models/pharmacy_list.dart';
import 'package:nimblerx_app/data/repositories/pharmacy_data.dart';

final pharmacyDataProvider = Provider<PharmacyRepository>((ref) => PharmacyRepository());

final pharmacyListNotifierProvider =
    StateNotifierProvider<PharmacyListNotifier, AsyncValue<List<PharmacyListPharmacies?>>>(
  (ref) => PharmacyListNotifier(ref.read),
);

class PharmacyListNotifier extends StateNotifier<AsyncValue<List<PharmacyListPharmacies?>>> {
  PharmacyListNotifier(this.read, [AsyncValue<List<PharmacyListPharmacies?>>? pharmacies])
      : super(pharmacies ?? const AsyncValue.loading());
  Reader read;
  bool initialFill = false;
  AsyncValue<List<PharmacyListPharmacies?>>? previousState;
  late AsyncValue<List<PharmacyListPharmacies?>> initialState;

  Future<void> fillPharmacyList() async {
    if (initialFill) return;

    try {
      final pharmacies = AsyncValue.data(await read(pharmacyDataProvider).getAllPharmacies());
      initialState = pharmacies;
      state = pharmacies;
      initialFill = true;
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  void setMedsOrdered({required bool medsOrdered, required String? pharmacyId}) {
    state = state.whenData((a) {
      a.firstWhere((a) => a?.pharmacyId == pharmacyId)?.medsOrdered = medsOrdered;
      return a;
    });
  }
}

// final pharmacyDetailsProvider = FutureProvider.family<PharmacyDetails, String>(
//   (ref, pharmacyId) async => ref.read(pharmacyDataProvider).getPharmacyDetails(pharmacyId),
// );

final getPharmacyDetailsAllProvider = FutureProvider<List<PharmacyDetails>>(
  (ref) async => ref.read(pharmacyDataProvider).getPharmacyDetailsAll(),
);

final pharmacyDetailsNotifierProvider =
    StateNotifierProvider.family<PharmacyDetailNotifier, AsyncValue<PharmacyDetails>, String>(
  (ref, pharmacyId) => PharmacyDetailNotifier(ref.read, pharmacyId),
);

class PharmacyDetailNotifier extends StateNotifier<AsyncValue<PharmacyDetails>> {
  PharmacyDetailNotifier(this.read, this.pharmacyId, [AsyncValue<PharmacyDetails>? pharmacyDetail])
      : super(pharmacyDetail ?? const AsyncValue.loading());

  Reader read;
  String pharmacyId;
  AsyncValue<PharmacyDetails>? previousState;
  late AsyncValue<PharmacyDetails> initialState;

  Future<void> getDetails() async {
    try {
      final pharmacyDetail =
          AsyncValue.data(await read(pharmacyDataProvider).getPharmacyDetails(pharmacyId));
      initialState = pharmacyDetail;
      state = pharmacyDetail;
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  void setOrderedMedList({required String orderedMedList}) {
    state = state.whenData((a) {
      a.orderedMedList = orderedMedList;
      return a;
    });
  }
}

final medicationListNotifierProvider =
    StateNotifierProvider<MedicationListNotifier, AsyncValue<List<Medication>>>(
  (ref) => MedicationListNotifier(ref.read),
);

class MedicationListNotifier extends StateNotifier<AsyncValue<List<Medication>>> {
  MedicationListNotifier(this.read, [AsyncValue<List<Medication>>? medications])
      : super(medications ?? const AsyncValue.loading());

  Reader read;
  bool initialFill = false;
  AsyncValue<List<Medication>>? previousState;
  late AsyncValue<List<Medication>> initialState;

  Future<void> fillMedicationList() async {
    if (initialFill) return;

    try {
      final medList = AsyncValue.data(await read(pharmacyDataProvider).getAllMedications());
      initialState = medList;
      state = medList;
      initialFill = true;
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  void setIsSelected({required bool isSelected, required int index}) {
    state = state.whenData((a) {
      a[index].isSelected = isSelected;
      return a;
    });
  }
}
