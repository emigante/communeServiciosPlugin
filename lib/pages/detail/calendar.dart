
import 'package:flutter/material.dart';
import 'package:servicioscommune/controls/connection.dart';
import 'package:servicioscommune/models/evento.dart';
import 'package:servicioscommune/models/servicios.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class CalendarPage extends StatefulWidget {
  Servicios servicios;
  CalendarPage({super.key, required this.servicios});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
   _AppointmentDataSource events = _AppointmentDataSource([]);
   DatabaseServices db =DatabaseServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargaEventos();
  }

  _cargaEventos() async {
    List<Appointment> appointments = <Appointment>[];
    List<Evento> eventsFirebase = await db.getEventos(widget.servicios.idProveedor.toString());

    eventsFirebase.forEach((element) {
      var ff = element.fecha!.split("-");
      int yy = int.parse(ff[2]);
      int mm = int.parse(ff[1]);
      int dd = int.parse(ff[0]);
      var ti = element.horainicio!.split(":");
      int hhi = int.parse(ti[0]);
      int mmi = int.parse(ti[1]);

      DateTime inicio = DateTime(yy, mm, dd, hhi, mmi);

      var tf = element.horafin!.split(":");
      int hhf = int.parse(tf[0]);
      int mmf = int.parse(tf[1]);

      DateTime fin = DateTime(yy, mm, dd, hhf, mmf);
      appointments.add(Appointment(
        startTime: inicio,
        endTime: fin,
        subject: element.asunto!,
        color: element.toColor(),
        startTimeZone: '',
        endTimeZone: '',
      ));
    });
    setState(() {
      events = _AppointmentDataSource(appointments);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.week,
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        specialRegions: _getTimeRegions(),
        dataSource: events,
      ),
    );
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    regions.add(TimeRegion(
        startTime: DateTime(2024, 10, 30, 0),
        endTime: DateTime(2024, 10, 30, 0).add(Duration(hours: 24)),
        enablePointerInteraction: false,
        recurrenceRule: 'FREQ=WEEKLY;BYDAY=SU,SA;INTERVAL=1',
        textStyle: TextStyle(color: Colors.black45, fontSize: 15),
        color: Colors.grey.withOpacity(0.2),
        text: 'Ocupado'));
    regions.add(TimeRegion(
        startTime: DateTime(2024, 10, 30, 5),
        endTime: DateTime(2024, 10, 30, 0).add(Duration(hours: 2)),
        enablePointerInteraction: false,
        recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
        textStyle: TextStyle(
          color: Colors.black45,
        ),
        color: Colors.grey.withOpacity(0.2),
        text: 'Ocupado'));

    return regions;
  }
}
class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}