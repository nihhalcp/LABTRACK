//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SendFeedbackPage extends StatefulWidget {
//   const SendFeedbackPage({super.key});
//
//   @override
//   State<SendFeedbackPage> createState() => _SendFeedbackPageState();
// }
//
// class _SendFeedbackPageState extends State<SendFeedbackPage> {
//   final TextEditingController reviewController = TextEditingController();
//
//   int rating = 5;
//   bool sending = false;
//
//   Future<void> sendFeedback() async {
//     if (reviewController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Enter your feedback')),
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
//         Uri.parse("${url}flutter_send_feedback/"),
//         body: {
//           'lid': lid,
//           'review': reviewController.text.trim(),
//           'rating': rating.toString(),
//         },
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (!mounted) return;
//
//       if (data['status'] == 'ok') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Feedback sent successfully')),
//         );
//
//         Navigator.pop(context, true);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to send feedback')),
//         );
//       }
//     } catch (e) {
//       print(e);
//
//       if (!mounted) return;
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Unable to send feedback')),
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
//     reviewController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Send Feedback'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Rating',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: List.generate(5, (index) {
//                 return IconButton(
//                   onPressed: () {
//                     setState(() {
//                       rating = index + 1;
//                     });
//                   },
//                   icon: Icon(
//                     index < rating
//                         ? Icons.star
//                         : Icons.star_border,
//                     color: Colors.amber,
//                     size: 35,
//                   ),
//                 );
//               }),
//             ),
//             Text(
//               '$rating / 5 Stars',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.amber,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 15),
//             TextField(
//               controller: reviewController,
//               maxLines: 5,
//               decoration: const InputDecoration(
//                 labelText: 'Enter your feedback',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 15),
//             ElevatedButton(
//               onPressed: sending ? null : sendFeedback,
//               child: Text(
//                 sending ? 'Sending...' : 'Send Feedback',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController reviewController = TextEditingController();

  int rating = 5;
  int? _hoverRating;
  bool sending = false;

  static const int _minLen = 10;
  static const int _maxLen = 500;

  static const List<String> _ratingText = [
    'Poor',
    'Fair',
    'Good',
    'Very good',
    'Excellent',
  ];

  // ───────── ORIGINAL FUNCTION (unchanged) ─────────
  Future<void> sendFeedback() async {
    if (reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter your feedback')),
      );
      return;
    }

    setState(() {
      sending = true;
    });

    try {
      final sh = await SharedPreferences.getInstance();
      String url = sh.getString("url") ?? "";
      String lid = sh.getString("lid") ?? "";

      url = url.endsWith('/') ? url : '$url/';

      if (!url.endsWith('/myapp/')) {
        url = '${url}myapp/';
      }

      var response = await http.post(
        Uri.parse("${url}flutter_send_feedback/"),
        body: {
          'lid': lid,
          'review': reviewController.text.trim(),
          'rating': rating.toString(),
        },
      );

      var data = jsonDecode(response.body);

      if (!mounted) return;

      if (data['status'] == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback sent successfully')),
        );

        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send feedback')),
        );
      }
    } catch (e) {
      print(e);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to send feedback')),
      );
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
    reviewController.dispose();
    super.dispose();
  }

  // ───────── Validation (form level, does not touch sendFeedback) ─────────
  String? _validateReview(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return 'Enter your feedback';
    if (t.length < _minLen) {
      return 'Please write at least $_minLen characters (${t.length}/$_minLen)';
    }
    if (t.length > _maxLen) return 'Feedback is too long (max $_maxLen)';
    if (!RegExp(r'[A-Za-z]').hasMatch(t)) {
      return 'Feedback must contain meaningful text';
    }
    if (RegExp(r'^(.)\1+$').hasMatch(t.replaceAll(' ', ''))) {
      return 'Please write your feedback properly';
    }
    return null;
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();

    if (rating < 1 || rating > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a rating between 1 and 5')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      sendFeedback();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the highlighted field')),
      );
    }
  }

  // ───────── UI ─────────
  Color get _ratingColor {
    if (rating <= 2) return _kDanger;
    if (rating == 3) return const Color(0xFFE08A0B);
    return const Color(0xFF1C7C54);
  }

  Widget _stars() {
    final shown = _hoverRating ?? rating;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final filled = index < shown;
        final hovered = _hoverRating == index + 1;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hoverRating = index + 1),
          onExit: (_) => setState(() => _hoverRating = null),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => rating = index + 1),
            child: AnimatedScale(
              scale: hovered ? 1.22 : 1,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  filled ? Icons.star_rounded : Icons.star_outline_rounded,
                  size: 44,
                  color: filled
                      ? const Color(0xFFFBBF24)
                      : const Color(0xFFB9C9D8),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('Send Feedback'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(
              title: 'Share your feedback',
              subtitle: 'Tell us how LabTrack is working for you.',
              icon: Icons.rate_review_rounded,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 28),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Rating ──
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionLabel('Rating', Icons.star_rounded),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: _kCanvas,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: _kBorder),
                            ),
                            child: Column(
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: _stars(),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _ratingColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    '$rating / 5 · ${_ratingText[rating - 1]}',
                                    style: TextStyle(
                                      color: _ratingColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Feedback text ──
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionLabel(
                              'Your feedback', Icons.edit_note_rounded),
                          const SizedBox(height: 18),
                          TextFormField(
                            controller: reviewController,
                            validator: _validateReview,
                            maxLines: 5,
                            maxLength: _maxLen,
                            textCapitalization: TextCapitalization.sentences,
                            style:
                            const TextStyle(color: _kHeading, height: 1.4),
                            decoration: _input(
                              'Enter your feedback',
                              hint: 'What do you like? What can we improve?',
                              alignTop: true,
                            ),
                          ),
                          const SizedBox(height: 14),
                          _GradButton(
                            label: sending ? 'Sending...' : 'Send Feedback',
                            icon: Icons.send_rounded,
                            loading: sending,
                            onPressed: _onSubmit,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}