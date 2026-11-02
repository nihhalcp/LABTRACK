// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:labtrackapp/send_feedback.dart';
//
// class ViewFeedbackPage extends StatefulWidget {
//   const ViewFeedbackPage({super.key});
//
//   @override
//   State<ViewFeedbackPage> createState() => _ViewFeedbackPageState();
// }
//
// class _ViewFeedbackPageState extends State<ViewFeedbackPage> {
//   List feedbacks = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     viewFeedback();
//   }
//
//   Future<void> viewFeedback() async {
//     try {
//       final sh = await SharedPreferences.getInstance();
//       String url = sh.getString("url") ?? "";
//       String lid = sh.getString("lid") ?? "";
//
//       url = url.endsWith('/') ? url : '$url/';
//
//       if (!url.endsWith('/myapp/')) {
//         url = '${url}myapp/';
//       }
//
//       var response = await http.post(
//         Uri.parse("${url}flutter_view_feedback/"),
//         body: {
//           'lid': lid,
//         },
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (!mounted) return;
//
//       if (data['status'] == 'ok') {
//         setState(() {
//           feedbacks = data['feedbacks'];
//           loading = false;
//         });
//       } else {
//         setState(() {
//           loading = false;
//         });
//       }
//     } catch (e) {
//       print(e);
//
//       if (mounted) {
//         setState(() {
//           loading = false;
//         });
//       }
//     }
//   }
//
//   void addFeedback() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const SendFeedbackPage(),
//       ),
//     ).then((value) {
//       viewFeedback();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Feedback'),
//       ),
//       body: loading
//           ? const Center(
//         child: CircularProgressIndicator(),
//       )
//           : feedbacks.isEmpty
//           ? RefreshIndicator(
//         onRefresh: viewFeedback,
//         child: ListView(
//           children: const [
//             SizedBox(height: 250),
//             Center(
//               child: Text('No feedback found'),
//             ),
//           ],
//         ),
//       )
//           : RefreshIndicator(
//         onRefresh: viewFeedback,
//         child: ListView.builder(
//           itemCount: feedbacks.length,
//           itemBuilder: (context, index) {
//             var i = feedbacks[index];
//
//             return Card(
//               margin: const EdgeInsets.all(10),
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'My Feedback',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(i['review'] ?? ''),
//                     const SizedBox(height: 10),
//                     Row(
//                       children: [
//                         const Text('Rating: '),
//                         ...List.generate(
//                           int.tryParse(
//                             i['rating'].toString(),
//                           ) ??
//                               0,
//                               (index) => const Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                             size: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text('Date: ${i['date'] ?? ''}'),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: addFeedback,
//         child: const Icon(Icons.add),
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
import 'package:labtrackapp/send_feedback.dart';

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

// ═════════════════════════ VIEW FEEDBACK PAGE ═════════════════════════
class ViewFeedbackPage extends StatefulWidget {
  const ViewFeedbackPage({super.key});

  @override
  State<ViewFeedbackPage> createState() => _ViewFeedbackPageState();
}

class _ViewFeedbackPageState extends State<ViewFeedbackPage> {
  List feedbacks = [];
  bool loading = true;
  String? errorMsg;

  static const List<String> _ratingText = [
    'Poor',
    'Fair',
    'Good',
    'Very good',
    'Excellent',
  ];

