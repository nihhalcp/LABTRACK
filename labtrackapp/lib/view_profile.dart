//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ViewProfilePage(),
//   ));
// }
//
// class ViewProfilePage extends StatefulWidget {
//   const ViewProfilePage({super.key});
//
//   @override
//   State<ViewProfilePage> createState() => _ViewProfilePageState();
// }
//
// class _ViewProfilePageState extends State<ViewProfilePage> {
//
//   String name = '';
//   String course = '';
//   String sem = '';
//   String dob = '';
//   String gender = '';
//   String photo = '';
//   String phone = '';
//   String email = '';
//   String address = '';
//
//   @override
//   void initState() {
//     super.initState();
//     view_profile();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("View Profile"),
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//
//           children: [
//
//             Center(
//               child: photo.isNotEmpty
//                   ? CircleAvatar(
//                 radius: 55,
//                 backgroundImage: NetworkImage(photo),
//               )
//                   : const CircleAvatar(
//                 radius: 55,
//                 child: Icon(
//                   Icons.person,
//                   size: 55,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             Center(
//               child: Text(
//                 name,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 25),
//
//             Text("Course: $course"),
//             const SizedBox(height: 15),
//
//             Text("Semester: $sem"),
//             const SizedBox(height: 15),
//
//             Text("Date of Birth: $dob"),
//             const SizedBox(height: 15),
//
//             Text("Gender: $gender"),
//             const SizedBox(height: 15),
//
//             Text("Phone: $phone"),
//             const SizedBox(height: 15),
//
//             Text("Email: $email"),
//             const SizedBox(height: 15),
//
//             Text("Address: $address"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void view_profile() async {
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
//     Uri.parse('$url/flutter_view_profile/');
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
//
//             name = jsonDecode(response.body)['name'].toString();
//             course = jsonDecode(response.body)['course'].toString();
//             sem = jsonDecode(response.body)['sem'].toString();
//             dob = jsonDecode(response.body)['dob'].toString();
//             gender = jsonDecode(response.body)['gender'].toString();
//             phone = jsonDecode(response.body)['phone'].toString();
//             email = jsonDecode(response.body)['email'].toString();
//             address = jsonDecode(response.body)['address'].toString();
//
//             photo = jsonDecode(response.body)['photo'].toString();
//
//           });
//
//         } else {
//
//           Fluttertoast.showToast(
//             msg: "Unable to load profile",
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


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ViewProfilePage(),
  ));
}

// ═════════════════════════ VIEW PROFILE PAGE ═════════════════════════
class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {

  String name = '';
  String course = '';
  String sem = '';
  String dob = '';
  String gender = '';
  String photo = '';
  String phone = '';
  String email = '';
  String address = '';

  bool loading = true;
  bool _loaded = false; // true once profile data has been received
  bool _fetching = false; // blocks overlapping requests
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    view_profile();
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
      if (!_loaded) errorMsg = msg;
    });
    if (_loaded) _snack(msg);
  }

  void _retry() {
    setState(() {
      loading = true;
      errorMsg = null;
    });
    view_profile();
  }

  Uri? get _photoUri {
    final uri = Uri.tryParse(photo.trim());
    if (uri == null || uri.host.isEmpty) return null;
    if (uri.scheme != 'http' && uri.scheme != 'https') return null;
    return uri;
  }

  // ───────── Load data ─────────
  Future<void> view_profile() async {
    if (_fetching) return;
    _fetching = true;

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
        Uri.parse('$url/flutter_view_profile/'),
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
        setState(() {
          name = _txt(data['name'], '');
          course = _txt(data['course'], '');
          sem = _txt(data['sem'], '');
          dob = _txt(data['dob'], '');
          gender = _txt(data['gender'], '');
          phone = _txt(data['phone'], '');
          email = _txt(data['email'], '');
          address = _txt(data['address'], '');

          photo = _txt(data['photo'], '');

          loading = false;
          _loaded = true;
          errorMsg = null;
        });
      } else {
        _fail((data is Map ? data['message'] : null)?.toString() ??
            'Unable to load profile');
      }
    } on TimeoutException {
      _fail('Request timed out. Check your connection and try again');
    } on SocketException {
      _fail('No internet connection or server unreachable');
    } on FormatException {
      _fail('Unexpected response from server');
    } catch (e) {
      _fail('Unable to load profile');
    } finally {
      _fetching = false;
    }
  }

  // ───────── UI ─────────
  Widget _avatar() {
    final initial = name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();
    final fallback = Center(
      child: Text(
        initial,
        style: const TextStyle(
          color: _kTeal,
          fontSize: 40,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
    final uri = _photoUri;

    return Container(
      width: 108,
      height: 108,
      padding: const EdgeInsets.all(3.5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [_kCyan, _kTeal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: Color(0x4D000000), blurRadius: 16, offset: Offset(0, 8)),
        ],
      ),
      child: ClipOval(
        child: Container(
          color: _kTile,
          child: uri == null
              ? fallback
              : Image.network(
            uri.toString(),
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                      strokeWidth: 2.2, color: _kTeal),
                ),
              );
            },
            errorBuilder: (context, error, stack) => fallback,
          ),
        ),
      ),
    );
  }

  Widget _profileHeader() {
    const r = BorderRadius.only(
      bottomLeft: Radius.circular(28),
      bottomRight: Radius.circular(28),
    );
    final hasCourse = course.isNotEmpty;

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
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    _avatar(),
                    const SizedBox(height: 14),
                    Text(
                      name.isEmpty ? 'Student' : name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    if (hasCourse) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          sem.isEmpty ? course : '$course · Sem $sem',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFFD7EAF4),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData get _genderIcon {
    final g = gender.toLowerCase();
    if (g.startsWith('m')) return Icons.male_rounded;
    if (g.startsWith('f')) return Icons.female_rounded;
    return Icons.person_rounded;
  }

  Widget _profileBody() {
    String v(String s) => s.isEmpty ? 'Not provided' : s;

    return RefreshIndicator(
      color: _kTeal,
      onRefresh: view_profile,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SectionLabel(
                            'Academic', Icons.school_rounded),
                        const SizedBox(height: 12),
                        _InfoRow(Icons.menu_book_rounded, 'Course', v(course)),
                        _InfoRow(Icons.layers_rounded, 'Semester', v(sem)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SectionLabel(
                            'Personal', Icons.badge_rounded),
                        const SizedBox(height: 12),
                        _InfoRow(Icons.cake_rounded, 'Date of Birth',
                            _fmtDate(dob, 'Not provided')),
                        _InfoRow(_genderIcon, 'Gender', v(gender)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SectionLabel(
                            'Contact', Icons.contact_phone_rounded),
                        const SizedBox(height: 12),
                        _InfoRow(Icons.phone_rounded, 'Phone', v(phone)),
                        _InfoRow(Icons.email_rounded, 'Email', v(email)),
                        _InfoRow(
                            Icons.location_on_rounded, 'Address', v(address)),
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

  Widget _scrollable(Widget child) => RefreshIndicator(
    color: _kTeal,
    onRefresh: view_profile,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [const SizedBox(height: 90), child],
    ),
  );

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (loading) {
      body = const Center(child: CircularProgressIndicator(color: _kTeal));
    } else if (!_loaded) {
      body = _scrollable(_ErrorState(
        message: errorMsg ?? 'Unable to load profile',
        onRetry: _retry,
      ));
    } else {
      body = _profileBody();
    }

    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('Profile'),
      body: body,
    );
  }
}