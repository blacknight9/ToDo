import 'package:ent5m/controllers/FleetController.dart';
import 'package:ent5m/models/ResModel.dart';
import 'package:ent5m/views/FleetPage/AddResPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'PackersListPage.dart';

class PackersPage extends StatelessWidget {
  const PackersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fleetController = Get.put(FleetController());
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
          IconButton(
              onPressed: () {
                Get.to(()=> AddReservationView());
                // fleetController.addPacker(unitNumber: '7vr624');
              },
              icon: Icon(
                Icons.add,
                color: Colors.grey.shade100,
              )),
        ],
      ),
      body: GetBuilder<FleetController>(
        builder: (FleetController fleetController) =>
            SfCalendar(
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
              // appointmentBuilder: (context, details) {
              //   final ResModel appointment = details.appointments.first;
              //
              //   return Container(
              //     width: details.bounds.width,
              //     height: details.bounds.height,
              //     decoration: BoxDecoration(
              //       color: appointment.background,
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     child: Center(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //        Flexible(
              //          child: Text(
              //               '${appointment.eventName} ',
              //               overflow: TextOverflow.ellipsis,
              //               style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
              //             ),
              //        ),
              //           Text(
              //             '${appointment.unit} ',
              //             maxLines: 2,
              //             overflow: TextOverflow.ellipsis,
              //             style: const TextStyle(color: Colors.yellow, fontSize: 14, fontWeight: FontWeight.bold),
              //           ),
              //           Text(
              //             appointment.size,
              //             overflow: TextOverflow.ellipsis,
              //             style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
              //           ),
              //         ],
              //       ),
              //
              //     ),);
              // },
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
