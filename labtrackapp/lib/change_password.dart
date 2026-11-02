//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ChangePasswordPage extends StatefulWidget {
//   const ChangePasswordPage({super.key});
//
//   @override
//   State<ChangePasswordPage> createState() => _ChangePasswordPageState();
// }
//
// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//   final TextEditingController oldController = TextEditingController();
//   final TextEditingController newController = TextEditingController();
//   final TextEditingController confirmController = TextEditingController();
//
//   bool loading = false;
//
//   Future<void> changePassword() async {
//     if (oldController.text.isEmpty ||
//         newController.text.isEmpty ||
//         confirmController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Fill all fields')),
//       );
//       return;
//     }
//
//     if (newController.text != confirmController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Passwords do not match')),
//       );
//       return;
//     }
//
//     setState(() {
//       loading = true;
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
//         Uri.parse("${url}flutter_change_password/"),
//         body: {
//           'lid': lid,
//           'old_password': oldController.text,
//           'new_password': newController.text,
//           'confirm_password': confirmController.text,
//         },
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (!mounted) return;
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(data['message'] ?? 'Request completed')),
//       );
//
//       if (data['status'] == 'ok') {
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       print(e);
//
//       if (!mounted) return;
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Unable to change password')),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           loading = false;
//         });
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     oldController.dispose();
//     newController.dispose();
//     confirmController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Change Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: oldController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Old Password',
//               ),
//             ),
//             TextField(
//               controller: newController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'New Password',
//               ),
//             ),
//             TextField(
//               controller: confirmController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Confirm Password',
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: loading ? null : changePassword,
//               child: Text(loading ? 'Changing...' : 'Change Password'),
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

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool loading = false;
  bool showOld = false;
  bool showNew = false;
  bool showConfirm = false;

  // ── Validators ──
  String? _validateOld(String? v) {
    if (v == null || v.isEmpty) return 'Enter your old password';
    return null;
  }

  String? _validateNew(String? v) {
    if (v == null || v.isEmpty) return 'Enter a new password';
    if (v.contains(' ')) return 'Password must not contain spaces';
    if (v.length < 8) return 'Use at least 8 characters';
    if (v.length > 64) return 'Use at most 64 characters';
    if (!RegExp(r'[A-Z]').hasMatch(v)) {
      return 'Add at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(v)) {
      return 'Add at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(v)) return 'Add at least one number';
    if (!RegExp(r'[^A-Za-z0-9]').hasMatch(v)) {
      return 'Add at least one special character (e.g. @ # \$ !)';
    }
    if (v == oldController.text) {
      return 'New password must be different from the old one';
    }
    return null;
  }

  String? _validateConfirm(String? v) {
    if (v == null || v.isEmpty) return 'Confirm your new password';
    if (v != newController.text) return 'Passwords do not match';
    return null;
  }

  Future<void> changePassword() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      _snack(context, 'Please fix the highlighted fields', error: true);
      return;
    }

    setState(() {
      loading = true;
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
        Uri.parse("${url}flutter_change_password/"),
        body: {
          'lid': lid,
          'old_password': oldController.text,
          'new_password': newController.text,
          'confirm_password': confirmController.text,
        },
      ).timeout(const Duration(seconds: 20));

      if (!mounted) return;

      if (response.statusCode != 200) {
        _snack(context, 'Server error (${response.statusCode}). Try again.',
            error: true);
        return;
      }

      var data = jsonDecode(response.body);

      final ok = data['status'] == 'ok';
      _snack(context, data['message'] ?? 'Request completed', error: !ok);

      if (ok) {
        Navigator.pop(context);
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

      _snack(context, 'Unable to change password', error: true);
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    oldController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Widget _eye(bool shown, VoidCallback toggle) => IconButton(
    icon: Icon(
      shown ? Icons.visibility_rounded : Icons.visibility_off_rounded,
      color: _kMuted,
      size: 20,
    ),
    onPressed: toggle,
  );

  Widget _rule(bool ok, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(
          ok ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
          size: 15,
          color: ok ? const Color(0xFF1C7C54) : _kMuted,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ok ? const Color(0xFF1C7C54) : _kMuted,
          ),
        ),
      ],
    ),
  );

  Widget _rules() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: newController,
      builder: (context, value, _) {
        final v = value.text;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCanvas,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _rule(v.length >= 8, 'At least 8 characters'),
              _rule(RegExp(r'[A-Z]').hasMatch(v), 'One uppercase letter'),
              _rule(RegExp(r'[a-z]').hasMatch(v), 'One lowercase letter'),
              _rule(RegExp(r'[0-9]').hasMatch(v), 'One number'),
              _rule(RegExp(r'[^A-Za-z0-9]').hasMatch(v),
                  'One special character'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('Change Password'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(
              title: 'Keep it secure',
              subtitle: 'Update your LabTrack password regularly.',
              icon: Icons.lock_rounded,
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
                          'Password details', Icons.vpn_key_rounded),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: oldController,
                        obscureText: !showOld,
                        validator: _validateOld,
                        textInputAction: TextInputAction.next,
                        decoration: _input(
                          'Old Password',
                          icon: Icons.lock_outline_rounded,
                          suffix: _eye(showOld,
                                  () => setState(() => showOld = !showOld)),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: newController,
                        obscureText: !showNew,
                        validator: _validateNew,
                        textInputAction: TextInputAction.next,
                        decoration: _input(
                          'New Password',
                          icon: Icons.lock_reset_rounded,
                          suffix: _eye(showNew,
                                  () => setState(() => showNew = !showNew)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _rules(),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: confirmController,
                        obscureText: !showConfirm,
                        validator: _validateConfirm,
                        textInputAction: TextInputAction.done,
                        decoration: _input(
                          'Confirm Password',
                          icon: Icons.verified_user_rounded,
                          suffix: _eye(showConfirm,
                                  () => setState(() => showConfirm = !showConfirm)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _GradButton(
                        label: loading ? 'Changing...' : 'Change Password',
                        icon: Icons.check_rounded,
                        loading: loading,
                        onPressed: changePassword,
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