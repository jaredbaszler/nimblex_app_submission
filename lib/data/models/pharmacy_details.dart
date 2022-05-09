class PharmacyDetails {
/*
{
  "responseCode": "20063012",
  "href": "https://api-qa-demo.nimbleandsimple.com/pharmacies/info/NRxPh-HLRS",
  "details": "Retrieved NimbleRx Pharmacy",
  "generatedTs": "2022-05-05T02:29:57.695359Z",
  "value": {
    "id": "NRxPh-HLRS",
    "pharmacyChainId": "PhChn-hWwRhN7pLR",
    "name": "ReCept",
    "active": false,
    "localId": "d_recept",
    "testPharmacy": false,
    "address": {
      "streetAddress1": "605 1ST AVE",
      "city": "SEATTLE",
      "usTerritory": "WA",
      "postalCode": "98104",
      "latitude": 47.60174179077148,
      "longitude": -122.33425903320312,
      "addressType": "C",
      "externalId": "Addr-yYVetVOpBZ",
      "isValid": true,
      "googlePlaceId": "ChIJi51MqbpqkFQRyfZ91NrbYPg"
    },
    "primaryPhoneNumber": "+12062841353",
    "defaultTimeZone": null,
    "pharmacistInCharge": null,
    "postalCodes": null,
    "deliverableStates": [
      "WA"
    ],
    "pharmacyHours": "9:00am-7:00pm Mon-Fri \\n  9:00a - 5:00p Sat \\n 10:00a- 5:00p Sun",
    "deliverySubsidyAmount": null,
    "pharmacySystem": "PnrRx",
    "acceptInvalidAddress": false,
    "pharmacyType": "P",
    "pharmacyLoginCode": null,
    "marketplacePharmacy": true,
    "checkoutPharmacy": false,
    "importActive": true
  }
} 
*/
  PharmacyDetails({
    this.responseCode,
    this.href,
    this.details,
    this.generatedTs,
    this.pharmacyDetailInfo,
    this.orderedMedList = '',
  });
  PharmacyDetails.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode']?.toString();
    href = json['href']?.toString();
    details = json['details']?.toString();
    generatedTs = json['generatedTs']?.toString();
    pharmacyDetailInfo = (json['value'] != null && (json['value'] is Map))
        ? PharmacyDetailInfo.fromJson(json['value'] as Map<String, Object?>)
        : null;
  }

  String? responseCode;
  String? href;
  String? details;
  String? generatedTs;
  PharmacyDetailInfo? pharmacyDetailInfo;
  String? orderedMedList;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['responseCode'] = responseCode;
    data['href'] = href;
    data['details'] = details;
    data['generatedTs'] = generatedTs;
    if (pharmacyDetailInfo != null) {
      data['value'] = pharmacyDetailInfo!.toJson();
    }
    return data;
  }
}

class PharmacyAddress {
/*
{
  "streetAddress1": "605 1ST AVE",
  "city": "SEATTLE",
  "usTerritory": "WA",
  "postalCode": "98104",
  "latitude": 47.60174179077148,
  "longitude": -122.33425903320312,
  "addressType": "C",
  "externalId": "Addr-yYVetVOpBZ",
  "isValid": true,
  "googlePlaceId": "ChIJi51MqbpqkFQRyfZ91NrbYPg"
} 
*/
  PharmacyAddress({
    this.streetAddress1,
    this.city,
    this.usTerritory,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.addressType,
    this.externalId,
    this.isValid,
    this.googlePlaceId,
  });
  PharmacyAddress.fromJson(Map<String, dynamic> json) {
    streetAddress1 = json['streetAddress1']?.toString();
    city = json['city']?.toString();
    usTerritory = json['usTerritory']?.toString();
    postalCode = json['postalCode']?.toString();
    latitude = double.tryParse(json['latitude']?.toString() ?? '');
    longitude = double.tryParse(json['longitude']?.toString() ?? '');
    addressType = json['addressType']?.toString();
    externalId = json['externalId']?.toString();
    isValid = json['isValid'] as bool?;
    googlePlaceId = json['googlePlaceId']?.toString();
  }

  String? streetAddress1;
  String? city;
  String? usTerritory;
  String? postalCode;
  double? latitude;
  double? longitude;
  String? addressType;
  String? externalId;
  bool? isValid;
  String? googlePlaceId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['streetAddress1'] = streetAddress1;
    data['city'] = city;
    data['usTerritory'] = usTerritory;
    data['postalCode'] = postalCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['addressType'] = addressType;
    data['externalId'] = externalId;
    data['isValid'] = isValid;
    data['googlePlaceId'] = googlePlaceId;
    return data;
  }
}

