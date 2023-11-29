import 'package:ent5m/controllers/FleetController.dart';
import 'package:ent5m/models/ResModel.dart';
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
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade100, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const PackersListPage(), transition: Transition.downToUp);
              },
              icon: Icon(
                Icons.bus_alert_outlined,
                color: Colors.grey.shade100,
              )),
          IconButton(
              onPressed: () {
                fleetController.addPacker(unitNumber: '7vr624');
              },
              icon: Icon(
                Icons.add,
                color: Colors.grey.shade100,
              )),
        ],
      ),
      body: GetBuilder<FleetController>(
        builder: (FleetController fleetController) => SfCalendar(
          view: CalendarView.month,
          cellBorderColor: Colors.transparent,
          dataSource: MeetingDataSource(fleetController.reservations),
          monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
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
    return appointments![index].eventName;
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
