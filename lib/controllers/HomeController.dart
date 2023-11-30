import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/HomePanelModel.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var title = ''.obs;
  var message = ''.obs;
  var isPinned = false.obs;



  Future<void> addNote() async {
    try {
      CollectionReference notes =
          FirebaseFirestore.instance.collection('homePanel');
      await notes.add(HomePanelModel(
              title: title.value,
              message: message.value,
              isPinned: isPinned.value,
              timeStamp: DateTime.now().toUtc(),
              dp: randomImage,
              type: 'note',
              userName: 'userName')
          .toJson());
      // Reset fields after saving
      title.value = '';
      message.value = '';
      isPinned.value = false;
    } catch (e) {
      print(e);
    }
  }
}