class PharmacyDetailInfo {
/*
{
  "id": "NRxPh-HLRS",
  "pharmacyChainId": "PhChn-hWwRhN7pLR",
  "name": "ReCept",
  "active": false,
  "localId": "d_recept",
  "testPharmacy": false,
  "address": {
    "streetAddress1": "605 1ST AVE",
    "city": "SEATTLE",
    "usTerritory": "WA",
    "postalCode": "98104",
    "latitude": 47.60174179077148,
    "longitude": -122.33425903320312,
    "addressType": "C",
    "externalId": "Addr-yYVetVOpBZ",
    "isValid": true,
    "googlePlaceId": "ChIJi51MqbpqkFQRyfZ91NrbYPg"
  },
  "primaryPhoneNumber": "+12062841353",
  "defaultTimeZone": null,
  "pharmacistInCharge": null,
  "postalCodes": null,
  "deliverableStates": [
    "WA"
  ],
  "pharmacyHours": "9:00am-7:00pm Mon-Fri \\n  9:00a - 5:00p Sat \\n 10:00a- 5:00p Sun",
  "deliverySubsidyAmount": null,
  "pharmacySystem": "PnrRx",
  "acceptInvalidAddress": false,
  "pharmacyType": "P",
  "pharmacyLoginCode": null,
  "marketplacePharmacy": true,
  "checkoutPharmacy": false,
  "importActive": true
} 
*/
  PharmacyDetailInfo({
    this.id,
    this.pharmacyChainId,
    this.name,
    this.active,
    this.localId,
    this.testPharmacy,
    this.address,
    this.primaryPhoneNumber,
    this.defaultTimeZone,
    this.pharmacistInCharge,
    this.postalCodes,
    this.deliverableStates,
    this.pharmacyHours,
    this.deliverySubsidyAmount,
    this.pharmacySystem,
    this.acceptInvalidAddress,
    this.pharmacyType,
    this.pharmacyLoginCode,
    this.marketplacePharmacy,
    this.checkoutPharmacy,
    this.importActive,
  });
  PharmacyDetailInfo.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    pharmacyChainId = json['pharmacyChainId']?.toString();
    name = json['name']?.toString();
    active = json['active'] as bool?;
    localId = json['localId']?.toString();
    testPharmacy = json['testPharmacy'] as bool?;
    address = (json['address'] != null && (json['address'] is Map))
        ? PharmacyAddress.fromJson(json['address'] as Map<String, Object?>)
        : null;
    primaryPhoneNumber = json['primaryPhoneNumber']?.toString();
    defaultTimeZone = json['defaultTimeZone']?.toString();
    pharmacistInCharge = json['pharmacistInCharge']?.toString();
    postalCodes = json['postalCodes']?.toString();
    if (json['deliverableStates'] != null && (json['deliverableStates'] is List)) {
      final v = json['deliverableStates'] as List;
      final arr0 = <String>[];
      for (final v in v) {
        arr0.add(v.toString());
      }
      deliverableStates = arr0;
    }
    pharmacyHours = json['pharmacyHours']?.toString();
    deliverySubsidyAmount = json['deliverySubsidyAmount']?.toString();
    pharmacySystem = json['pharmacySystem']?.toString();
    acceptInvalidAddress = json['acceptInvalidAddress'] as bool?;
    pharmacyType = json['pharmacyType']?.toString();
    pharmacyLoginCode = json['pharmacyLoginCode']?.toString();
    marketplacePharmacy = json['marketplacePharmacy'] as bool?;
    checkoutPharmacy = json['checkoutPharmacy'] as bool?;
    importActive = json['importActive'] as bool?;
  }

  String? id;
  String? pharmacyChainId;
  String? name;
  bool? active;
  String? localId;
  bool? testPharmacy;
  PharmacyAddress? address;
  String? primaryPhoneNumber;
  String? defaultTimeZone;
  String? pharmacistInCharge;
  String? postalCodes;
  List<String?>? deliverableStates;
  String? pharmacyHours;
  String? deliverySubsidyAmount;
  String? pharmacySystem;
  bool? acceptInvalidAddress;
  String? pharmacyType;
  String? pharmacyLoginCode;
  bool? marketplacePharmacy;
  bool? checkoutPharmacy;
  bool? importActive;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['pharmacyChainId'] = pharmacyChainId;
    data['name'] = name;
    data['active'] = active;
    data['localId'] = localId;
    data['testPharmacy'] = testPharmacy;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['primaryPhoneNumber'] = primaryPhoneNumber;
    data['defaultTimeZone'] = defaultTimeZone;
    data['pharmacistInCharge'] = pharmacistInCharge;
    data['postalCodes'] = postalCodes;
    if (deliverableStates != null) {
      final v = deliverableStates;
      final arr0 = <String?>[];
      v!.forEach(arr0.add);
      data['deliverableStates'] = arr0;
    }
    data['pharmacyHours'] = pharmacyHours;
    data['deliverySubsidyAmount'] = deliverySubsidyAmount;
    data['pharmacySystem'] = pharmacySystem;
    data['acceptInvalidAddress'] = acceptInvalidAddress;
    data['pharmacyType'] = pharmacyType;
    data['pharmacyLoginCode'] = pharmacyLoginCode;
    data['marketplacePharmacy'] = marketplacePharmacy;
    data['checkoutPharmacy'] = checkoutPharmacy;
    data['importActive'] = importActive;
    return data;
  }
}
