//
// import 'dart:convert';
//
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:labtrackapp/home.dart';
// import 'package:labtrackapp/register.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
//
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: MyLoginPage(title: 'Login'),
//   ));
// }
//
// class MyLoginPage extends StatefulWidget {
//   const MyLoginPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyLoginPage> createState() => _MyLoginPageState();
// }
//
// class _MyLoginPageState extends State<MyLoginPage> {
//
//   final TextEditingController _usernametextController =
//   TextEditingController();
//
//   final TextEditingController _passwordtextController =
//   TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Login"),
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//
//           children: [
//
//             TextField(
//               controller: _usernametextController,
//
//               decoration: const InputDecoration(
//                 labelText: "Username",
//                 hintText: "Enter username",
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             TextField(
//               controller: _passwordtextController,
//
//               obscureText: true,
//
//               decoration: const InputDecoration(
//                 labelText: "Password",
//                 hintText: "Enter password",
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             SizedBox(
//               width: double.infinity,
//
//               child: ElevatedButton(
//                 onPressed: _send_data,
//
//                 child: const Text("Login"),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => StudentHomePage(),
//                   ),
//                 );
//
// // Forgot password will be added later.
//
//               },
//
//               child: const Text("Forgot Password?"),
//             ),
//             const SizedBox(height: 10),
//
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) => StudentHomePage(),
// //                               ),
// //                             );
// //
// // // Forgot password will be added later.
// //
// //               },
// //
// //               child: const Text("Forgot Password?"),
// //             ),
//
//             const SizedBox(height: 10),
//
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //
//             //   children: [
//             //
//             //     const Text("Don't have an account? "),
//             //
//             //     TextButton(
//             //       onPressed: () {
//             //
//             //         Navigator.push(
//             //           context,
//             //           MaterialPageRoute(
//             //             builder: (context) => MyAddUserPage(title: ""),
//             //           ),
//             //         );
//             //       },
//             //
//             //       child: const Text("Register"),
//             //     ),
//             //   ],
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _send_data() async {
//
//     String uname =
//         _usernametextController.text;
//
//     String password =
//         _passwordtextController.text;
//
//     SharedPreferences sh =
//     await SharedPreferences.getInstance();
//
//     String url =
//     sh.getString('url').toString();
//
//     final urls =
//     Uri.parse('$url/flutter_logins/');
//
//     try {
//
//       final response = await http.post(
//         urls,
//
//         body: {
//           'Username': uname,
//           'Password': password,
//         },
//       );
//
//       if (response.statusCode == 200) {
//
//         String status =
//         jsonDecode(response.body)['status'];
//
//         if (status == 'ok') {
//
//           String lid =
//           jsonDecode(response.body)['lid'];
//
//           await sh.setString(
//             "lid",
//             lid,
//           );
//
//           Fluttertoast.showToast(
//             msg: 'Login successful',
//           );
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const StudentHomePage(),
//             ),
//           );
//
//         } else {
//
//           Fluttertoast.showToast(
//             msg: 'Invalid username or password',
//           );
//         }
//
//       } else {
//
//         Fluttertoast.showToast(
//           msg: 'Network Error',
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
//
// }
//


// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:labtrackapp/forgotpassword.dart';
// import 'package:labtrackapp/home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: MyLoginPage(title: 'Login'),
//   ));
// }
//
// class MyLoginPage extends StatefulWidget {
//   const MyLoginPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyLoginPage> createState() => _MyLoginPageState();
// }
//
// class _MyLoginPageState extends State<MyLoginPage> {
//
//   final TextEditingController _usernametextController =
//   TextEditingController();
//
//   final TextEditingController _passwordtextController =
//   TextEditingController();
//
//   @override
//   void dispose() {
//     _usernametextController.dispose();
//     _passwordtextController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Login"),
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//
//           children: [
//
//             TextField(
//               controller: _usernametextController,
//
//               decoration: const InputDecoration(
//                 labelText: "Username",
//                 hintText: "Enter username",
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             TextField(
//               controller: _passwordtextController,
//
//               obscureText: true,
//
//               decoration: const InputDecoration(
//                 labelText: "Password",
//                 hintText: "Enter password",
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             SizedBox(
//               width: double.infinity,
//
//               child: ElevatedButton(
//                 onPressed: _send_data,
//
//                 child: const Text("Login"),
//               ),
//             ),
//
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => forgotpassword(),
//               ),
//             );
//           },
//           child: Text('Forgot Password?'),
//         ),
//
//
//             const SizedBox(height: 10),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _send_data() async {
//
//     String uname =
//     _usernametextController.text.trim();
//
//     String password =
//         _passwordtextController.text;
//
//     if (uname.isEmpty || password.isEmpty) {
//       Fluttertoast.showToast(
//         msg: "Please enter username and password",
//       );
//       return;
//     }
//
//     SharedPreferences sh =
//     await SharedPreferences.getInstance();
//
//     String? url =
//     sh.getString('url');
//
//     if (url == null || url.isEmpty) {
//       Fluttertoast.showToast(
//         msg: "Server URL not found",
//       );
//       return;
//     }
//
//     final urls =
//     Uri.parse('$url/flutter_logins/');
//
//     try {
//
//       final response = await http.post(
//         urls,
//
//         body: {
//           'Username': uname,
//           'Password': password,
//         },
//       );
//
//       if (response.statusCode == 200) {
//
//         final data = jsonDecode(response.body);
//
//         String status =
//         data['status'].toString();
//
//         if (status == 'ok') {
//
//           String lid =
//           data['lid'].toString();
//
//           await sh.setString(
//             "lid",
//             lid,
//           );
//
//           Fluttertoast.showToast(
//             msg: 'Login successful',
//           );
//
//           if (!mounted) return;
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const StudentHomePage(),
//             ),
//           );
//
//         } else {
//
//           String message =
//               data['message']?.toString() ??
//                   'Invalid username or password';
//
//           Fluttertoast.showToast(
//             msg: message,
//           );
//         }
//
//       } else {
//
//         Fluttertoast.showToast(
//           msg: 'Network Error',
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




import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labtrackapp/forgotpassword.dart';
import 'package:labtrackapp/home.dart';
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


// ═════════════ HOVER WIDGETS ═════════════

/// Gradient button with hover lift (desktop/web) and press scale (touch).
class _HoverButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const _HoverButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hover = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final dy = (_hover && !_pressed) ? -2.0 : 0.0;
    final scale = _pressed ? 0.98 : 1.0;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: 52,
          transformAlignment: Alignment.center,
          transform: Matrix4.translationValues(0, dy, 0)..scale(scale),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _hover
                  ? const [Color(0xFF12A0CC), _kTeal]
                  : const [_kTeal, _kTealDark],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: _kTeal.withOpacity(_hover ? 0.45 : 0.28),
                blurRadius: _hover ? 22 : 14,
                offset: Offset(0, _hover ? 10 : 6),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.5,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: _hover ? 12 : 8,
                ),
                Icon(widget.icon, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Text link that underlines on hover.
class _HoverLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool bold;
  const _HoverLink({
    required this.label,
    required this.onTap,
    this.bold = true,
  });

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hover ? _kTealDark : _kTeal,
              fontSize: 13,
              fontWeight: widget.bold ? FontWeight.w800 : FontWeight.w600,
              decoration:
              _hover ? TextDecoration.underline : TextDecoration.none,
              decorationColor: _kTealDark,
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
    home: MyLoginPage(title: 'Login'),
  ));
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernametextController =
  TextEditingController();

  final TextEditingController _passwordtextController =
  TextEditingController();

  bool _showPassword = false;

  @override
  void dispose() {
    _usernametextController.dispose();
    _passwordtextController.dispose();
    super.dispose();
  }

  // ───────── Validation (form level, does not touch _send_data) ─────────
  String? _validateUsername(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return 'Enter your username';
    if (t.contains(' ')) return 'Username must not contain spaces';
    if (t.length < 3) return 'Username must be at least 3 characters';
    if (t.length > 50) return 'Username must be at most 50 characters';
    return null;
  }

  String? _validatePassword(String? v) {
    final t = v ?? '';
    if (t.isEmpty) return 'Enter your password';
    if (t.length < 4) return 'Password must be at least 4 characters';
    if (t.length > 64) return 'Password must be at most 64 characters';
    return null;
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _send_data();
    } else {
      Fluttertoast.showToast(msg: "Please fix the errors and try again");
    }
  }

  // ───────── UI ─────────
  Widget _brand() {
    return Column(
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_kCyan, _kTeal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 24,
                  offset: Offset(0, 10)),
            ],
          ),
          child: const Icon(Icons.biotech_rounded, color: _kDeep, size: 40),
        ),
        const SizedBox(height: 16),
        const Text(
          'LabTrack',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Online Lab Management & Equipment Preservation',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFFB9D3E3), fontSize: 13, height: 1.5),
        ),
      ],
    );
  }

  Widget _loginCard() {
    return _Card(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back',
                style: TextStyle(
                  color: _kHeading,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Sign in to continue to your account.',
                style: TextStyle(color: _kMuted, fontSize: 13),
              ),
              const SizedBox(height: 22),
              TextFormField(
                controller: _usernametextController,
                validator: _validateUsername,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.username],
                style: const TextStyle(color: _kHeading),
                decoration: _input(
                  'Username',
                  icon: Icons.person_rounded,
                  hint: 'Enter username',
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _passwordtextController,
                validator: _validatePassword,
                obscureText: !_showPassword,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                onFieldSubmitted: (_) => _onSubmit(),
                style: const TextStyle(color: _kHeading),
                decoration: _input(
                  'Password',
                  icon: Icons.lock_rounded,
                  hint: 'Enter password',
                  suffix: IconButton(
                    tooltip: _showPassword ? 'Hide password' : 'Show password',
                    hoverColor: _kTile,
                    icon: Icon(
                      _showPassword
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: _kMuted,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _showPassword = !_showPassword),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: _HoverLink(
                  label: 'Forgot Password?',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => forgotpassword(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              _HoverButton(
                label: 'Login',
                icon: Icons.arrow_forward_rounded,
                onPressed: _onSubmit,
              ),
              const SizedBox(height: 18),
              const Divider(height: 1, color: _kBorder),
              const SizedBox(height: 12),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text(
              //       'New student? ',
              //       style: TextStyle(color: _kMuted, fontSize: 13),
              //     ),
              //     _HoverLink(
              //       label: 'Create account',
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) =>
              //             const MyAddUserPage(title: 'Student Registration'),
              //           ),
              //         );
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kDeep,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [_kTop, _kMid, _kDeep],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -90,
              top: -110,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [_kCyan.withOpacity(0.30), _kCyan.withOpacity(0)],
                  ),
                ),
              ),
            ),
            Positioned(
              left: -100,
              bottom: -120,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [_kTeal.withOpacity(0.28), _kTeal.withOpacity(0)],
                  ),
                ),
              ),
            ),
            Positioned.fill(child: CustomPaint(painter: _DotsPainter())),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, c) {
                  final minH = (c.maxHeight - 48).clamp(0.0, double.infinity);
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: minH),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 440),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutCubic,
                            builder: (context, v, child) => Opacity(
                              opacity: v,
                              child: Transform.translate(
                                offset: Offset(0, 24 * (1 - v)),
                                child: child,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _brand(),
                                const SizedBox(height: 26),
                                _loginCard(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────── ORIGINAL FUNCTION (unchanged) ─────────
  void _send_data() async {

    String uname =
    _usernametextController.text.trim();

    String password =
        _passwordtextController.text;

    if (uname.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter username and password",
      );
      return;
    }

    SharedPreferences sh =
    await SharedPreferences.getInstance();

    String? url =
    sh.getString('url');

    if (url == null || url.isEmpty) {
      Fluttertoast.showToast(
        msg: "Server URL not found",
      );
      return;
    }

    final urls =
    Uri.parse('$url/flutter_logins/');

    try {

      final response = await http.post(
        urls,

        body: {
          'Username': uname,
          'Password': password,
        },
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        String status =
        data['status'].toString();

        if (status == 'ok') {

          String lid =
          data['lid'].toString();

          await sh.setString(
            "lid",
            lid,
          );

          Fluttertoast.showToast(
            msg: 'Login successful',
          );

          if (!mounted) return;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentHomePage(),
            ),
          );

        } else {

          String message =
              data['message']?.toString() ??
                  'Invalid username or password';

          Fluttertoast.showToast(
            msg: message,
          );
        }

      } else {

        Fluttertoast.showToast(
          msg: 'Network Error',
        );
      }

    } catch (e) {

      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }
}