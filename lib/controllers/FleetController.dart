import 'dart:ui';

import 'package:ent5m/services/firebase_services.dart';
import 'package:get/get.dart';

import '../models/ResModel.dart';

class FleetController extends GetxController {
  var reservations = <ResModel>[].obs; // Using RxList for reactivity




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // addAppointment();
    getDataSource();
  }

  void addPacker({required String unitNumber}) async {
    await CollectionRef.path(path: 'packers')
        .doc(unitNumber)
        .get()
        .then((value) async {
      if (value.exists) {
        print('already in list');
      } else {
        try {
          await CollectionRef.path(path: 'packers').doc(unitNumber).set({
            'unitNumber': unitNumber,
            'vin': 'VR123456',
            'make': 'ford',
            'model': 'TRANSIT® VAN',
            'year': 2023,
            'seats': 15,
            'photo': 'https://www.vdm.ford.com/content/dam/vdm_ford/live/en_us/ford/nameplate/transitvanwagon/2023/collections/3_2/TT_offroad_2160px-X-926px.jpg/jcr:content/renditions/cq5dam.web.2160.2160.jpeg'
          });
        } catch (e) {
          print(e);
        }
      }
    });
  }

   getDataSource() {
   CollectionRef.path(path: 'reservations').snapshots().listen((event) {
     for(var x in event.docs) {
       var data = x.data() as Map<String ,dynamic>;
       print(data);

      ResModel resModel = ResModel.fromJson(data);

      reservations.add(resModel);

     }

   });
  }

  Future<void> addAppointment() async {
    final DateTime today = DateTime.now().toUtc();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(days: 5));
    await CollectionRef.path(path: 'reservations').add(
      ResModel('FRESNO STATE', startTime, endTime, const Color(0xFF0F8644), true).toJson()
    );
  }

}
