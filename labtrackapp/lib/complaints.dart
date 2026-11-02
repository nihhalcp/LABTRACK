//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:labtrackapp/view_comp.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SendComplaintPage extends StatefulWidget {
//   const SendComplaintPage({super.key});
//
//   @override
//   State<SendComplaintPage> createState() => _SendComplaintPageState();
// }
//
// class _SendComplaintPageState extends State<SendComplaintPage> {
//   final TextEditingController complaintController =
//   TextEditingController();
//
//   bool sending = false;
//
//   Future<void> sendComplaint() async {
//     if (complaintController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Enter your complaint')),
//       );
//       return;
//     }
//
//     setState(() {
//       sending = true;
//     });
//
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
//         Uri.parse("${url}flutter_send_complaint/"),
//         body: {
//           'lid': lid,
//           'complaint': complaintController.text.trim(),
//         },
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (!mounted) return;
//
//       if (data['status'] == 'ok') {
//         complaintController.clear();
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const ViewComplaintPage(),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to send complaint'),
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//
//       if (!mounted) return;
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Unable to send complaint'),
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           sending = false;
//         });
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     complaintController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Send Complaint'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: complaintController,
//               maxLines: 5,
//               decoration: const InputDecoration(
//                 labelText: 'Enter your complaint',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 15),
//             ElevatedButton(
//               onPressed: sending ? null : sendComplaint,
//               child: Text(
//                 sending ? 'Sending...' : 'Send Complaint',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labtrackapp/view_comp.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ═════════════ THEME (same look as the student home, kept private to this file) ═════════════
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

void _snack(BuildContext context, String msg, {bool error = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: error ? _kDanger : _kHeading,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Row(
          children: [
            Icon(error ? Icons.error_rounded : Icons.check_circle_rounded,
                color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(msg,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
}

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
      Text(text,
          style: const TextStyle(
            color: _kHeading,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          )),
    ],
  );
}

class _GradButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool loading;
  final VoidCallback onPressed;
  const _GradButton({
    required this.label,
    required this.icon,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: loading ? 0.7 : 1,
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
            onTap: loading ? null : onPressed,
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
                  Text(label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SendComplaintPage extends StatefulWidget {
  const SendComplaintPage({super.key});

  @override
  State<SendComplaintPage> createState() => _SendComplaintPageState();
}

class _SendComplaintPageState extends State<SendComplaintPage> {
  static const int _minLen = 10;
  static const int _maxLen = 500;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController complaintController = TextEditingController();

  bool sending = false;

  String? _validateComplaint(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return 'Enter your complaint';
    if (t.length < _minLen) {
      return 'Please write at least $_minLen characters (${t.length}/$_minLen)';
    }
    if (t.length > _maxLen) return 'Complaint is too long (max $_maxLen)';
    if (!RegExp(r'[A-Za-z]').hasMatch(t)) {
      return 'Complaint must contain meaningful text';
    }
    if (RegExp(r'^(.)\1+$').hasMatch(t.replaceAll(' ', ''))) {
      return 'Please describe the problem properly';
    }
    return null;
  }

  Future<void> sendComplaint() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      _snack(context, 'Please fix the highlighted field', error: true);
      return;
    }

    setState(() {
      sending = true;
    });

    try {
      final sh = await SharedPreferences.getInstance();
      String url = sh.getString("url") ?? "";
      String lid = sh.getString("lid") ?? "";

      if (url.trim().isEmpty || lid.trim().isEmpty) {
        if (!mounted) return;
        _snack(context, 'Session expired. Please log in again.', error: true);
        return;
      }

      url = url.endsWith('/') ? url : '$url/';

      if (!url.endsWith('/myapp/')) {
        url = '${url}myapp/';
      }

      var response = await http.post(
        Uri.parse("${url}flutter_send_complaint/"),
        body: {
          'lid': lid,
          'complaint': complaintController.text.trim(),
        },
      ).timeout(const Duration(seconds: 20));

      if (!mounted) return;

      if (response.statusCode != 200) {
        _snack(context, 'Server error (${response.statusCode}). Try again.',
            error: true);
        return;
      }

      var data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        complaintController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewComplaintPage(),
          ),
        );
      } else {
        _snack(context, data['message'] ?? 'Failed to send complaint',
            error: true);
      }
    } on TimeoutException {
      if (!mounted) return;
      _snack(context, 'Request timed out. Check your connection.', error: true);
    } on FormatException {
      if (!mounted) return;
      _snack(context, 'Invalid response from server', error: true);
    } catch (e) {
      print(e);

      if (!mounted) return;

      _snack(context, 'Unable to send complaint', error: true);
    } finally {
      if (mounted) {
        setState(() {
          sending = false;
        });
      }
    }
  }

  @override
  void dispose() {
    complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('Send Complaint'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(
              title: 'Raise an issue',
              subtitle: 'Tell us what went wrong. Staff will reply soon.',
              icon: Icons.support_agent_rounded,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 28),
              child: _Card(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionLabel(
                          'Your complaint', Icons.edit_note_rounded),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: complaintController,
                        maxLines: 6,
                        maxLength: _maxLen,
                        validator: _validateComplaint,
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(color: _kHeading, height: 1.4),
                        decoration: _input(
                          'Enter your complaint',
                          hint: 'Describe the problem in detail...',
                          alignTop: true,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _GradButton(
                        label: sending ? 'Sending...' : 'Send Complaint',
                        icon: Icons.send_rounded,
                        loading: sending,
                        onPressed: sendComplaint,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}