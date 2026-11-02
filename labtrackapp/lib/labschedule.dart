
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewTimetable extends StatefulWidget {
  const ViewTimetable({super.key});

  @override
  State<ViewTimetable> createState() => _ViewTimetableState();
}

class _ViewTimetableState extends State<ViewTimetable> {

  List timetable = [];
  String course = '';
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    viewTimetable();
  }

  Future<void> viewTimetable() async {

    setState(() {
      isLoading = true;
      error = '';
    });

    try {

      SharedPreferences sh = await SharedPreferences.getInstance();

      String url = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';

      if (url.isEmpty || lid.isEmpty) {
        throw Exception('Server URL or student ID is missing');
      }

      String baseUrl = url.endsWith('/') ? url : '$url/';

      var response = await http.post(
        Uri.parse(baseUrl + 'flutter_view_timetable'),
        body: {
          'lid': lid,
        },
      );

      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('RESPONSE: ${response.body}');

      if (response.statusCode == 200) {

        var jsondata = json.decode(response.body);

        if (jsondata['status'] == 'ok') {

          setState(() {
            timetable = jsondata['data'] ?? [];
            course = jsondata['course'] ?? '';
            isLoading = false;
            error = '';
          });

        } else {

          setState(() {
            error = jsondata['message'] ?? 'Unable to load timetable';
            isLoading = false;
          });

        }

      } else {

        setState(() {
          error = 'Server error: ${response.statusCode}';
          isLoading = false;
        });

      }

    } catch (e) {

      debugPrint('TIMETABLE ERROR: $e');

      setState(() {
        error = e.toString();
        isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfff1f6fb),

      appBar: AppBar(
        title: const Text(
          'LabTrack',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff103b55),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xff0b84a8),
        ),
      )

          : error.isNotEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.error_outline,
                size: 55,
                color: Colors.red,
              ),

              const SizedBox(height: 15),

              const Text(
                'Unable to Load Timetable',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff103b55),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: viewTimetable,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0b84a8),
                  foregroundColor: Colors.white,
                ),
              ),

            ],
          ),
        ),
      )

          : RefreshIndicator(
        onRefresh: viewTimetable,

        child: ListView(
          padding: const EdgeInsets.all(18),

          children: [

            const Text(
              'My Timetable',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff103b55),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              course,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff0b84a8),
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 22),

            if (timetable.isEmpty)
              Container(
                padding: const EdgeInsets.all(30),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),

                child: const Column(
                  children: [

                    Icon(
                      Icons.calendar_month,
                      size: 55,
                      color: Color(0xff0b84a8),
                    ),

                    SizedBox(height: 15),

                    Text(
                      'No Timetable Available',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff103b55),
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Your lab schedule will appear here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                  ],
                ),
              ),

            ...timetable.map((i) {

              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [

                        Container(
                          padding: const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color: const Color(0xffe6f6fb),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: const Icon(
                            Icons.science,
                            color: Color(0xff0b84a8),
                            size: 25,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                i['subject_name']?.toString() ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff103b55),
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                i['subject_code']?.toString() ?? '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 18),

                    timetableDetail(
                      Icons.calendar_today,
                      'Day',
                      i['day']?.toString() ?? '',
                    ),

                    const SizedBox(height: 12),

                    timetableDetail(
                      Icons.access_time,
                      'Hour',
                      i['hour']?.toString() ?? '',
                    ),

                    const SizedBox(height: 12),

                    timetableDetail(
                      Icons.location_on,
                      'Lab',
                      i['lab_name']?.toString() ?? '',
                    ),

                    const SizedBox(height: 12),

                    timetableDetail(
                      Icons.meeting_room,
                      'Room',
                      i['room_number']?.toString() ?? '',
                    ),

                    const SizedBox(height: 12),

                    timetableDetail(
                      Icons.school,
                      'Semester',
                      i['semester']?.toString() ?? '',
                    ),

                  ],
                ),
              );

            }).toList(),

          ],
        ),
      ),
    );
  }

  Widget timetableDetail(IconData icon, String title, String value) {

    return Row(
      children: [

        Icon(
          icon,
          size: 18,
          color: const Color(0xff0b84a8),
        ),

        const SizedBox(width: 10),

        Text(
          '$title: ',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xff34566c),
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xff71879a),
            ),
          ),
        ),

      ],
    );
  }
}
