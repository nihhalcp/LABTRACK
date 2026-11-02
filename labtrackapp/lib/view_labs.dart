//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:labtrackapp/view_lab_excercise.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ViewLabsPage(),
//   ));
// }
//
// class ViewLabsPage extends StatefulWidget {
//   const ViewLabsPage({super.key});
//
//   @override
//   State<ViewLabsPage> createState() => _ViewLabsPageState();
// }
//
// class _ViewLabsPageState extends State<ViewLabsPage> {
//
//   List labs = [];
//
//   @override
//   void initState() {
//     super.initState();
//     view_labs();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("View Labs"),
//       ),
//
//       body: labs.isEmpty
//           ? const Center(
//         child: Text("No labs found"),
//       )
//           : ListView.builder(
//         padding: const EdgeInsets.all(15),
//         itemCount: labs.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.only(bottom: 15),
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//
//                 children: [
//
//                   Text(
//                     labs[index]['lab_name'].toString(),
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Text(
//                     "Room Number: ${labs[index]['room_number']}",
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Text(
//                     "Description: ${labs[index]['description']}",
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Text(
//                     "Status: ${labs[index]['status']}",
//                   ),
//
//                   const SizedBox(height: 15),
//
//                   const Text(
//                     "Assigned Coordinators",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   if ((labs[index]['coordinators'] as List).isEmpty)
//                     const Text("No coordinator assigned")
//                   else
//                     for (var c in labs[index]['coordinators'])
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           Text(
//                             "Name: ${c['name']}",
//                           ),
//
//                           Text(
//                             "Phone: ${c['phone']}",
//                           ),
//
//                           Text(
//                             "Email: ${c['email']}",
//                           ),
//
//                           const SizedBox(height: 10),
//                           const SizedBox(height: 10),
//
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ViewLabExercisePage(
//                                     labId: labs[index]['id'].toString(),
//                                     labName: labs[index]['lab_name'].toString(),
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: const Text("View Lab Exercises"),
//                           ),
//                         ],
//                       ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void view_labs() async {
//
//     SharedPreferences sh =
//     await SharedPreferences.getInstance();
//
//     String url =
//     sh.getString('url').toString();
//
//     String lid =
//     sh.getString('lid').toString();
//
//     final urls =
//     Uri.parse('$url/flutter_view_labs/');
//
//     try {
//
//       final response = await http.post(
//         urls,
//
//         body: {
//           'lid': lid,
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
//             labs = jsonDecode(response.body)['labs'];
//           });
//
//         } else {
//
//           Fluttertoast.showToast(
//             msg: "Unable to load labs",
//           );
//         }
//
//       } else {
//
//         Fluttertoast.showToast(
//           msg: "Network Error",
//         );
//       }
//
//     } catch (e) {
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
import 'package:labtrackapp/view_lab_excercise.dart';

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
    home: ViewLabsPage(),
  ));
}

// ═════════════════════════ VIEW LABS PAGE ═════════════════════════
class ViewLabsPage extends StatefulWidget {
  const ViewLabsPage({super.key});

  @override
  State<ViewLabsPage> createState() => _ViewLabsPageState();
}

class _ViewLabsPageState extends State<ViewLabsPage> {

  List labs = [];
  bool loading = true;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    view_labs();
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
      if (labs.isEmpty) errorMsg = msg;
    });
    if (labs.isNotEmpty) _snack(msg);
  }

  void _retry() {
    setState(() {
      loading = true;
      errorMsg = null;
    });
    view_labs();
  }

  void _openExercises(Map lab) {
    final id = _txt(lab['id'], '');
    if (id.isEmpty) {
      _snack('Invalid lab. Please refresh and try again');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewLabExercisePage(
          labId: id,
          labName: _txt(lab['lab_name'], 'Lab Exercises'),
        ),
      ),
    );
  }

  // ───────── Load data ─────────
  Future<void> view_labs() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();

      String url = (sh.getString('url') ?? '').trim();
      String lid = (sh.getString('lid') ?? '').trim();

      if (url.isEmpty || lid.isEmpty) {
        _fail('Session expired. Please log in again');
        return;
      }

      while (url.endsWith('/')) {
        url = url.substring(0, url.length - 1);
      }

      final response = await http.post(
        Uri.parse('$url/flutter_view_labs/'),
        body: {
          'lid': lid,
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        _fail('Network error (${response.statusCode}). Please try again');
        return;
      }

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (data is Map && data['status'].toString() == 'ok') {
        final raw = data['labs'];
        setState(() {
          labs = raw is List ? raw : [];
          loading = false;
          errorMsg = null;
        });
      } else {
        _fail((data is Map ? data['message'] : null)?.toString() ??
            'Unable to load labs');
      }
    } on TimeoutException {
      _fail('Request timed out. Check your connection and try again');
    } on SocketException {
      _fail('No internet connection or server unreachable');
    } on FormatException {
      _fail('Unexpected response from server');
    } catch (e) {
      _fail('Unable to load labs');
    }
  }

  // ───────── UI ─────────
  Widget _coordinator(Map c) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCanvas,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(Icons.person_rounded, 'Name', _txt(c['name'])),
          _InfoRow(Icons.phone_rounded, 'Phone', _txt(c['phone'])),
          _InfoRow(Icons.email_rounded, 'Email', _txt(c['email'])),
        ],
      ),
    );
  }

  Widget _card(Map lab) {
    final rawCoords = lab['coordinators'];
    final List coordinators = rawCoords is List ? rawCoords : [];
    final status = _txt(lab['status'], 'Active');
    final description = _txt(lab['description'], 'No description');

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kTile,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.biotech_rounded,
                      color: _kTeal, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _txt(lab['lab_name'], 'Unnamed lab'),
                    style: const TextStyle(
                      color: _kHeading,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _StatusChip(status),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: _kBorder),
            const SizedBox(height: 8),
            _InfoRow(Icons.meeting_room_rounded, 'Room Number',
                _txt(lab['room_number'])),
            _InfoRow(Icons.notes_rounded, 'Description', description),
            const SizedBox(height: 14),
            const _SectionLabel(
                'Assigned Coordinators', Icons.groups_rounded),
            const SizedBox(height: 12),
            if (coordinators.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kCanvas,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _kBorder),
                ),
                child: const Text(
                  'No coordinator assigned',
                  style: TextStyle(
                    color: _kMuted,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else
              for (final c in coordinators)
                if (c is Map) _coordinator(c),
            const SizedBox(height: 10),
            _GradButton(
              label: 'View Lab Exercises',
              icon: Icons.assignment_rounded,
              loading: false,
              onPressed: () => _openExercises(lab),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollable(Widget child) => RefreshIndicator(
    color: _kTeal,
    onRefresh: view_labs,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [const SizedBox(height: 70), child],
    ),
  );

  Widget _body() {
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: _kTeal));
    }

    if (errorMsg != null && labs.isEmpty) {
      return _scrollable(_ErrorState(message: errorMsg!, onRetry: _retry));
    }

    if (labs.isEmpty) {
      return _scrollable(const _EmptyState(
        icon: Icons.biotech_outlined,
        title: 'No labs found',
        message: 'Labs assigned to you will appear here.',
      ));
    }

    return RefreshIndicator(
      color: _kTeal,
      onRefresh: view_labs,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        itemCount: labs.length,
        itemBuilder: (context, index) {
          final item = labs[index];
          if (item is! Map) return const SizedBox.shrink();
          return _card(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitle = loading
        ? 'Loading labs...'
        : labs.isEmpty
        ? 'No labs to show right now.'
        : '${labs.length} lab${labs.length == 1 ? '' : 's'} available';

    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('View Labs'),
      body: Column(
        children: [
          _Header(
            title: 'Your labs',
            subtitle: subtitle,
            icon: Icons.biotech_rounded,
          ),
          Expanded(child: _body()),
        ],
      ),
    );
  }
}