//
// import 'package:flutter/material.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'login.dart';
//
// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ippage(),);
//   }
// }
//
// class ippage extends StatefulWidget {
//   const ippage({super.key});
//
//   @override
//   State<ippage> createState() => _ippageState();
// }
//
// class _ippageState extends State<ippage> {
//   TextEditingController ipcontroller=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("IPPAGE"),backgroundColor:Colors.brown,),
//       body: Container(
//         padding: EdgeInsets.all(90),
//         height:600,
//         width: double.infinity,
//         color: Colors.white,
//         child: SingleChildScrollView(
//           child:Column(
//             children: [
//               SizedBox(height: 20,),
//               Text('IP PAGE',style:TextStyle(fontSize: 40),),
//               TextFormField(
//                 controller:ipcontroller,
//                 decoration: InputDecoration(border: OutlineInputBorder(),label:Text("IP ADDRESS")),
//
//               ),
//               SizedBox(height: 20,),
//             ElevatedButton(onPressed: () async{
//
//                 String ip =ipcontroller.text;
//                 final sh=await SharedPreferences.getInstance();
//                 sh.setString('url',"http://$ip:8000/myapp");
//
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLoginPage(title: "LabTrack")));
//
//               },child: Text('Connect'),)
//
//
//
//             ],
//
//
//           )
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ippage(),
    );
  }
}

class ippage extends StatefulWidget {
  const ippage({super.key});

  @override
  State<ippage> createState() => _ippageState();
}

class _ippageState extends State<ippage> {
  static const int _port = 8000;

  final _formKey = GlobalKey<FormState>();
  TextEditingController ipcontroller = TextEditingController();

  bool connecting = false;

  String? _validateIp(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return 'Enter the server IP address';
    if (t.contains(':') || t.contains('/') || t.contains(' ')) {
      return 'Enter only the IP address (no http://, port or spaces)';
    }
    final m = RegExp(r'^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$')
        .firstMatch(t);
    if (m == null) {
      return 'Enter a valid IPv4 address (e.g. 192.168.1.10)';
    }
    for (var i = 1; i <= 4; i++) {
      if (int.parse(m.group(i)!) > 255) {
        return 'Each part of the IP must be between 0 and 255';
      }
    }
    if (t == '0.0.0.0') return '0.0.0.0 is not a valid server address';
    return null;
  }

  Future<void> _connect() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      _snack(context, 'Please enter a valid IP address', error: true);
      return;
    }

    final ip = ipcontroller.text.trim();
    final base = 'http://$ip:$_port/myapp';

    setState(() {
      connecting = true;
    });

    try {
      // Any HTTP response means the server is reachable.
      await http.get(Uri.parse('$base/')).timeout(const Duration(seconds: 6));

      final sh = await SharedPreferences.getInstance();
      await sh.setString('url', base);

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyLoginPage(title: "LabTrack"),
        ),
      );
    } on TimeoutException {
      if (!mounted) return;
      _snack(context, 'Server did not respond at $ip:$_port. Check the IP.',
          error: true);
    } catch (e) {
      if (!mounted) return;
      _snack(
          context,
          'Cannot reach $ip:$_port. Check Wi-Fi and that the server is '
              'running.',
          error: true);
    } finally {
      if (mounted) {
        setState(() {
          connecting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    ipcontroller.dispose();
    super.dispose();
  }

  // ── Brand block (logo, name, tagline) ──
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

  // ── Connect card ──
  Widget _connectCard() {
    return _Card(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionLabel('Connect to server', Icons.dns_rounded),
            const SizedBox(height: 8),
            const Text(
              'Enter the IP address of the computer running LabTrack. '
                  'Your phone must be on the same Wi-Fi network.',
              style: TextStyle(color: _kMuted, fontSize: 12.5, height: 1.45),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: ipcontroller,
              validator: _validateIp,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                LengthLimitingTextInputFormatter(15),
              ],
              onFieldSubmitted: (_) => connecting ? null : _connect(),
              style: const TextStyle(color: _kHeading),
              decoration: _input(
                'IP Address',
                icon: Icons.router_rounded,
                hint: '192.168.1.10',
              ),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: ipcontroller,
              builder: (context, value, _) {
                final t = value.text.trim();
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kCanvas,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kBorder),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.link_rounded, size: 16, color: _kTeal),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'http://${t.isEmpty ? '<ip>' : t}:$_port/myapp',
                          style: const TextStyle(
                            color: _kMuted,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 22),
            _GradButton(
              label: connecting ? 'Connecting...' : 'Connect',
              icon: Icons.power_rounded,
              loading: connecting,
              onPressed: _connect,
            ),
          ],
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
                          child: LayoutBuilder(
                            builder: (context, inner) => TweenAnimationBuilder<
                                double>(
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
                                  _connectCard(),
                                ],
                              ),
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
}