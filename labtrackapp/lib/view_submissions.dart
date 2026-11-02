// //
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:labtrackapp/edit_submissions.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:url_launcher/url_launcher.dart';
// //
// // class ViewLabSubmissionsPage extends StatefulWidget {
// //   const ViewLabSubmissionsPage({super.key});
// //
// //   @override
// //   State<ViewLabSubmissionsPage> createState() =>
// //       _ViewLabSubmissionsPageState();
// // }
// //
// // class _ViewLabSubmissionsPageState extends State<ViewLabSubmissionsPage> {
// //
// //   List submissions = [];
// //   bool loading = true;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     viewSubmissions();
// //   }
// //
// //   Future<void> viewSubmissions() async {
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //
// //       String url = sh.getString('url').toString();
// //       String lid = sh.getString('lid').toString();
// //
// //       var response = await http.post(
// //         Uri.parse('$url/flutter_view_lab_submissions/'),
// //         body: {'lid': lid},
// //       );
// //
// //       var data = jsonDecode(response.body);
// //
// //       if (data['status'] == 'ok') {
// //         setState(() {
// //           submissions = data['submissions'];
// //           loading = false;
// //         });
// //       } else {
// //         setState(() {
// //           loading = false;
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         loading = false;
// //       });
// //       Fluttertoast.showToast(msg: "Unable to load submissions");
// //     }
// //   }
// //
// //   Future<void> openFile(String fileUrl) async {
// //     if (fileUrl.isEmpty) {
// //       Fluttertoast.showToast(msg: "File not available");
// //       return;
// //     }
// //
// //     Uri uri = Uri.parse(fileUrl);
// //
// //     bool opened = await launchUrl(
// //       uri,
// //       mode: LaunchMode.externalApplication,
// //     );
// //
// //     if (!opened) {
// //       Fluttertoast.showToast(msg: "Unable to open file");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("My Submissions"),
// //       ),
// //       body: loading
// //           ? const Center(child: CircularProgressIndicator())
// //           : submissions.isEmpty
// //           ? const Center(
// //         child: Text("No uploaded exercises found"),
// //       )
// //           : RefreshIndicator(
// //         onRefresh: viewSubmissions,
// //         child: ListView.builder(
// //           padding: const EdgeInsets.all(10),
// //           itemCount: submissions.length,
// //           itemBuilder: (context, index) {
// //             var item = submissions[index];
// //
// //             return Card(
// //               margin: const EdgeInsets.only(bottom: 12),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(15),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //
// //                     Text(
// //                       item['exercise_title'].toString(),
// //                       style: const TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //
// //                     const SizedBox(height: 8),
// //
// //                     Text("Lab: ${item['lab_name']}"),
// //
// //                     Text(
// //                       "Description: ${item['description']}",
// //                     ),
// //
// //                     Text(
// //                       "Submitted Date: ${item['submitted_date']}",
// //                     ),
// //
// //                     Text("Status: ${item['status']}"),
// //
// //                     Text("Grade: ${item['grade']}"),
// //
// //                     Text("Feedback: ${item['feedback']}"),
// //
// //                     const SizedBox(height: 10),
// //
// //                     ElevatedButton.icon(
// //                       onPressed: () {
// //                         openFile(item['file'].toString());
// //                       },
// //                       icon: const Icon(Icons.description),
// //                       label: const Text("View Uploaded File"),
// //                     ),
// //                     ElevatedButton.icon(
// //                       onPressed: () async {
// //                         bool? result = await Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => EditLabSubmissionPage(
// //                               submissionId: item['id'].toString(),
// //                               description: item['description'].toString(),
// //                             ),
// //                           ),
// //                         );
// //
// //                         if (result == true) {
// //                           viewSubmissions();
// //                         }
// //                       },
// //                       icon: const Icon(Icons.edit),
// //                       label: const Text("Edit Submission"),
// //                     ),
// //
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:labtrackapp/edit_submissions.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
//
// class ViewLabSubmissionsPage extends StatefulWidget {
//   const ViewLabSubmissionsPage({super.key});
//
//   @override
//   State<ViewLabSubmissionsPage> createState() =>
//       _ViewLabSubmissionsPageState();
// }
//
// class _ViewLabSubmissionsPageState extends State<ViewLabSubmissionsPage> {
//
//   List submissions = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     viewSubmissions();
//   }
//
//   Future<void> viewSubmissions() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       var response = await http.post(
//         Uri.parse('$url/flutter_view_lab_submissions/'),
//         body: {'lid': lid},
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         setState(() {
//           submissions = data['submissions'];
//           loading = false;
//         });
//       } else {
//         setState(() {
//           loading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         loading = false;
//       });
//       Fluttertoast.showToast(msg: "Unable to load submissions");
//     }
//   }
//
//   Future<void> openFile(String fileUrl) async {
//     if (fileUrl.isEmpty) {
//       Fluttertoast.showToast(msg: "File not available");
//       return;
//     }
//
//     try {
//       Uri uri = Uri.parse(fileUrl);
//
//       bool opened = await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );
//
//       if (!opened) {
//         Fluttertoast.showToast(msg: "Unable to open file");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Unable to open file");
//     }
//   }
//
//   Future<void> deleteSubmission(String submissionId) async {
//
//     bool? confirm = await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Delete Submission"),
//           content: const Text(
//             "Are you sure you want to delete this submission?",
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context, false);
//               },
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context, true);
//               },
//               child: const Text("Delete"),
//             ),
//           ],
//         );
//       },
//     );
//
//     if (confirm != true) {
//       return;
//     }
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       var response = await http.post(
//         Uri.parse('$url/flutter_delete_lab_submission/'),
//         body: {
//           'lid': lid,
//           'submission_id': submissionId,
//         },
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         Fluttertoast.showToast(
//           msg: "Submission deleted successfully",
//         );
//
//         viewSubmissions();
//       } else {
//         Fluttertoast.showToast(
//           msg: data['message'] ?? "Delete failed",
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error deleting submission");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Submissions"),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : submissions.isEmpty
//           ? const Center(
//         child: Text("No uploaded exercises found"),
//       )
//           : RefreshIndicator(
//         onRefresh: viewSubmissions,
//         child: ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: submissions.length,
//           itemBuilder: (context, index) {
//             var item = submissions[index];
//
//             return Card(
//               margin: const EdgeInsets.only(bottom: 12),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Text(
//                       item['exercise_title'].toString(),
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//
//                     const SizedBox(height: 8),
//
//                     Text("Lab: ${item['lab_name']}"),
//
//                     Text(
//                       "Description: ${item['description']}",
//                     ),
//
//                     Text(
//                       "Submitted Date: ${item['submitted_date']}",
//                     ),
//
//                     Text("Status: ${item['status']}"),
//
//                     Text("Grade: ${item['grade']}"),
//
//                     Text("Feedback: ${item['feedback']}"),
//
//                     const SizedBox(height: 10),
//
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           openFile(
//                             item['file'].toString(),
//                           );
//                         },
//                         icon: const Icon(Icons.description),
//                         label: const Text("View Uploaded File"),
//                       ),
//                     ),
//
//                     const SizedBox(height: 8),
//
//                     Row(
//                       children: [
//
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             onPressed: () async {
//                               bool? result =
//                               await Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       EditLabSubmissionPage(
//                                         submissionId:
//                                         item['id'].toString(),
//                                         description: item['description']
//                                             .toString(),
//                                       ),
//                                 ),
//                               );
//
//                               if (result == true) {
//                                 viewSubmissions();
//                               }
//                             },
//                             icon: const Icon(Icons.edit),
//                             label: const Text("Edit"),
//                           ),
//                         ),
//
//                         const SizedBox(width: 10),
//
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             onPressed: () {
//                               deleteSubmission(
//                                 item['id'].toString(),
//                               );
//                             },
//                             icon: const Icon(Icons.delete),
//                             label: const Text("Delete"),
//                           ),
//                         ),
//
//                       ],
//                     ),
//
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:labtrackapp/edit_submissions.dart';
import 'package:url_launcher/url_launcher.dart';

// ═════════════ THEME (same look as Send Feedback, kept private to this file) ═════════════
const Color _kTop = Color(0xFF164A63);
const Color _kMid = Color(0xFF0D3048);
const Color _kDeep = Color(0xFF08203A);
const Color _kCyan = Color(0xFF5CD0EE);
const Color _kTeal = Color(0xFF0B84A8);
const Color _kTealDark = Color(0xFF086A89);
const Color _kHeading = Color(0xFF0D2B3E);
const Color _kMuted = Color(0xFF5D7183);
const Color _kCanvas = Color(0xFFF1F6FB);
const Color _kBorder = Color(0xFFDAE6F1);
const Color _kTile = Color(0xFFE2F4FA);
const Color _kDanger = Color(0xFFC0291F);
const Color _kSuccess = Color(0xFF1C7C54);
const Color _kAmber = Color(0xFFE08A0B);

// ───────── Small helpers ─────────
String _txt(dynamic v, [String fallback = '-']) {
  final s = (v ?? '').toString().trim();
  return (s.isEmpty || s.toLowerCase() == 'null' || s.toLowerCase() == 'none')
      ? fallback
      : s;
}


// Formats server dates without seconds: "24 Oct 2026, 2:30 PM" (date-only stays "24 Oct 2026")
String _fmtDate(dynamic v, [String fallback = '-']) {
  final raw = _txt(v, '');
  if (raw.isEmpty) return fallback;

  final d = DateTime.tryParse(raw);
  if (d == null) {
    // Unknown format: just strip seconds / milliseconds from any HH:MM:SS
    return raw.replaceAllMapped(
        RegExp(r'(\d{1,2}:\d{2}):\d{2}(\.\d+)?'), (m) => m.group(1)!);
  }

  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  final dt = d.isUtc ? d.toLocal() : d;
  final date = '${dt.day.toString().padLeft(2, '0')} ${months[dt.month - 1]} ${dt.year}';

  final hasTime = raw.contains(':');
  if (!hasTime) return date;

  final h12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
  final ampm = dt.hour >= 12 ? 'PM' : 'AM';
  return '$date, $h12:${dt.minute.toString().padLeft(2, '0')} $ampm';
}

Color _statusColor(String s) {
  final t = s.toLowerCase();
  if (RegExp(r'reject|damage|unavail|overdue|fail|lost|cancel').hasMatch(t)) {
    return _kDanger;
  }
  if (RegExp(r'pend|wait|process|request').hasMatch(t)) return _kAmber;
  if (RegExp(r'approv|avail|assign|resolv|repl|return|complete|active|done|graded|evaluat')
      .hasMatch(t)) {
    return _kSuccess;
  }
  return _kTeal;
}

void _snackOn(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(msg)));
}

PreferredSizeWidget _appBar(String title, {List<Widget>? actions}) => AppBar(
  toolbarHeight: 60,
  actions: actions,
  elevation: 0,
  scrolledUnderElevation: 0,
  iconTheme: const IconThemeData(color: Colors.white),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_kTop, _kMid, _kDeep],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  ),
  title: Text(
    title,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: 19,
      letterSpacing: -0.3,
    ),
  ),
);

