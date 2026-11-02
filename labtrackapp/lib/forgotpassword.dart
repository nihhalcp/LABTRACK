// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:labtrackapp/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
//
// void main() {
//   runApp(const forgotpassword());
// }
//
// class forgotpassword extends StatelessWidget {
//   const forgotpassword({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Forgot Password',
//       home: forgot_password(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class forgot_password extends StatefulWidget {
//   const forgot_password({super.key});
//
//   @override
//   State<forgot_password> createState() => _forgot_passwordState();
// }
//
// class _forgot_passwordState extends State<forgot_password> {
//   final TextEditingController email = TextEditingController();
//
//   Future<void> sendData() async {
//     String femail = email.text.trim();
//     if (femail.isEmpty || !femail.contains('@')) {
//       Fluttertoast.showToast(msg: 'Enter a valid email');
//       return;
//     }
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     final urls = Uri.parse('$url/android_forget_password_post/');
//
//     try {
//       final response = await http.post(urls, body: {
//         'email': femail,
//       });
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         String status = data['status'];
//
//         if (status == 'ok') {
//           Fluttertoast.showToast(msg: 'Password sent to email');
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const MyLoginPage(title: '')),
//           );
//         } else {
//           Fluttertoast.showToast(msg: 'Email not found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Server error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Forgot Password'),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Enter your registered email address',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: email,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 prefixIcon: Icon(Icons.email),
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: sendData,
//                 child: const Text('Send Password'),
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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labtrackapp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


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

void main() {
  runApp(const forgotpassword());
}

class forgotpassword extends StatelessWidget {
  const forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Forgot Password',
      home: forgot_password(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class forgot_password extends StatefulWidget {
  const forgot_password({super.key});

  @override
  State<forgot_password> createState() => _forgot_passwordState();
}

class _forgot_passwordState extends State<forgot_password> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();

  // ───────── ORIGINAL FUNCTION (unchanged) ─────────
  Future<void> sendData() async {
    String femail = email.text.trim();
    if (femail.isEmpty || !femail.contains('@')) {
      Fluttertoast.showToast(msg: 'Enter a valid email');
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    final urls = Uri.parse('$url/android_forget_password_post/');

    try {
      final response = await http.post(urls, body: {
        'email': femail,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String status = data['status'];

        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Password sent to email');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyLoginPage(title: '')),
          );
        } else {
          Fluttertoast.showToast(msg: 'Email not found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Server error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    }
  }

  // ───────── Validation (form level, does not touch sendData) ─────────
  String? _validateEmail(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return 'Enter your registered email';
    if (t.contains(' ')) return 'Email must not contain spaces';
    if (t.length > 100) return 'Email is too long (max 100 characters)';
    if (!RegExp(r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$')
        .hasMatch(t)) {
      return 'Enter a valid email (e.g. name@example.com)';
    }
    return null;
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      sendData();
    } else {
      Fluttertoast.showToast(msg: 'Enter a valid email');
    }
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('Forgot Password'),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: (c.maxHeight - 48).clamp(0.0, double.infinity),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [_kCyan, _kTeal],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0x4D0B84A8),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)),
                            ],
                          ),
                          child: const Icon(Icons.lock_reset_rounded,
                              color: _kDeep, size: 36),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Forgot password?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _kHeading,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'We will email your password to your\nregistered address.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _kMuted, fontSize: 13, height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        _Card(
                          child: Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const _SectionLabel('Registered email',
                                    Icons.alternate_email_rounded),
                                const SizedBox(height: 18),
                                TextFormField(
                                  controller: email,
                                  validator: _validateEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) => _onSubmit(),
                                  style: const TextStyle(color: _kHeading),
                                  decoration: _input(
                                    'Email',
                                    icon: Icons.email_rounded,
                                    hint: 'name@example.com',
                                  ),
                                ),
                                const SizedBox(height: 22),
                                _GradButton(
                                  label: 'Send Password',
                                  icon: Icons.send_rounded,
                                  loading: false,
                                  onPressed: _onSubmit,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
