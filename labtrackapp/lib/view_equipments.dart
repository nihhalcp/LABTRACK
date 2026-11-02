//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:labtrackapp/view_assigned_equipment.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class ViewEquipmentPage extends StatefulWidget {
//   const ViewEquipmentPage({super.key});
//
//   @override
//   State<ViewEquipmentPage> createState() => _ViewEquipmentPageState();
// }
//
// class _ViewEquipmentPageState extends State<ViewEquipmentPage> {
//
//   List equipment = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     viewEquipment();
//   }
//
//   Future<void> viewEquipment() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       var response = await http.post(
//         Uri.parse('$url/flutter_view_equipment/'),
//         body: {'lid': lid},
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         setState(() {
//           equipment = data['equipment'];
//           loading = false;
//         });
//       } else {
//         setState(() {
//           loading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         loading = false;
//       });
//
//       Fluttertoast.showToast(msg: "Unable to load equipment");
//     }
//   }
//
//   Future<void> requestEquipment(String equipmentId, String availableQuantity) async {
//
//     TextEditingController quantityController = TextEditingController(text: '1');
//
//     int? requestedQuantity = await showDialog<int>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Request Equipment"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("Available Quantity: $availableQuantity"),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: quantityController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: "Enter Quantity",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 int? quantity = int.tryParse(quantityController.text);
//
//                 if (quantity == null || quantity <= 0) {
//                   Fluttertoast.showToast(
//                     msg: "Enter a valid quantity",
//                   );
//                 } else if (quantity > int.parse(availableQuantity)) {
//                   Fluttertoast.showToast(
//                     msg: "Quantity exceeds availability",
//                   );
//                 } else {
//                   Navigator.pop(context, quantity);
//                 }
//               },
//               child: const Text("Send Request"),
//             ),
//           ],
//         );
//       },
//     );
//
//     if (requestedQuantity == null) {
//       return;
//     }
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       var response = await http.post(
//         Uri.parse('$url/flutter_request_equipment/'),
//         body: {
//           'lid': lid,
//           'equipment_id': equipmentId,
//           'quantity': requestedQuantity.toString(),
//         },
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         Fluttertoast.showToast(
//           msg: data['message'] ?? "Equipment request sent successfully",
//         );
//
//         viewEquipment();
//       } else {
//         Fluttertoast.showToast(
//           msg: data['message'] ?? "Request failed",
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Unable to send equipment request");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Lab Equipment"),
//       ),
//       body: loading
//           ? const Center(
//         child: CircularProgressIndicator(),
//       )
//           : equipment.isEmpty
//           ? const Center(
//         child: Text("No equipment available"),
//       )
//           : RefreshIndicator(
//         onRefresh: viewEquipment,
//         child: ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: equipment.length,
//           itemBuilder: (context, index) {
//             var item = equipment[index];
//
//             return Card(
//               margin: const EdgeInsets.only(bottom: 12),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Text(
//                       item['equipment_name'].toString(),
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//
//                     const SizedBox(height: 8),
//
//                     Text(
//                       "Lab: ${item['lab_name']}",
//                     ),
//
//                     Text(
//                       "Category: ${item['category']}",
//                     ),
//
//                     Text(
//                       "Total Quantity: ${item['quantity']}",
//                     ),
//
//                     Text(
//                       "Available Quantity: ${item['available_quantity']}",
//                     ),
//
//                     Text(
//                       "Status: ${item['status']}",
//                     ),
//
//                     const SizedBox(height: 12),
//
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           requestEquipment(
//                             item['id'].toString(),
//                             item['available_quantity'].toString(),
//                           );
//                         },
//                         icon: const Icon(Icons.send),
//                         label: const Text("Request Equipment"),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const ViewAssignedEquipmentPage(),
//             ),
//           );
//         },
//         child: const Icon(Icons.inventory),
//         tooltip: 'My Assigned Equipment',
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
import 'package:flutter/services.dart';
import 'package:labtrackapp/view_assigned_equipment.dart';

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

// ───────── Request-quantity dialog (own State so the controller is disposed safely) ─────────
class _QuantityDialog extends StatefulWidget {
  final int available;
  const _QuantityDialog({required this.available});

  @override
  State<_QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<_QuantityDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController quantityController =
  TextEditingController(text: '1');

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  String? _validateQuantity(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return 'Enter a quantity';
    if (!RegExp(r'^\d+$').hasMatch(t)) return 'Digits only, no symbols';
    final q = int.tryParse(t);
    if (q == null) return 'Enter a valid quantity';
    if (q <= 0) return 'Quantity must be at least 1';
    if (q > widget.available) {
      return 'Only ${widget.available} available — quantity exceeds availability';
    }
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, int.parse(quantityController.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(color: _kBorder, width: 1.2),
      ),
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      title: const _SectionLabel('Request Equipment', Icons.send_rounded),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: _kTile,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.inventory_rounded, size: 18, color: _kTeal),
                  const SizedBox(width: 8),
                  Text(
                    'Available Quantity: ${widget.available}',
                    style: const TextStyle(
                      color: _kHeading,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: quantityController,
              validator: _validateQuantity,
              autofocus: true,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              maxLength: 4,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onFieldSubmitted: (_) => _submit(),
              style: const TextStyle(color: _kHeading, fontWeight: FontWeight.w700),
              decoration: _input(
                'Enter Quantity',
                icon: Icons.numbers_rounded,
                hint: '1',
              ).copyWith(counterText: ''),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel',
              style: TextStyle(color: _kMuted, fontWeight: FontWeight.w700)),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: _kTeal,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Send Request',
              style: TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}

// ═════════════════════════ VIEW EQUIPMENT PAGE ═════════════════════════
class ViewEquipmentPage extends StatefulWidget {
  const ViewEquipmentPage({super.key});

  @override
  State<ViewEquipmentPage> createState() => _ViewEquipmentPageState();
}

class _ViewEquipmentPageState extends State<ViewEquipmentPage> {

  List equipment = [];
  bool loading = true;
  String? errorMsg;
  String? requestingId; // id of the equipment currently being requested

  @override
  void initState() {
    super.initState();
    viewEquipment();
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
      if (equipment.isEmpty) errorMsg = msg;
    });
    if (equipment.isNotEmpty) _snack(msg);
  }

  void _retry() {
    setState(() {
      loading = true;
      errorMsg = null;
    });
    viewEquipment();
  }

  // ───────── Load data ─────────
  Future<void> viewEquipment() async {
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

      var response = await http.post(
        Uri.parse('$url/flutter_view_equipment/'),
        body: {'lid': lid},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        _fail('Server error (${response.statusCode}). Please try again');
        return;
      }

      var data = jsonDecode(response.body);

      if (!mounted) return;

      if (data is Map && data['status'] == 'ok') {
        final raw = data['equipment'];
        setState(() {
          equipment = raw is List ? raw : [];
          loading = false;
          errorMsg = null;
        });
      } else {
        _fail((data is Map ? data['message'] : null)?.toString() ??
            'Unable to load equipment');
      }
    } on TimeoutException {
      _fail('Request timed out. Check your connection and try again');
    } on SocketException {
      _fail('No internet connection or server unreachable');
    } on FormatException {
      _fail('Unexpected response from server');
    } catch (e) {
      _fail('Unable to load equipment');
    }
  }

  // ───────── Request equipment ─────────
  Future<void> requestEquipment(String equipmentId, String availableQuantity) async {
    if (requestingId != null) return; // a request is already in progress

    final String id = equipmentId.trim();
    final int available = int.tryParse(availableQuantity.trim()) ?? 0;

    if (id.isEmpty || id == 'null') {
      _snack('Invalid equipment. Please refresh and try again');
      return;
    }

    if (available <= 0) {
      _snack('This equipment is currently not available');
      return;
    }

    final int? requestedQuantity = await showDialog<int>(
      context: context,
      builder: (context) => _QuantityDialog(available: available),
    );

    if (requestedQuantity == null || !mounted) {
      return;
    }

    setState(() {
      requestingId = id;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();

      String url = (sh.getString('url') ?? '').trim();
      String lid = (sh.getString('lid') ?? '').trim();

      if (url.isEmpty || lid.isEmpty) {
        _snack('Session expired. Please log in again');
        return;
      }

      while (url.endsWith('/')) {
        url = url.substring(0, url.length - 1);
      }

      var response = await http.post(
        Uri.parse('$url/flutter_request_equipment/'),
        body: {
          'lid': lid,
          'equipment_id': id,
          'quantity': requestedQuantity.toString(),
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        _snack('Server error (${response.statusCode}). Please try again');
        return;
      }

      var data = jsonDecode(response.body);

      if (data is Map && data['status'] == 'ok') {
        _snack(data['message']?.toString() ??
            'Equipment request sent successfully');

        viewEquipment();
      } else {
        _snack((data is Map ? data['message'] : null)?.toString() ??
            'Request failed');
      }
    } on TimeoutException {
      _snack('Request timed out. Please try again');
    } on SocketException {
      _snack('No internet connection or server unreachable');
    } on FormatException {
      _snack('Unexpected response from server');
    } catch (e) {
      _snack('Unable to send equipment request');
    } finally {
      if (mounted) {
        setState(() {
          requestingId = null;
        });
      }
    }
  }

  // ───────── UI ─────────
  Widget _card(Map item) {
    final String id = _txt(item['id'], '');
    final int total = _toInt(item['quantity']);
    final int available = _toInt(item['available_quantity']);
    final status = _txt(item['status'], available > 0 ? 'Available' : 'Unavailable');
    final double ratio =
    total <= 0 ? 0.0 : (available / total).clamp(0.0, 1.0).toDouble();
    final Color barColor = available <= 0
        ? _kDanger
        : (ratio <= 0.25 ? _kAmber : _kSuccess);
    final bool busy = requestingId == id && id.isNotEmpty;
    final bool canRequest = available > 0 && id.isNotEmpty;

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
                  child: const Icon(Icons.science_rounded,
                      color: _kTeal, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _txt(item['equipment_name'], 'Unnamed equipment'),
                    style: const TextStyle(
                      color: _kHeading,
                      fontSize: 17,
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
            _InfoRow(Icons.biotech_rounded, 'Lab', _txt(item['lab_name'])),
            _InfoRow(Icons.category_rounded, 'Category', _txt(item['category'])),
            _InfoRow(Icons.inventory_2_rounded, 'Total Quantity',
                _txt(item['quantity'])),
            _InfoRow(
              Icons.check_circle_outline_rounded,
              'Available Quantity',
              _txt(item['available_quantity']),
              valueColor: barColor,
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 7,
                backgroundColor: _kBorder,
                valueColor: AlwaysStoppedAnimation<Color>(barColor),
              ),
            ),
            const SizedBox(height: 16),
            _GradButton(
              label: busy
                  ? 'Sending...'
                  : (canRequest ? 'Request Equipment' : 'Not Available'),
              icon: Icons.send_rounded,
              loading: busy,
              onPressed: (canRequest && requestingId == null)
                  ? () {
                requestEquipment(
                  item['id'].toString(),
                  item['available_quantity'].toString(),
                );
              }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollable(Widget child) => RefreshIndicator(
    color: _kTeal,
    onRefresh: viewEquipment,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [const SizedBox(height: 70), child],
    ),
  );

  Widget _body() {
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: _kTeal));
    }

    if (errorMsg != null && equipment.isEmpty) {
      return _scrollable(_ErrorState(message: errorMsg!, onRetry: _retry));
    }

    if (equipment.isEmpty) {
      return _scrollable(const _EmptyState(
        icon: Icons.science_outlined,
        title: 'No equipment available',
        message: 'Lab equipment will appear here once it is added.',
      ));
    }

    return RefreshIndicator(
      color: _kTeal,
      onRefresh: viewEquipment,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 96),
        itemCount: equipment.length,
        itemBuilder: (context, index) {
          final item = equipment[index];
          if (item is! Map) return const SizedBox.shrink();
          return _card(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitle = loading
        ? 'Loading equipment...'
        : equipment.isEmpty
        ? 'No equipment to show right now.'
        : '${equipment.length} item${equipment.length == 1 ? '' : 's'} available to browse and request';

    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('Lab Equipment'),
      body: Column(
        children: [
          _Header(
            title: 'Lab Equipment',
            subtitle: subtitle,
            icon: Icons.science_rounded,
          ),
          Expanded(child: _body()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _kTeal,
        foregroundColor: Colors.white,
        elevation: 4,
        tooltip: 'My Assigned Equipment',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewAssignedEquipmentPage(),
            ),
          );
        },
        icon: const Icon(Icons.inventory),
        label: const Text('My Assigned',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}