InputDecoration _input(String label,
    {IconData? icon, String? hint, Widget? suffix, bool alignTop = false}) {
  OutlineInputBorder b(Color c, [double w = 1.2]) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: c, width: w),
  );
  return InputDecoration(
    labelText: label,
    hintText: hint,
    alignLabelWithHint: alignTop,
    labelStyle: const TextStyle(color: _kMuted, fontWeight: FontWeight.w600),
    floatingLabelStyle:
    const TextStyle(color: _kTeal, fontWeight: FontWeight.w700),
    hintStyle: const TextStyle(color: Color(0xFF8196A8)),
    prefixIcon: icon == null ? null : Icon(icon, color: _kTeal, size: 21),
    suffixIcon: suffix,
    filled: true,
    fillColor: _kCanvas,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: b(_kBorder),
    enabledBorder: b(_kBorder),
    focusedBorder: b(_kTeal, 1.6),
    errorBorder: b(_kDanger),
    focusedErrorBorder: b(_kDanger, 1.6),
    errorStyle: const TextStyle(
        color: _kDanger, fontWeight: FontWeight.w600, fontSize: 12),
    errorMaxLines: 3,
  );
}

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _Header(
      {required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    const r = BorderRadius.only(
      bottomLeft: Radius.circular(28),
      bottomRight: Radius.circular(28),
    );
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_kTop, _kDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: r,
        boxShadow: [
          BoxShadow(
              color: Color(0x3308203A), blurRadius: 24, offset: Offset(0, 12)),
        ],
      ),
      child: ClipRRect(
        borderRadius: r,
        child: Stack(
          children: [
            Positioned(
              right: -50,
              top: -70,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [_kCyan.withOpacity(0.32), _kCyan.withOpacity(0)],
                  ),
                ),
              ),
            ),
            Positioned.fill(child: CustomPaint(painter: _DotsPainter())),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 26),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_kCyan, _kTeal],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x4D000000),
                            blurRadius: 14,
                            offset: Offset(0, 6)),
                      ],
                    ),
                    child: Icon(icon, color: _kDeep, size: 27),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            )),
                        const SizedBox(height: 3),
                        Text(subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFFB9D3E3),
                              fontSize: 12.5,
                              height: 1.4,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withOpacity(0.09);
    for (double x = 12; x < size.width; x += 24) {
      for (double y = 12; y < size.height; y += 24) {
        canvas.drawCircle(Offset(x, y), 1, p);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _kBorder, width: 1.2),
      boxShadow: const [
        BoxShadow(
            color: Color(0x0F08203A), blurRadius: 14, offset: Offset(0, 6)),
      ],
    ),
    child: child,
  );
}

