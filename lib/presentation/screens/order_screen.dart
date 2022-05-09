import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimblerx_app/data/models/pharmacy_details.dart';
import 'package:nimblerx_app/presentation/providers/pharmacy_provider.dart';
import 'package:nimblerx_app/presentation/widgets/nimble_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderMedicationScreen extends ConsumerWidget {
  const OrderMedicationScreen({required this.pharmacyDetails, Key? key}) : super(key: key);

  final PharmacyDetails? pharmacyDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(medicationListNotifierProvider.notifier).fillMedicationList();
    final medications = ref.watch(medicationListNotifierProvider);

    return medications.when(
      data: (medList) => Scaffold(
        appBar: const NimbleAppBar(),
        body: pharmacyDetails?.orderedMedList?.isNotEmpty == true
            ? Column(
                children: [
                  Text(
                    'We are sorry, you may place only one order at a time per pharmacy. '
                    'You have the following meds currently on order at '
                    '${pharmacyDetails?.pharmacyDetailInfo?.name}: \n '
                    '${pharmacyDetails?.orderedMedList}',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        'BACK',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select meds to order from ${pharmacyDetails?.pharmacyDetailInfo?.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                            ref.watch(medicationListNotifierProvider).asData?.value[index].name ??
                                '',
                          ),
                          value: ref
                              .watch(medicationListNotifierProvider)
                              .asData
                              ?.value[index]
                              .isSelected,
                          onChanged: (val) => ref
                              .read(medicationListNotifierProvider.notifier)
                              .setIsSelected(isSelected: val == true, index: index),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 2,
                      ),
                      itemCount: medList.length,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Selected Meds:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Row(
                    children: [
                      // TODO: get the med list to use the entire width of the row
                      Expanded(
                        child: Text(
                          ref
                                  .watch(medicationListNotifierProvider)
                                  .asData
                                  ?.value
                                  .where((a) => a.isSelected)
                                  .map((e) => e.name)
                                  .join(', ') ??
                              '',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            final medList = ref
                                    .watch(medicationListNotifierProvider)
                                    .asData
                                    ?.value
                                    .where((a) => a.isSelected)
                                    .map((e) => e.name)
                                    .join(', ') ??
                                '';
                            await prefs.setString(
                              pharmacyDetails?.pharmacyDetailInfo?.id ?? 'No Name Pharmacy',
                              medList,
                            );

                            ref.read(pharmacyListNotifierProvider.notifier).setMedsOrdered(
                                  medsOrdered: true,
                                  pharmacyId: pharmacyDetails?.pharmacyDetailInfo?.id,
                                );

                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(14),
                            child: Text(
                              'Submit Order',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, st) => kDebugMode
          ? Text('Error retrieving the pharmacy list: ${error.toString()}; Stack Trace: $st')
          : const Text('An error occurred while retrieving the pharmacy list.'),
    );
  }
}
