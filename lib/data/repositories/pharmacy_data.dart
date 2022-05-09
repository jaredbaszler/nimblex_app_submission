import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:nimblerx_app/data/models/medication.dart';
import 'package:nimblerx_app/data/models/pharmacy_details.dart';
import 'package:nimblerx_app/data/models/pharmacy_list.dart';
import 'package:nimblerx_app/data/repositories/pharmacy_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PharmacyRepository implements IPharmacyRepository {
  @override
  Future<List<Medication>> getAllMedications() async {
    final response = await get(
      Uri.parse(
        'https://s3-us-west-2.amazonaws.com/assets.nimblerx.com/prod/medicationListFromNIH/medicationListFromNIH.txt',
      ),
    );

    final listOfMeds = response.body.split(',');
    return listOfMeds.map((med) => Medication(name: med)).toList();
  }

  @override
  Future<List<PharmacyListPharmacies?>> getAllPharmacies() async {
    final pharmacyList = PharmacyList.fromJson(
      jsonDecode(await rootBundle.loadString('assets/data/pharmacy_list.json'))
          as Map<String, dynamic>,
    );

    // Check if an order has been placed at this pharmacy
    final pharmacies = pharmacyList.pharmacies ?? <PharmacyListPharmacies>[];
    final prefs = await SharedPreferences.getInstance();

    for (final p in pharmacies) {
      p.medsOrdered = prefs.getString(p.pharmacyId ?? '')?.isNotEmpty == true;
    }

    return pharmacies;
  }

  @override
  Future<List<PharmacyDetails>> getPharmacyDetailsAll() async {
    final allPharmacies = await getAllPharmacies();

    final allDetails = <PharmacyDetails>[];

    for (final pharmacy in allPharmacies) {
      allDetails.add(await getPharmacyDetails(pharmacy?.pharmacyId ?? ''));
    }

    return allDetails;
  }

  @override
  Future<PharmacyDetails> getPharmacyDetails(String pharmacyId) async {
    final response =
        await get(Uri.parse('https://api-qa-demo.nimbleandsimple.com/pharmacies/info/$pharmacyId'));

    final pharmacyDetails =
        PharmacyDetails.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    // check if there have been any meds ordered here
    final prefs = await SharedPreferences.getInstance();
    pharmacyDetails.orderedMedList = prefs.getString(pharmacyId);

    return pharmacyDetails;
  }
}