class _SectionLabel extends StatelessWidget {
  final String text;
  final IconData icon;
  const _SectionLabel(this.text, this.icon);

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: _kTile,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 17, color: _kTeal),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _kHeading,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            )),
      ),
    ],
  );
}

class _GradButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool loading;
  final VoidCallback? onPressed; // null = disabled
  const _GradButton({
    required this.label,
    required this.icon,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = loading || onPressed == null;
    return Opacity(
      opacity: loading ? 0.7 : (onPressed == null ? 0.5 : 1),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [_kTeal, _kTealDark]),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x4D0B84A8),
                  blurRadius: 14,
                  offset: Offset(0, 6)),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            splashColor: _kCyan.withOpacity(0.3),
            onTap: disabled ? null : onPressed,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  loading
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.2, color: Colors.white),
                  )
                      : Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String text;
  const _StatusChip(this.text);

  @override
  Widget build(BuildContext context) {
    final c = _statusColor(text);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: c.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(text,
              style: TextStyle(
                color: c,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              )),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  const _InfoRow(this.icon, this.label, this.value, {this.valueColor});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(icon, size: 17, color: _kTeal),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(
                    color: _kMuted,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: valueColor ?? _kHeading,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  const _EmptyState(
      {required this.icon, required this.title, required this.message});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    child: Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: const BoxDecoration(
            color: _kTile,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 40, color: _kTeal),
        ),
        const SizedBox(height: 18),
        Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _kHeading,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            )),
        const SizedBox(height: 6),
        Text(message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kMuted, fontSize: 13.5, height: 1.4)),
      ],
    ),
  );
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    child: Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: _kDanger.withOpacity(0.10),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.cloud_off_rounded, size: 40, color: _kDanger),
        ),
        const SizedBox(height: 18),
        const Text('Something went wrong',
            style: TextStyle(
              color: _kHeading,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            )),
        const SizedBox(height: 6),
        Text(message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kMuted, fontSize: 13.5, height: 1.4)),
        const SizedBox(height: 20),
        SizedBox(
          width: 180,
          child: _GradButton(
            label: 'Try again',
            icon: Icons.refresh_rounded,
            loading: false,
            onPressed: onRetry,
          ),
        ),
      ],
    ),
  );
}

