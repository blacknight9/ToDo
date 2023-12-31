import 'package:ent5m/controllers/FleetController.dart';
import 'package:ent5m/models/ResModel.dart';
import 'package:ent5m/views/FleetPage/AddResPage.dart';
import 'package:ent5m/views/FleetPage/ResView.dart';
import 'package:ent5m/views/FleetPage/Reservations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'PackersListPage.dart';





class PackersPage extends StatefulWidget {
  const PackersPage({super.key});

  @override
  State<PackersPage> createState() => _PackersPageState();
}

class _PackersPageState extends State<PackersPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PACKERS RES',
          style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.grey.shade100,
              fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const PackersListPage(),
                    transition: Transition.downToUp);
              },
              icon: Icon(
                Icons.bus_alert_outlined,
                color: Colors.grey.shade100,
              )),
          IconButton(onPressed: (){
            Get.to(()=> const Reservations(),transition: Transition.downToUp);
          }, icon: const Icon(Icons.list)),
          IconButton(
              onPressed: () {
                Get.to(()=>  AddReservationView(isEdit: false,));
                // fleetController.addPacker(unitNumber: '7vr624');
              },
              icon: Icon(
                Icons.add,
                color: Colors.grey.shade100,
              )),

        ],
      ),
      body: GetBuilder<FleetController>(
        init: FleetController(),
        builder: (FleetController fleetController) =>
            SfCalendar(

              onTap: (CalendarTapDetails details){
                if (details.targetElement == CalendarElement.appointment) {
                  Get.to(()=>ResView(resModel: details.appointments!.first as ResModel),transition: Transition.downToUp);
                }
              },
              onLongPress: (calenderTapDetails) {

                  Get.to(()=> AddReservationView(from: calenderTapDetails.date,isEdit: false,),transition: Transition.downToUp);



              },
              view: CalendarView.month,
              cellBorderColor: Colors.transparent,
              dataSource: MeetingDataSource(fleetController.reservations),
              monthViewSettings:  const MonthViewSettings(
                appointmentDisplayCount: 4,
                agendaStyle: AgendaStyle(
                  appointmentTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)
                ),
                showAgenda: true,
                  appointmentDisplayMode: MonthAppointmentDisplayMode
                      .appointment),

            ),
      ),
    );
  }
}



class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<ResModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return '${appointments![index].eventName} ${appointments![index].unit} ${appointments![index].size}';
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
