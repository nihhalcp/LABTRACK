// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:labtrackapp/submit_lab_excercise.dart';
// import 'package:labtrackapp/view_submissions.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ViewLabExercisePage(
//       labId: '1',
//       labName: 'Lab Exercises',
//     ),
//   ));
// }
//
// class ViewLabExercisePage extends StatefulWidget {
//   final String labId;
//   final String labName;
//
//   const ViewLabExercisePage({
//     super.key,
//     required this.labId,
//     required this.labName,
//   });
//
//   @override
//   State<ViewLabExercisePage> createState() => _ViewLabExercisePageState();
// }
//
// class _ViewLabExercisePageState extends State<ViewLabExercisePage> {
//
//   List exercises = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     view_exercises();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.labName),
//       ),
//
//       body: loading
//           ? const Center(
//         child: CircularProgressIndicator(),
//       )
//           : exercises.isEmpty
//           ? const Center(
//         child: Text("No lab exercises found"),
//       )
//           : ListView.builder(
//         padding: const EdgeInsets.all(15),
//         itemCount: exercises.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.only(bottom: 15),
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Text(
//                     exercises[index]['title'].toString(),
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Text(
//                     "Excercise: ${exercises[index]['instruction']}",
//                   ),
//
//                   const SizedBox(height: 10),
//                   const SizedBox(height: 10),
//
//                   const Text(
//                     "Reference File:",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   const SizedBox(height: 5),
//
//                   if (exercises[index]['reference_file'] != null &&
//                       exercises[index]['reference_file'].toString().isNotEmpty)
//                     TextButton(
//                       onPressed: () async {
//                         String fileUrl =
//                         exercises[index]['reference_file'].toString();
//
//                         final uri = Uri.parse(fileUrl);
//
//                         await launchUrl(
//                           uri,
//                           mode: LaunchMode.externalApplication,
//                         );
//                       },
//                       child: const Text("Open Reference File"),
//                     )
//                   else
//                     const Text("No reference file available"),
//                   Text(
//                     "Date: ${exercises[index]['date']}",
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Text(
//                     "Deadline: ${exercises[index]['deadline']}",
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SubmitLabExercisePage(
//                             instructionId: exercises[index]['id'].toString(),
//                             exerciseTitle: exercises[index]['title'].toString(),
//                           ),
//                         ),
//                       );
//                     },
//                     child: const Text("Submit Exercise"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ViewLabSubmissionsPage(),
//                         ),
//                       );
//                     },
//                     child: const Text("View Uploaded Exercises"),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void view_exercises() async {
//
//     SharedPreferences sh =
//     await SharedPreferences.getInstance();
//
//     String url =
//     sh.getString('url').toString();
//
//     final urls =
//     Uri.parse('$url/flutter_view_lab_exercises/');
//
//     try {
//
//       final response = await http.post(
//         urls,
//         body: {
//           'lab_id': widget.labId,
//         },
//       );
//
//       if (response.statusCode == 200) {
//
//         String status =
//         jsonDecode(response.body)['status'].toString();
//
//         if (status == 'ok') {
//
//           setState(() {
//             exercises = jsonDecode(response.body)['exercises'];
//             loading = false;
//           });
//
//         } else {
//
//           setState(() {
//             loading = false;
//           });
//
//           Fluttertoast.showToast(
//             msg: "Unable to load exercises",
//           );
//         }
//
//       } else {
//
//         setState(() {
//           loading = false;
//         });
//
//         Fluttertoast.showToast(
//           msg: "Network Error",
//         );
//       }
//
//     } catch (e) {
//
//       setState(() {
//         loading = false;
//       });
//
//       Fluttertoast.showToast(
//         msg: e.toString(),
//       );
//     }
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:labtrackapp/submit_lab_excercise.dart';
import 'package:labtrackapp/view_submissions.dart';
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
  return (s.isEmpty || s.toLowerCase() == 'null') ? fallback : s;
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

int _toInt(dynamic v) => int.tryParse((v ?? '').toString().trim()) ?? 0;

double _toDouble(dynamic v) =>
    double.tryParse((v ?? '').toString().trim()) ?? 0;

Color _statusColor(String s) {
  final t = s.toLowerCase();
  if (RegExp(r'reject|damage|unavail|overdue|fail|lost|cancel').hasMatch(t)) {
    return _kDanger;
  }
  if (RegExp(r'pend|wait|process|request').hasMatch(t)) return _kAmber;
  if (RegExp(r'approv|avail|assign|resolv|repl|return|complete|active|done')
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

PreferredSizeWidget _appBar(String title) => AppBar(
  toolbarHeight: 60,
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

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ViewLabExercisePage(
      labId: '1',
      labName: 'Lab Exercises',
    ),
  ));
}

// ───────── Compact action button (small pill, not a big elevated button) ─────────
class _CompactButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback? onPressed; // null = disabled
  const _CompactButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onPressed,
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
            gradient:
            filled ? const LinearGradient(colors: [_kTeal, _kTealDark]) : null,
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

// ───────── Expandable text ("Read more" only when the text is long) ─────────
class _ExpandText extends StatefulWidget {
  final String text;
  const _ExpandText(this.text);

  @override
  State<_ExpandText> createState() => _ExpandTextState();
}

class _ExpandTextState extends State<_ExpandText> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: _kHeading,
      fontSize: 13.5,
      height: 1.4,
      fontWeight: FontWeight.w600,
    );
    final isLong = widget.text.length > 140 || '\n'.allMatches(widget.text).length >= 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: expanded || !isLong ? null : 3,
          overflow:
          expanded || !isLong ? TextOverflow.visible : TextOverflow.ellipsis,
          style: style,
        ),
        if (isLong)
          GestureDetector(
            onTap: () => setState(() => expanded = !expanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                expanded ? 'Show less' : 'Read more',
                style: const TextStyle(
                  color: _kTeal,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ═════════════════════════ VIEW LAB EXERCISE PAGE ═════════════════════════
class ViewLabExercisePage extends StatefulWidget {
  final String labId;
  final String labName;

  const ViewLabExercisePage({
    super.key,
    required this.labId,
    required this.labName,
  });

  @override
  State<ViewLabExercisePage> createState() => _ViewLabExercisePageState();
}

class _ViewLabExercisePageState extends State<ViewLabExercisePage> {

  List exercises = [];
  bool loading = true;
  bool _fetching = false; // blocks overlapping requests
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    view_exercises();
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
      if (exercises.isEmpty) errorMsg = msg;
    });
    if (exercises.isNotEmpty) _snack(msg);
  }

  void _retry() {
    setState(() {
      loading = true;
      errorMsg = null;
    });
    view_exercises();
  }

  bool _isOverdue(dynamic deadline) {
    final raw = _txt(deadline, '');
    if (raw.isEmpty) return false;
    var d = DateTime.tryParse(raw);
    if (d == null) return false;
    if (raw.length <= 10) d = d.add(const Duration(days: 1)); // date only
    return d.isBefore(DateTime.now());
  }

  Uri? _validLink(String raw) {
    final uri = Uri.tryParse(raw.trim());
    if (uri == null || uri.host.isEmpty) return null;
    if (uri.scheme != 'http' && uri.scheme != 'https') return null;
    return uri;
  }

  String _fileName(Uri uri) {
    try {
      if (uri.pathSegments.isNotEmpty && uri.pathSegments.last.isNotEmpty) {
        return Uri.decodeComponent(uri.pathSegments.last);
      }
    } catch (_) {}
    return 'Reference file';
  }

  Future<void> _openReference(String raw) async {
    final uri = _validLink(raw);

    if (uri == null) {
      _snack('Invalid reference file link');
      return;
    }

    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) _snack('Could not open the reference file');
    } catch (e) {
      _snack('Could not open the reference file');
    }
  }

  Future<bool> _confirmLate() async {
    final res = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: _kBorder, width: 1.2),
        ),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        contentPadding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
        actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        title: const _SectionLabel('Deadline passed', Icons.timer_off_rounded),
        content: const Text(
          'The deadline for this exercise is over. Do you still want to submit?',
          style: TextStyle(color: _kMuted, height: 1.4, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',
                style: TextStyle(color: _kMuted, fontWeight: FontWeight.w700)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: _kTeal,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Submit anyway',
                style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
    return res == true;
  }

  Future<void> _openSubmit(Map item) async {
    final id = _txt(item['id'], '');
    if (id.isEmpty) {
      _snack('Invalid exercise. Please refresh and try again');
      return;
    }

    if (_isOverdue(item['deadline'])) {
      final go = await _confirmLate();
      if (!go || !mounted) return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubmitLabExercisePage(
          instructionId: id,
          exerciseTitle: _txt(item['title'], 'Lab Exercise'),
        ),
      ),
    );
  }

  void _openSubmissions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ViewLabSubmissionsPage(),
      ),
    );
  }

  // ───────── UI ─────────
  Widget _referenceRow(String refFile) {
    // 1) none
    if (refFile.isEmpty) {
      return _refBox(
        icon: Icons.attach_file_rounded,
        iconColor: _kMuted,
        title: 'No reference file available',
        subtitle: null,
        onTap: null,
        muted: true,
      );
    }

    // 2) invalid link
    final uri = _validLink(refFile);
    if (uri == null) {
      return _refBox(
        icon: Icons.link_off_rounded,
        iconColor: _kDanger,
        title: 'Invalid file link',
        subtitle: 'The reference file cannot be opened',
        onTap: null,
        muted: false,
      );
    }

    // 3) ok
    return _refBox(
      icon: Icons.description_rounded,
      iconColor: _kTeal,
      title: _fileName(uri),
      subtitle: 'Tap to open reference file',
      onTap: () => _openReference(refFile),
      muted: false,
    );
  }

  Widget _refBox({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String? subtitle,
    required VoidCallback? onTap,
    required bool muted,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCanvas,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kBorder),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: muted ? _kMuted : _kHeading,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        fontStyle: muted ? FontStyle.italic : FontStyle.normal,
                      ),
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                            color: _kMuted,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(Icons.open_in_new_rounded,
                    size: 18, color: _kTeal),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(Map item) {
    final refFile = _txt(item['reference_file'], '');
    final overdue = _isOverdue(item['deadline']);
    final id = _txt(item['id'], '');

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title + overdue chip ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kTile,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.assignment_rounded,
                      color: _kTeal, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _txt(item['title'], 'Untitled exercise'),
                    style: const TextStyle(
                      color: _kHeading,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                if (overdue) ...[
                  const SizedBox(width: 8),
                  const _StatusChip('Overdue'),
                ],
              ],
            ),
            const SizedBox(height: 14),

            // ── Instruction ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCanvas,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _kBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Exercise',
                      style: TextStyle(
                        color: _kMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 4),
                  _ExpandText(
                      _txt(item['instruction'], 'No instructions provided')),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // ── Dates ──
            _InfoRow(Icons.event_rounded, 'Date', _fmtDate(item['date'])),
            _InfoRow(
              Icons.timer_rounded,
              'Deadline',
              _fmtDate(item['deadline']),
              valueColor: overdue ? _kDanger : null,
            ),
            const SizedBox(height: 10),

            // ── Reference file ──
            _referenceRow(refFile),
            const SizedBox(height: 14),

            // ── Compact actions (side by side) ──
            Row(
              children: [
                Expanded(
                  child: _CompactButton(
                    label: 'Submit',
                    icon: Icons.upload_file_rounded,
                    filled: true,
                    onPressed: id.isEmpty ? null : () => _openSubmit(item),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _CompactButton(
                    label: 'My Uploads',
                    icon: Icons.folder_open_rounded,
                    filled: false,
                    onPressed: _openSubmissions,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollable(Widget child) => RefreshIndicator(
    color: _kTeal,
    onRefresh: view_exercises,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [const SizedBox(height: 70), child],
    ),
  );

  Widget _body() {
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: _kTeal));
    }

    if (errorMsg != null && exercises.isEmpty) {
      return _scrollable(_ErrorState(message: errorMsg!, onRetry: _retry));
    }

    if (exercises.isEmpty) {
      return _scrollable(const _EmptyState(
        icon: Icons.assignment_outlined,
        title: 'No lab exercises found',
        message: 'Exercises added for this lab will appear here.',
      ));
    }

    return RefreshIndicator(
      color: _kTeal,
      onRefresh: view_exercises,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final item = exercises[index];
          if (item is! Map) return const SizedBox.shrink();
          return _card(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = _txt(widget.labName, 'Lab Exercises');
    final subtitle = loading
        ? 'Loading exercises...'
        : exercises.isEmpty
        ? 'No exercises added yet.'
        : '${exercises.length} exercise${exercises.length == 1 ? '' : 's'} available';

    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar(title),
      body: Column(
        children: [
          _Header(
            title: 'Lab exercises',
            subtitle: subtitle,
            icon: Icons.assignment_rounded,
          ),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  // ───────── Load data ─────────
  Future<void> view_exercises() async {
    if (_fetching) return;
    _fetching = true;

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();

      String url = (sh.getString('url') ?? '').trim();

      if (url.isEmpty) {
        _fail('Session expired. Please log in again');
        return;
      }

      if (widget.labId.trim().isEmpty) {
        _fail('Invalid lab. Please go back and try again');
        return;
      }

      while (url.endsWith('/')) {
        url = url.substring(0, url.length - 1);
      }

      final response = await http.post(
        Uri.parse('$url/flutter_view_lab_exercises/'),
        body: {
          'lab_id': widget.labId,
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        _fail('Network error (${response.statusCode}). Please try again');
        return;
      }

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (data is Map && data['status'].toString() == 'ok') {
        final raw = data['exercises'];
        setState(() {
          exercises = raw is List ? raw : [];
          loading = false;
          errorMsg = null;
        });
      } else {
        _fail((data is Map ? data['message'] : null)?.toString() ??
            'Unable to load exercises');
      }
    } on TimeoutException {
      _fail('Request timed out. Check your connection and try again');
    } on SocketException {
      _fail('No internet connection or server unreachable');
    } on FormatException {
      _fail('Unexpected response from server');
    } catch (e) {
      _fail('Unable to load exercises');
    } finally {
      _fetching = false;
    }
  }
}