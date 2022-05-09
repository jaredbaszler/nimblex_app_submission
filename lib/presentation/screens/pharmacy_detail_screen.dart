import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nimblerx_app/presentation/providers/pharmacy_provider.dart';
import 'package:nimblerx_app/presentation/widgets/nimble_app_bar.dart';
import 'package:nimblerx_app/utils/constants.dart';

class PharmacyDetailScreen extends ConsumerWidget {
  const PharmacyDetailScreen({required this.pharmacyId, Key? key}) : super(key: key);

  final String pharmacyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(pharmacyDetailsNotifierProvider(pharmacyId).notifier).getDetails();
    final pharmacyDetails = ref.watch(pharmacyDetailsNotifierProvider(pharmacyId));

    return pharmacyDetails.when(
      data: (data) => Scaffold(
        appBar: const NimbleAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: nimbleTeal,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        data.pharmacyDetailInfo?.name?.toUpperCase() ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ADDRESS',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(data.pharmacyDetailInfo?.address?.streetAddress1 ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          '${data.pharmacyDetailInfo?.address?.city}, '
                          '${data.pharmacyDetailInfo?.address?.usTerritory} '
                          '${data.pharmacyDetailInfo?.address?.postalCode}',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'PHONE',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      // TODO(jaredbaszler): do a better job of displaying the raw phone number
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(data.pharmacyDetailInfo?.primaryPhoneNumber ?? '----'),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'HOURS',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          // replaces new line characters and the spaces around
                          // them with actual new line charcters
                          // TODO(jaredbaszler): replaes 9:00a with 9:00am to be more consistent across all pharmacies
                          data.pharmacyDetailInfo?.pharmacyHours
                                  ?.replaceAll(RegExp(r'(\s*\\n\s*)'), '\n') ??
                              'None Available',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Medications On Order',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          // TODO(jaredbaszler): replaes 9:00a with 9:00am to be more consistent across all pharmacies
                          data.orderedMedList ?? 'NONE',
                        ),
                      ),
                    ],
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
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        'CLOSE',
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
          ? Text('Error retrieving data for this page: ${error.toString()}; Stack Trace: $st')
          : const Text('An error occurred while retrieving data for this page.'),
    );
  }
}