// ───────── Compact action button (small pill, not a big elevated button) ─────────
class _CompactButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final bool danger; // red filled variant (Delete)
  final VoidCallback? onPressed; // null = disabled
  const _CompactButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onPressed,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color fg = filled ? Colors.white : _kTealDark;
    return Opacity(
      opacity: onPressed == null ? 0.5 : 1,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          height: 42,
          decoration: BoxDecoration(
            gradient: filled
                ? LinearGradient(
                colors: danger
                    ? const [_kDanger, Color(0xFF9E1F17)]
                    : const [_kTeal, _kTealDark])
                : null,
            color: filled ? null : _kTile,
            borderRadius: BorderRadius.circular(12),
            border: filled ? null : Border.all(color: _kBorder, width: 1.2),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            splashColor: _kCyan.withOpacity(0.3),
            onTap: onPressed,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 17, color: fg),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: fg,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// ═════════════════════════ VIEW LAB SUBMISSIONS PAGE ═════════════════════════
class ViewLabSubmissionsPage extends StatefulWidget {
  const ViewLabSubmissionsPage({super.key});

  @override
  State<ViewLabSubmissionsPage> createState() =>
      _ViewLabSubmissionsPageState();
}

class _ViewLabSubmissionsPageState extends State<ViewLabSubmissionsPage> {
  List submissions = [];
  bool loading = true;
  bool _fetching = false; // blocks overlapping requests
  bool _busy = false; // blocks double taps on Edit / Delete
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    viewSubmissions();
  }

  // ───────── Helpers ─────────
  void _snack(String msg) {
    if (!mounted) return;
    _snackOn(context, msg);
  }

  void _fail(String msg) {
    if (!mounted) return;
    setState(() {
      loading = false;
      if (submissions.isEmpty) errorMsg = msg;
    });
    if (submissions.isNotEmpty) _snack(msg);
  }

  void _retry() {
    setState(() {
      loading = true;
      errorMsg = null;
    });
    viewSubmissions();
  }

  bool _validId(String id) => int.tryParse(id.trim()) != null;

  bool _validHttpUrl(String url) {
    final uri = Uri.tryParse(url.trim());
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  /// Deadline sent by the server, or null if it was not sent.
  DateTime? _deadlineOf(Map i) {
    final raw = _txt(i['deadline'], '');
    if (raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }

  /// Edit / Delete close once the deadline has passed.
  bool _isClosed(Map i) {
    final d = _deadlineOf(i);
    return d != null && DateTime.now().isAfter(d);
  }

  /// Returns {url, lid} or null (with a message) if the session is invalid.
  Future<Map<String, String>?> _session() async {
    final sh = await SharedPreferences.getInstance();
    String url = (sh.getString('url') ?? '').trim();
    final lid = (sh.getString('lid') ?? '').trim();

    if (url.isEmpty || !_validId(lid)) {
      _snack('Session expired. Please log in again');
      return null;
    }

    url = url.endsWith('/') ? url : '$url/';
    if (!url.endsWith('/myapp/')) {
      url = '${url}myapp/';
    }

    if (!_validHttpUrl(url)) {
      _snack('Server address is invalid. Please log in again');
      return null;
    }
    return {'url': url, 'lid': lid};
  }

  // ───────── Load data ─────────
  Future<void> viewSubmissions() async {
    if (_fetching) return;
    _fetching = true;

    try {
      final session = await _session();
      if (session == null) {
        _fail('Session expired. Please log in again');
        return;
      }

      final response = await http.post(
        Uri.parse('${session['url']}flutter_view_lab_submissions/'),
        body: {'lid': session['lid']!},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        _fail('Server error (${response.statusCode}). Please try again');
        return;
      }

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (data is Map && data['status'] == 'ok') {
        final raw = data['submissions'];
        final list = <Map>[];
        if (raw is List) {
          for (final e in raw) {
            // skip malformed entries instead of crashing
            if (e is Map && _validId(_txt(e['id'], ''))) list.add(e);
          }
        }
        setState(() {
          submissions = list;
          loading = false;
          errorMsg = null;
        });
      } else {
        _fail((data is Map ? data['message'] : null)?.toString() ??
            'Unable to load submissions');
      }
    } on TimeoutException {
      _fail('Request timed out. Check your connection and try again');
    } on SocketException {
      _fail('No internet connection or server unreachable');
    } on FormatException {
      _fail('Unexpected response from server');
    } catch (e) {
      _fail('Unable to load submissions');
    } finally {
      _fetching = false;
    }
  }

  // ───────── View file ─────────
  Future<void> openFile(String fileUrl) async {
    if (fileUrl.trim().isEmpty) {
      _snack('File not available');
      return;
    }
    if (!_validHttpUrl(fileUrl)) {
      _snack('Invalid file link');
      return;
    }
    try {
      final opened = await launchUrl(
        Uri.parse(fileUrl.trim()),
        mode: LaunchMode.externalApplication,
      );
      if (!opened) _snack('Unable to open file');
    } catch (e) {
      _snack('Unable to open file');
    }
  }

  // ───────── Edit ─────────
  Future<void> editSubmission(Map i) async {
    if (_busy) return;

    if (_isClosed(i)) {
      _snack('Deadline passed. Editing is closed');
      setState(() {});
      return;
    }

    final id = _txt(i['id'], '');
    if (!_validId(id)) {
      _snack('Invalid submission. Please refresh and try again');
      return;
    }

    setState(() => _busy = true);
    try {
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => EditLabSubmissionPage(
            submissionId: id,
            description: _txt(i['description'], ''),
          ),
        ),
      );
      if (result == true && mounted) await viewSubmissions();
    } catch (e) {
      _snack('Unable to open edit page');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  // ───────── Delete ─────────
  Future<bool> _confirmDelete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kDanger.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete_rounded,
                  color: _kDanger, size: 20),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text('Delete submission',
                  style: TextStyle(
                    color: _kHeading,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  )),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to delete this submission? This cannot be undone.',
          style: TextStyle(color: _kMuted, fontSize: 13.5, height: 1.4),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        actions: [
          SizedBox(
            width: 100,
            child: _CompactButton(
              label: 'Cancel',
              icon: Icons.close_rounded,
              filled: false,
              onPressed: () => Navigator.pop(ctx, false),
            ),
          ),
          SizedBox(
            width: 110,
            child: _CompactButton(
              label: 'Delete',
              icon: Icons.delete_rounded,
              filled: true,
              danger: true,
              onPressed: () => Navigator.pop(ctx, true),
            ),
          ),
        ],
      ),
    );
    return ok == true;
  }

  Future<void> deleteSubmission(Map i) async {
    if (_busy) return;

    if (_isClosed(i)) {
      _snack('Deadline passed. Deleting is closed');
      setState(() {});
      return;
    }

    final submissionId = _txt(i['id'], '');
    if (!_validId(submissionId)) {
      _snack('Invalid submission. Please refresh and try again');
      return;
    }

    final confirmed = await _confirmDelete();
    if (!confirmed || !mounted) return;

    // Deadline may have passed while the dialog was open
    if (_isClosed(i)) {
      _snack('Deadline passed. Deleting is closed');
      setState(() {});
      return;
    }

    setState(() => _busy = true);
    try {
      final session = await _session();
      if (session == null) return;

      final response = await http.post(
        Uri.parse('${session['url']}flutter_delete_lab_submission/'),
        body: {'lid': session['lid']!, 'submission_id': submissionId},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        _snack('Server error (${response.statusCode}). Please try again');
        return;
      }

      final data = jsonDecode(response.body);

      if (data is Map && data['status'] == 'ok') {
        _snack('Submission deleted successfully');
        await viewSubmissions();
      } else {
        _snack((data is Map ? data['message'] : null)?.toString() ??
            'Delete failed');
      }
    } on TimeoutException {
      _snack('Request timed out. Try again');
    } on SocketException {
      _snack('No internet connection or server unreachable');
    } on FormatException {
      _snack('Unexpected response from server');
    } catch (e) {
      _snack('Error deleting submission');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  // ───────── UI ─────────
  Widget _avatar() {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_kCyan, _kTeal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x2E0B84A8), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: const Icon(Icons.assignment_turned_in_rounded,
          color: _kDeep, size: 24),
    );
  }

  Widget _pill(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(Map i) {
    final title = _txt(i['exercise_title'], 'Untitled exercise');
    final lab = _txt(i['lab_name'], '');
    final status = _txt(i['status'], 'Pending');
    final deadline = _deadlineOf(i);
    final closed = _isClosed(i);
    final file = _txt(i['file'], '');
    final hasFile = _validHttpUrl(file);
    final canAct = _validId(_txt(i['id'], ''));

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _avatar(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _kHeading,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      if (lab.isNotEmpty) ...[
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _kTile,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            lab,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _kTealDark,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _StatusChip(status),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, color: _kBorder),
            const SizedBox(height: 8),
            _InfoRow(Icons.notes_rounded, 'Description',
                _txt(i['description'], 'No description')),
            _InfoRow(Icons.event_available_rounded, 'Submitted',
                _fmtDate(i['submitted_date'])),
            _InfoRow(Icons.grade_rounded, 'Grade',
                _txt(i['grade'], 'Not graded')),
            _InfoRow(Icons.feedback_rounded, 'Feedback',
                _txt(i['feedback'], 'No feedback yet')),
            if (deadline != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: _pill(
                  closed
                      ? 'Closed: ${_fmtDate(i['deadline'])}'
                      : 'Open until ${_fmtDate(i['deadline'])}',
                  closed ? _kDanger : _kSuccess,
                  closed ? Icons.lock_rounded : Icons.timer_rounded,
                ),
              ),
            ],
            const SizedBox(height: 12),
            _CompactButton(
              label: hasFile ? 'View uploaded file' : 'File not available',
              icon: Icons.description_rounded,
              filled: false,
              onPressed: hasFile ? () => openFile(file) : null,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _CompactButton(
                    label: 'Edit',
                    icon: Icons.edit_rounded,
                    filled: true,
                    onPressed: (closed || _busy || !canAct)
                        ? null
                        : () => editSubmission(i),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _CompactButton(
                    label: 'Delete',
                    icon: Icons.delete_rounded,
                    filled: true,
                    danger: true,
                    onPressed: (closed || _busy || !canAct)
                        ? null
                        : () => deleteSubmission(i),
                  ),
                ),
              ],
            ),
            if (closed) ...[
              const SizedBox(height: 8),
              const Text(
                'Editing and deleting are closed after the deadline.',
                style: TextStyle(color: _kMuted, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _scrollable(Widget child) => RefreshIndicator(
    color: _kTeal,
    onRefresh: viewSubmissions,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [const SizedBox(height: 70), child],
    ),
  );

  Widget _body() {
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: _kTeal));
    }

    if (errorMsg != null && submissions.isEmpty) {
      return _scrollable(_ErrorState(message: errorMsg!, onRetry: _retry));
    }

    if (submissions.isEmpty) {
      return _scrollable(const _EmptyState(
        icon: Icons.assignment_outlined,
        title: 'No submissions yet',
        message: 'No uploaded exercises found.',
      ));
    }

    return RefreshIndicator(
      color: _kTeal,
      onRefresh: viewSubmissions,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        itemCount: submissions.length,
        itemBuilder: (context, index) {
          final item = submissions[index];
          if (item is! Map) return const SizedBox.shrink();
          return _card(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitle = loading
        ? 'Loading submissions...'
        : submissions.isEmpty
        ? 'No submissions to show right now.'
        : '${submissions.length} submission${submissions.length == 1 ? '' : 's'} uploaded';

    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('My Submissions'),
      body: Column(
        children: [
          _Header(
            title: 'My submissions',
            subtitle: subtitle,
            icon: Icons.assignment_turned_in_rounded,
          ),
          Expanded(child: _body()),
        ],
      ),
    );
  }
}




