  @override
  void initState() {
    super.initState();
    viewFeedback();
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
      if (feedbacks.isEmpty) errorMsg = msg;
    });
    if (feedbacks.isNotEmpty) _snack(msg);
  }

  void _retry() {
    setState(() {
      loading = true;
      errorMsg = null;
    });
    viewFeedback();
  }

  Color _ratingColor(int r) {
    if (r <= 2) return _kDanger;
    if (r == 3) return _kAmber;
    return _kSuccess;
  }

  // ───────── Load data ─────────
  Future<void> viewFeedback() async {
    try {
      final sh = await SharedPreferences.getInstance();
      String url = (sh.getString("url") ?? "").trim();
      String lid = (sh.getString("lid") ?? "").trim();

      if (url.isEmpty || lid.isEmpty) {
        _fail('Session expired. Please log in again');
        return;
      }

      url = url.endsWith('/') ? url : '$url/';

      if (!url.endsWith('/myapp/')) {
        url = '${url}myapp/';
      }

      var response = await http.post(
        Uri.parse("${url}flutter_view_feedback/"),
        body: {
          'lid': lid,
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        _fail('Server error (${response.statusCode}). Please try again');
        return;
      }

      var data = jsonDecode(response.body);

      if (!mounted) return;

      if (data is Map && data['status'] == 'ok') {
        final raw = data['feedbacks'];
        setState(() {
          feedbacks = raw is List ? raw : [];
          loading = false;
          errorMsg = null;
        });
      } else {
        _fail((data is Map ? data['message'] : null)?.toString() ??
            'Unable to load feedback');
      }
    } on TimeoutException {
      _fail('Request timed out. Check your connection and try again');
    } on SocketException {
      _fail('No internet connection or server unreachable');
    } on FormatException {
      _fail('Unexpected response from server');
    } catch (e) {
      print(e);
      _fail('Unable to load feedback');
    }
  }

  void addFeedback() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SendFeedbackPage(),
      ),
    ).then((value) {
      if (mounted) viewFeedback();
    });
  }

  // ───────── UI ─────────
  Widget _card(Map i) {
    final int rating = _toInt(i['rating']).clamp(0, 5).toInt();
    final Color rc = rating == 0 ? _kMuted : _ratingColor(rating);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionLabel('My Feedback', Icons.rate_review_rounded),
            const SizedBox(height: 14),
            Text(
              _txt(i['review'], 'No comments'),
              style: const TextStyle(
                color: _kHeading,
                fontSize: 14.5,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: _kCanvas,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _kBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: List.generate(5, (index) {
                          final filled = index < rating;
                          return Icon(
                            filled
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 26,
                            color: filled
                                ? const Color(0xFFFBBF24)
                                : const Color(0xFFB9C9D8),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: rc.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      rating == 0
                          ? 'No rating'
                          : '$rating / 5 · ${_ratingText[rating - 1]}',
                      style: TextStyle(
                        color: rc,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.event_rounded, size: 16, color: _kMuted),
                const SizedBox(width: 6),
                Text('Date: ${_fmtDate(i['date'], '')}',
                    style: const TextStyle(
                      color: _kMuted,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollable(Widget child) => RefreshIndicator(
    color: _kTeal,
    onRefresh: viewFeedback,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [const SizedBox(height: 70), child],
    ),
  );

  Widget _body() {
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: _kTeal));
    }

    if (errorMsg != null && feedbacks.isEmpty) {
      return _scrollable(_ErrorState(message: errorMsg!, onRetry: _retry));
    }

    if (feedbacks.isEmpty) {
      return _scrollable(const _EmptyState(
        icon: Icons.rate_review_outlined,
        title: 'No feedback found',
        message: 'Tap "New Feedback" to share your thoughts with us.',
      ));
    }

    return RefreshIndicator(
      color: _kTeal,
      onRefresh: viewFeedback,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 96),
        itemCount: feedbacks.length,
        itemBuilder: (context, index) {
          final item = feedbacks[index];
          if (item is! Map) return const SizedBox.shrink();
          return _card(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitle = loading
        ? 'Loading your feedback...'
        : feedbacks.isEmpty
        ? 'You have not sent any feedback yet.'
        : '${feedbacks.length} feedback${feedbacks.length == 1 ? '' : 's'} sent by you';

    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('My Feedback'),
      body: Column(
        children: [
          _Header(
            title: 'Your feedback',
            subtitle: subtitle,
            icon: Icons.rate_review_rounded,
          ),
          Expanded(child: _body()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _kTeal,
        foregroundColor: Colors.white,
        elevation: 4,
        onPressed: addFeedback,
        icon: const Icon(Icons.add),
        label: const Text('New Feedback',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}