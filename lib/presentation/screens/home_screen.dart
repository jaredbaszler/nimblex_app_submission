import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nimblerx_app/data/models/pharmacy_details.dart';
import 'package:nimblerx_app/presentation/providers/pharmacy_provider.dart';
import 'package:nimblerx_app/presentation/screens/order_screen.dart';
import 'package:nimblerx_app/presentation/screens/pharmacy_detail_screen.dart';
import 'package:nimblerx_app/presentation/widgets/nimble_app_bar.dart';
import 'package:nimblerx_app/utils/constants.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(pharmacyListNotifierProvider.notifier).fillPharmacyList();
    final pharmacyList = ref.watch(pharmacyListNotifierProvider);

    return pharmacyList.when(
      data: (pharmacies) => Scaffold(
        appBar: const NimbleAppBar(),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: pharmacies.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) =>
                            PharmacyDetailScreen(pharmacyId: pharmacies[index]?.pharmacyId ?? ''),
                      ),
                    ),
                    child: ListTile(
                      leading: ref
                                  .watch(pharmacyListNotifierProvider)
                                  .asData
                                  ?.value[index]
                                  ?.medsOrdered ==
                              true
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : null,
                      title: Text(
                        pharmacies[index]?.name ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  thickness: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  final allPharmDetails =
                      await ref.read(pharmacyDataProvider).getPharmacyDetailsAll();
                  double? closestDistance;
                  PharmacyDetails? closestPharmacyDetails;

                  for (final p in allPharmDetails) {
                    if (p.pharmacyDetailInfo?.address?.longitude == null ||
                        p.pharmacyDetailInfo?.address?.latitude == null) {
                      continue;
                    }
                    final distanceAway = Geolocator.distanceBetween(
                      defaultLatitude,
                      defaultLogitude,
                      p.pharmacyDetailInfo!.address!.latitude!,
                      p.pharmacyDetailInfo!.address!.longitude!,
                    );

                    if (closestDistance == null || closestDistance > distanceAway) {
                      closestDistance = distanceAway;
                      closestPharmacyDetails = p;
                    }
                  }

                  if (closestPharmacyDetails == null) {
                    await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: const Text('Error finding the nearest pharmacy'),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }

                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          OrderMedicationScreen(pharmacyDetails: closestPharmacyDetails),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'Order From Nearest Pharmacy',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, st) => kDebugMode
          ? Text('Error retrieving data for this page: ${error.toString()}; Stack Trace: $st')
          : const Text('An error occurred while retrieving data for this page.'),
    );
  }
}
