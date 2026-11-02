// // //
// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:shared_preferences/shared_preferences.dart';
// // //
// // // class ViewDepartmentStaffPage extends StatefulWidget {
// // //   const ViewDepartmentStaffPage({super.key});
// // //
// // //   @override
// // //   State<ViewDepartmentStaffPage> createState() =>
// // //       _ViewDepartmentStaffPageState();
// // // }
// // //
// // // class _ViewDepartmentStaffPageState extends State<ViewDepartmentStaffPage> {
// // //   List staff = [];
// // //   bool loading = true;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     viewStaff();
// // //   }
// // //
// // //   Future<void> viewStaff() async {
// // //     try {
// // //       final sh = await SharedPreferences.getInstance();
// // //       String url = sh.getString("url") ?? "";
// // //       String lid = sh.getString("lid") ?? "";
// // //
// // //       url = url.endsWith('/') ? url : '$url/';
// // //
// // //       if (!url.endsWith('/myapp/')) {
// // //         url = '${url}myapp/';
// // //       }
// // //
// // //       var response = await http.post(
// // //         Uri.parse("${url}flutter_view_department_staff/"),
// // //         body: {
// // //           'lid': lid,
// // //         },
// // //       );
// // //
// // //       var data = jsonDecode(response.body);
// // //
// // //       if (!mounted) return;
// // //
// // //       if (data['status'] == 'ok') {
// // //         setState(() {
// // //           staff = data['staff'];
// // //           loading = false;
// // //         });
// // //       } else {
// // //         setState(() {
// // //           loading = false;
// // //         });
// // //       }
// // //     } catch (e) {
// // //       print(e);
// // //
// // //       if (mounted) {
// // //         setState(() {
// // //           loading = false;
// // //         });
// // //       }
// // //     }
// // //   }
// // //
// // //   Future<void> openChat(var i) async {
// // //     final sh = await SharedPreferences.getInstance();
// // //     String lid = sh.getString("lid") ?? "";
// // //
// // //     if (!mounted) return;
// // //
// // //     Navigator.push(
// // //       context,
// // //       MaterialPageRoute(
// // //         builder: (context) => ChatPage(
// // //           receiverId: i['id'].toString(),
// // //           staffName: i['name'],
// // //           lid: lid,
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Department Staff'),
// // //       ),
// // //       body: loading
// // //           ? const Center(child: CircularProgressIndicator())
// // //           : staff.isEmpty
// // //           ? const Center(
// // //         child: Text('No staff found in your department'),
// // //       )
// // //           : RefreshIndicator(
// // //         onRefresh: viewStaff,
// // //         child: ListView.builder(
// // //           itemCount: staff.length,
// // //           itemBuilder: (context, index) {
// // //             var i = staff[index];
// // //
// // //             return Card(
// // //               margin: const EdgeInsets.all(10),
// // //               child: ListTile(
// // //                 title: Text(i['name'] ?? ''),
// // //                 subtitle: Text(
// // //                   'Designation: ${i['designation'] ?? ''}\n'
// // //                       'Email: ${i['email'] ?? ''}',
// // //                 ),
// // //                 isThreeLine: true,
// // //                 trailing: ElevatedButton(
// // //                   onPressed: () {
// // //                     openChat(i);
// // //                   },
// // //                   child: const Text('Chat'),
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // class ChatPage extends StatefulWidget {
// // //   final String receiverId;
// // //   final String staffName;
// // //   final String lid;
// // //
// // //   const ChatPage({
// // //     super.key,
// // //     required this.receiverId,
// // //     required this.staffName,
// // //     required this.lid,
// // //   });
// // //
// // //   @override
// // //   State<ChatPage> createState() => _ChatPageState();
// // // }
// // //
// // // class _ChatPageState extends State<ChatPage> {
// // //   final TextEditingController messageController =
// // //   TextEditingController();
// // //
// // //   List messages = [];
// // //   bool loading = true;
// // //   bool sending = false;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     viewMessages();
// // //   }
// // //
// // //   Future<void> viewMessages() async {
// // //     try {
// // //       final sh = await SharedPreferences.getInstance();
// // //       String url = sh.getString("url") ?? "";
// // //
// // //       url = url.endsWith('/') ? url : '$url/';
// // //
// // //       if (!url.endsWith('/myapp/')) {
// // //         url = '${url}myapp/';
// // //       }
// // //
// // //       var response = await http.post(
// // //         Uri.parse("${url}flutter_view_chat_messages/"),
// // //         body: {
// // //           'lid': widget.lid,
// // //           'receiver_id': widget.receiverId,
// // //         },
// // //       );
// // //
// // //       var data = jsonDecode(response.body);
// // //
// // //       if (!mounted) return;
// // //
// // //       if (data['status'] == 'ok') {
// // //         setState(() {
// // //           messages = data['messages'];
// // //           loading = false;
// // //         });
// // //       } else {
// // //         setState(() {
// // //           loading = false;
// // //         });
// // //       }
// // //     } catch (e) {
// // //       print(e);
// // //
// // //       if (mounted) {
// // //         setState(() {
// // //           loading = false;
// // //         });
// // //       }
// // //     }
// // //   }
// // //
// // //   Future<void> sendMessage() async {
// // //     if (messageController.text.trim().isEmpty) {
// // //       return;
// // //     }
// // //
// // //     setState(() {
// // //       sending = true;
// // //     });
// // //
// // //     try {
// // //       final sh = await SharedPreferences.getInstance();
// // //       String url = sh.getString("url") ?? "";
// // //
// // //       url = url.endsWith('/') ? url : '$url/';
// // //
// // //       if (!url.endsWith('/myapp/')) {
// // //         url = '${url}myapp/';
// // //       }
// // //
// // //       var response = await http.post(
// // //         Uri.parse("${url}flutter_send_chat_message/"),
// // //         body: {
// // //           'lid': widget.lid,
// // //           'receiver_id': widget.receiverId,
// // //           'message': messageController.text.trim(),
// // //         },
// // //       );
// // //
// // //       var data = jsonDecode(response.body);
// // //
// // //       if (!mounted) return;
// // //
// // //       if (data['status'] == 'ok') {
// // //         messageController.clear();
// // //         await viewMessages();
// // //       } else {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Failed to send message')),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       print(e);
// // //
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Unable to send message')),
// // //         );
// // //       }
// // //     } finally {
// // //       if (mounted) {
// // //         setState(() {
// // //           sending = false;
// // //         });
// // //       }
// // //     }
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     messageController.dispose();
// // //     super.dispose();
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Chat with ${widget.staffName}'),
// // //         actions: [
// // //           IconButton(
// // //             onPressed: viewMessages,
// // //             icon: const Icon(Icons.refresh),
// // //           ),
// // //         ],
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Expanded(
// // //             child: loading
// // //                 ? const Center(
// // //               child: CircularProgressIndicator(),
// // //             )
// // //                 : messages.isEmpty
// // //                 ? const Center(
// // //               child: Text('No messages yet'),
// // //             )
// // //                 : ListView.builder(
// // //               itemCount: messages.length,
// // //               itemBuilder: (context, index) {
// // //                 var i = messages[index];
// // //
// // //                 bool isMine =
// // //                     i['sender_id'].toString() == widget.lid;
// // //
// // //                 return Align(
// // //                   alignment: isMine
// // //                       ? Alignment.centerRight
// // //                       : Alignment.centerLeft,
// // //                   child: Card(
// // //                     color: isMine
// // //                         ? Colors.amber.shade100
// // //                         : Colors.grey.shade200,
// // //                     margin: const EdgeInsets.all(8),
// // //                     child: Padding(
// // //                       padding: const EdgeInsets.all(10),
// // //                       child: Column(
// // //                         crossAxisAlignment:
// // //                         CrossAxisAlignment.start,
// // //                         children: [
// // //                           Text(i['message'] ?? ''),
// // //                           const SizedBox(height: 5),
// // //                           Text(
// // //                             i['date'] ?? '',
// // //                             style: const TextStyle(
// // //                               fontSize: 11,
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(10),
// // //             child: Row(
// // //               children: [
// // //                 Expanded(
// // //                   child: TextField(
// // //                     controller: messageController,
// // //                     decoration: const InputDecoration(
// // //                       hintText: 'Type a message',
// // //                       border: OutlineInputBorder(),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(width: 8),
// // //                 IconButton(
// // //                   onPressed: sending ? null : sendMessage,
// // //                   icon: const Icon(Icons.send),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:labtrackapp/chat.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// //
// // class ViewDepartmentStaffPage extends StatefulWidget {
// //   const ViewDepartmentStaffPage({super.key});
// //
// //   @override
// //   State<ViewDepartmentStaffPage> createState() =>
// //       _ViewDepartmentStaffPageState();
// // }
// //
// // class _ViewDepartmentStaffPageState extends State<ViewDepartmentStaffPage> {
// //   List staff = [];
// //   bool loading = true;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     viewStaff();
// //   }
// //
// //   Future<void> viewStaff() async {
// //     try {
// //       final sh = await SharedPreferences.getInstance();
// //       String url = sh.getString("url") ?? "";
// //       String lid = sh.getString("lid") ?? "";
// //
// //       url = url.endsWith('/') ? url : '$url/';
// //
// //       if (!url.endsWith('/myapp/')) {
// //         url = '${url}myapp/';
// //       }
// //
// //       var response = await http.post(
// //         Uri.parse("${url}flutter_view_department_staff/"),
// //         body: {
// //           'lid': lid,
// //         },
// //       );
// //
// //       var data = jsonDecode(response.body);
// //
// //       if (!mounted) return;
// //
// //       if (data['status'] == 'ok') {
// //         setState(() {
// //           staff = data['staff'];
// //           loading = false;
// //         });
// //       } else {
// //         setState(() {
// //           loading = false;
// //         });
// //       }
// //     } catch (e) {
// //       print(e);
// //
// //       if (mounted) {
// //         setState(() {
// //           loading = false;
// //         });
// //       }
// //     }
// //   }
// //
// //   Future<void> openChat(var i) async {
// //     final sh = await SharedPreferences.getInstance();
// //     String lid = sh.getString("lid") ?? "";
// //
// //     if (!mounted) return;
// //
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => ChatPage(
// //           receiverId: i['id'].toString(),
// //           staffName: i['name'],
// //           lid: lid,
// //         ),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Department Staff'),
// //       ),
// //       body: loading
// //           ? const Center(child: CircularProgressIndicator())
// //           : staff.isEmpty
// //           ? const Center(
// //         child: Text('No staff found in your department'),
// //       )
// //           : RefreshIndicator(
// //         onRefresh: viewStaff,
// //         child: ListView.builder(
// //           itemCount: staff.length,
// //           itemBuilder: (context, index) {
// //             var i = staff[index];
// //
// //             return Card(
// //               margin: const EdgeInsets.all(10),
// //               child: ListTile(
// //                 title: Text(i['name'] ?? ''),
// //                 subtitle: Text(
// //                   'Designation: ${i['designation'] ?? ''}\n'
// //                       'Email: ${i['email'] ?? ''}',
// //                 ),
// //                 isThreeLine: true,
// //                 trailing: ElevatedButton(
// //                   onPressed: () {
// //                     openChat(i);
// //                   },
// //                   child: const Text('Chat'),
// //                 ),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:labtrackapp/chat.dart';
//
// // ═════════════ THEME (same look as Send Feedback, kept private to this file) ═════════════
// const Color _kTop = Color(0xFF164A63);
// const Color _kMid = Color(0xFF0D3048);
// const Color _kDeep = Color(0xFF08203A);
// const Color _kCyan = Color(0xFF5CD0EE);
// const Color _kTeal = Color(0xFF0B84A8);
// const Color _kTealDark = Color(0xFF086A89);
// const Color _kHeading = Color(0xFF0D2B3E);
// const Color _kMuted = Color(0xFF5D7183);
// const Color _kCanvas = Color(0xFFF1F6FB);
// const Color _kBorder = Color(0xFFDAE6F1);
// const Color _kTile = Color(0xFFE2F4FA);
// const Color _kDanger = Color(0xFFC0291F);
// const Color _kSuccess = Color(0xFF1C7C54);
// const Color _kAmber = Color(0xFFE08A0B);
//
// // ───────── Small helpers ─────────
// String _txt(dynamic v, [String fallback = '-']) {
//   final s = (v ?? '').toString().trim();
//   return (s.isEmpty || s.toLowerCase() == 'null' || s.toLowerCase() == 'none')
//       ? fallback
//       : s;
// }
//
//
// // Formats server dates without seconds: "24 Oct 2026, 2:30 PM" (date-only stays "24 Oct 2026")
// String _fmtDate(dynamic v, [String fallback = '-']) {
//   final raw = _txt(v, '');
//   if (raw.isEmpty) return fallback;
//
//   final d = DateTime.tryParse(raw);
//   if (d == null) {
//     // Unknown format: just strip seconds / milliseconds from any HH:MM:SS
//     return raw.replaceAllMapped(
//         RegExp(r'(\d{1,2}:\d{2}):\d{2}(\.\d+)?'), (m) => m.group(1)!);
//   }
//
//   const months = [
//     'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//     'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//   ];
//   final dt = d.isUtc ? d.toLocal() : d;
//   final date = '${dt.day.toString().padLeft(2, '0')} ${months[dt.month - 1]} ${dt.year}';
//
//   final hasTime = raw.contains(':');
//   if (!hasTime) return date;
//
//   final h12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
//   final ampm = dt.hour >= 12 ? 'PM' : 'AM';
//   return '$date, $h12:${dt.minute.toString().padLeft(2, '0')} $ampm';
// }
//
// int _toInt(dynamic v) => int.tryParse((v ?? '').toString().trim()) ?? 0;
//
// double _toDouble(dynamic v) =>
//     double.tryParse((v ?? '').toString().trim()) ?? 0;
//
// Color _statusColor(String s) {
//   final t = s.toLowerCase();
//   if (RegExp(r'reject|damage|unavail|overdue|fail|lost|cancel').hasMatch(t)) {
//     return _kDanger;
//   }
//   if (RegExp(r'pend|wait|process|request').hasMatch(t)) return _kAmber;
//   if (RegExp(r'approv|avail|assign|resolv|repl|return|complete|active|done')
//       .hasMatch(t)) {
//     return _kSuccess;
//   }
//   return _kTeal;
// }
//
// void _snackOn(BuildContext context, String msg) {
//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(SnackBar(content: Text(msg)));
// }
//
// PreferredSizeWidget _appBar(String title, {List<Widget>? actions}) => AppBar(
//   toolbarHeight: 60,
//   actions: actions,
//   elevation: 0,
//   scrolledUnderElevation: 0,
//   iconTheme: const IconThemeData(color: Colors.white),
//   flexibleSpace: Container(
//     decoration: const BoxDecoration(
//       gradient: LinearGradient(
//         colors: [_kTop, _kMid, _kDeep],
//         begin: Alignment.centerLeft,
//         end: Alignment.centerRight,
//       ),
//     ),
//   ),
//   title: Text(
//     title,
//     maxLines: 1,
//     overflow: TextOverflow.ellipsis,
//     style: const TextStyle(
//       color: Colors.white,
//       fontWeight: FontWeight.w800,
//       fontSize: 19,
//       letterSpacing: -0.3,
//     ),
//   ),
// );
//
// InputDecoration _input(String label,
//     {IconData? icon, String? hint, Widget? suffix, bool alignTop = false}) {
//   OutlineInputBorder b(Color c, [double w = 1.2]) => OutlineInputBorder(
//     borderRadius: BorderRadius.circular(14),
//     borderSide: BorderSide(color: c, width: w),
//   );
//   return InputDecoration(
//     labelText: label,
//     hintText: hint,
//     alignLabelWithHint: alignTop,
//     labelStyle: const TextStyle(color: _kMuted, fontWeight: FontWeight.w600),
//     floatingLabelStyle:
//     const TextStyle(color: _kTeal, fontWeight: FontWeight.w700),
//     hintStyle: const TextStyle(color: Color(0xFF8196A8)),
//     prefixIcon: icon == null ? null : Icon(icon, color: _kTeal, size: 21),
//     suffixIcon: suffix,
//     filled: true,
//     fillColor: _kCanvas,
//     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//     border: b(_kBorder),
//     enabledBorder: b(_kBorder),
//     focusedBorder: b(_kTeal, 1.6),
//     errorBorder: b(_kDanger),
//     focusedErrorBorder: b(_kDanger, 1.6),
//     errorStyle: const TextStyle(
//         color: _kDanger, fontWeight: FontWeight.w600, fontSize: 12),
//     errorMaxLines: 3,
//   );
// }
//
// class _Header extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   const _Header(
//       {required this.title, required this.subtitle, required this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     const r = BorderRadius.only(
//       bottomLeft: Radius.circular(28),
//       bottomRight: Radius.circular(28),
//     );
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [_kTop, _kDeep],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: r,
//         boxShadow: [
//           BoxShadow(
//               color: Color(0x3308203A), blurRadius: 24, offset: Offset(0, 12)),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: r,
//         child: Stack(
//           children: [
//             Positioned(
//               right: -50,
//               top: -70,
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: RadialGradient(
//                     colors: [_kCyan.withOpacity(0.32), _kCyan.withOpacity(0)],
//                   ),
//                 ),
//               ),
//             ),
//             Positioned.fill(child: CustomPaint(painter: _DotsPainter())),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 26),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 54,
//                     height: 54,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [_kCyan, _kTeal],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Color(0x4D000000),
//                             blurRadius: 14,
//                             offset: Offset(0, 6)),
//                       ],
//                     ),
//                     child: Icon(icon, color: _kDeep, size: 27),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(title,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 22,
//                               fontWeight: FontWeight.w800,
//                               letterSpacing: -0.4,
//                             )),
//                         const SizedBox(height: 3),
//                         Text(subtitle,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               color: Color(0xFFB9D3E3),
//                               fontSize: 12.5,
//                               height: 1.4,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _DotsPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final p = Paint()..color = Colors.white.withOpacity(0.09);
//     for (double x = 12; x < size.width; x += 24) {
//       for (double y = 12; y < size.height; y += 24) {
//         canvas.drawCircle(Offset(x, y), 1, p);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter old) => false;
// }
//
// class _Card extends StatelessWidget {
//   final Widget child;
//   const _Card({required this.child});
//
//   @override
//   Widget build(BuildContext context) => Container(
//     width: double.infinity,
//     padding: const EdgeInsets.all(18),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(20),
//       border: Border.all(color: _kBorder, width: 1.2),
//       boxShadow: const [
//         BoxShadow(
//             color: Color(0x0F08203A), blurRadius: 14, offset: Offset(0, 6)),
//       ],
//     ),
//     child: child,
//   );
// }
//
// class _SectionLabel extends StatelessWidget {
//   final String text;
//   final IconData icon;
//   const _SectionLabel(this.text, this.icon);
//
//   @override
//   Widget build(BuildContext context) => Row(
//     children: [
//       Container(
//         padding: const EdgeInsets.all(7),
//         decoration: BoxDecoration(
//           color: _kTile,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Icon(icon, size: 17, color: _kTeal),
//       ),
//       const SizedBox(width: 10),
//       Expanded(
//         child: Text(text,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               color: _kHeading,
//               fontSize: 16,
//               fontWeight: FontWeight.w800,
//               letterSpacing: -0.3,
//             )),
//       ),
//     ],
//   );
// }
//
// class _GradButton extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final bool loading;
//   final VoidCallback? onPressed; // null = disabled
//   const _GradButton({
//     required this.label,
//     required this.icon,
//     required this.loading,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final disabled = loading || onPressed == null;
//     return Opacity(
//       opacity: loading ? 0.7 : (onPressed == null ? 0.5 : 1),
//       child: Material(
//         color: Colors.transparent,
//         child: Ink(
//           height: 52,
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(colors: [_kTeal, _kTealDark]),
//             borderRadius: BorderRadius.circular(14),
//             boxShadow: const [
//               BoxShadow(
//                   color: Color(0x4D0B84A8),
//                   blurRadius: 14,
//                   offset: Offset(0, 6)),
//             ],
//           ),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(14),
//             splashColor: _kCyan.withOpacity(0.3),
//             onTap: disabled ? null : onPressed,
//             child: Center(
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   loading
//                       ? const SizedBox(
//                     width: 18,
//                     height: 18,
//                     child: CircularProgressIndicator(
//                         strokeWidth: 2.2, color: Colors.white),
//                   )
//                       : Icon(icon, color: Colors.white, size: 20),
//                   const SizedBox(width: 10),
//                   Flexible(
//                     child: Text(label,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w800,
//                           fontSize: 15,
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _StatusChip extends StatelessWidget {
//   final String text;
//   const _StatusChip(this.text);
//
//   @override
//   Widget build(BuildContext context) {
//     final c = _statusColor(text);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: c.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 7,
//             height: 7,
//             decoration: BoxDecoration(color: c, shape: BoxShape.circle),
//           ),
//           const SizedBox(width: 6),
//           Text(text,
//               style: TextStyle(
//                 color: c,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w800,
//               )),
//         ],
//       ),
//     );
//   }
// }
//
// class _InfoRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//   final Color? valueColor;
//   const _InfoRow(this.icon, this.label, this.value, {this.valueColor});
//
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.symmetric(vertical: 5),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 1),
//           child: Icon(icon, size: 17, color: _kTeal),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Text.rich(
//             TextSpan(
//               children: [
//                 TextSpan(
//                   text: '$label: ',
//                   style: const TextStyle(
//                     color: _kMuted,
//                     fontSize: 13.5,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 TextSpan(
//                   text: value,
//                   style: TextStyle(
//                     color: valueColor ?? _kHeading,
//                     fontSize: 13.5,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// class _EmptyState extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String message;
//   const _EmptyState(
//       {required this.icon, required this.title, required this.message});
//
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 32),
//     child: Column(
//       children: [
//         Container(
//           width: 84,
//           height: 84,
//           decoration: const BoxDecoration(
//             color: _kTile,
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, size: 40, color: _kTeal),
//         ),
//         const SizedBox(height: 18),
//         Text(title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               color: _kHeading,
//               fontSize: 18,
//               fontWeight: FontWeight.w800,
//             )),
//         const SizedBox(height: 6),
//         Text(message,
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: _kMuted, fontSize: 13.5, height: 1.4)),
//       ],
//     ),
//   );
// }
//
// class _ErrorState extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;
//   const _ErrorState({required this.message, required this.onRetry});
//
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 32),
//     child: Column(
//       children: [
//         Container(
//           width: 84,
//           height: 84,
//           decoration: BoxDecoration(
//             color: _kDanger.withOpacity(0.10),
//             shape: BoxShape.circle,
//           ),
//           child: const Icon(Icons.cloud_off_rounded, size: 40, color: _kDanger),
//         ),
//         const SizedBox(height: 18),
//         const Text('Something went wrong',
//             style: TextStyle(
//               color: _kHeading,
//               fontSize: 18,
//               fontWeight: FontWeight.w800,
//             )),
//         const SizedBox(height: 6),
//         Text(message,
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: _kMuted, fontSize: 13.5, height: 1.4)),
//         const SizedBox(height: 20),
//         SizedBox(
//           width: 180,
//           child: _GradButton(
//             label: 'Try again',
//             icon: Icons.refresh_rounded,
//             loading: false,
//             onPressed: onRetry,
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// // ───────── Compact action button (small pill, not a big elevated button) ─────────
// class _CompactButton extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final bool filled;
//   final VoidCallback? onPressed; // null = disabled
//   const _CompactButton({
//     required this.label,
//     required this.icon,
//     required this.filled,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final Color fg = filled ? Colors.white : _kTealDark;
//     return Opacity(
//       opacity: onPressed == null ? 0.5 : 1,
//       child: Material(
//         color: Colors.transparent,
//         child: Ink(
//           height: 42,
//           decoration: BoxDecoration(
//             gradient:
//             filled ? const LinearGradient(colors: [_kTeal, _kTealDark]) : null,
//             color: filled ? null : _kTile,
//             borderRadius: BorderRadius.circular(12),
//             border: filled ? null : Border.all(color: _kBorder, width: 1.2),
//           ),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             splashColor: _kCyan.withOpacity(0.3),
//             onTap: onPressed,
//             child: Center(
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(icon, size: 17, color: fg),
//                   const SizedBox(width: 6),
//                   Flexible(
//                     child: Text(
//                       label,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         color: fg,
//                         fontWeight: FontWeight.w800,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// // ═════════════════════════ VIEW DEPARTMENT STAFF PAGE ═════════════════════════
// class ViewDepartmentStaffPage extends StatefulWidget {
//   const ViewDepartmentStaffPage({super.key});
//
//   @override
//   State<ViewDepartmentStaffPage> createState() =>
//       _ViewDepartmentStaffPageState();
// }
//
// class _ViewDepartmentStaffPageState extends State<ViewDepartmentStaffPage> {
//   List staff = [];
//   bool loading = true;
//   bool _fetching = false; // blocks overlapping requests
//   bool _opening = false; // blocks double taps on Chat
//   String? errorMsg;
//
//   @override
//   void initState() {
//     super.initState();
//     viewStaff();
//   }
//
//   // ───────── Helpers ─────────
//   void _snack(String msg) {
//     if (!mounted) return;
//     _snackOn(context, msg);
//   }
//
//   void _fail(String msg) {
//     if (!mounted) return;
//     setState(() {
//       loading = false;
//       if (staff.isEmpty) errorMsg = msg;
//     });
//     if (staff.isNotEmpty) _snack(msg);
//   }
//
//   void _retry() {
//     setState(() {
//       loading = true;
//       errorMsg = null;
//     });
//     viewStaff();
//   }
//
//   // ───────── Load data ─────────
//   Future<void> viewStaff() async {
//     if (_fetching) return;
//     _fetching = true;
//
//     try {
//       final sh = await SharedPreferences.getInstance();
//       String url = (sh.getString("url") ?? "").trim();
//       String lid = (sh.getString("lid") ?? "").trim();
//
//       if (url.isEmpty || lid.isEmpty) {
//         _fail('Session expired. Please log in again');
//         return;
//       }
//
//       url = url.endsWith('/') ? url : '$url/';
//
//       if (!url.endsWith('/myapp/')) {
//         url = '${url}myapp/';
//       }
//
//       var response = await http.post(
//         Uri.parse("${url}flutter_view_department_staff/"),
//         body: {
//           'lid': lid,
//         },
//       ).timeout(const Duration(seconds: 30));
//
//       if (response.statusCode < 200 || response.statusCode >= 300) {
//         _fail('Server error (${response.statusCode}). Please try again');
//         return;
//       }
//
//       var data = jsonDecode(response.body);
//
//       if (!mounted) return;
//
//       if (data is Map && data['status'] == 'ok') {
//         final raw = data['staff'];
//         setState(() {
//           staff = raw is List ? raw : [];
//           loading = false;
//           errorMsg = null;
//         });
//       } else {
//         _fail((data is Map ? data['message'] : null)?.toString() ??
//             'Unable to load staff');
//       }
//     } on TimeoutException {
//       _fail('Request timed out. Check your connection and try again');
//     } on SocketException {
//       _fail('No internet connection or server unreachable');
//     } on FormatException {
//       _fail('Unexpected response from server');
//     } catch (e) {
//       print(e);
//       _fail('Unable to load staff');
//     } finally {
//       _fetching = false;
//     }
//   }
//
//   Future<void> openChat(var i) async {
//     if (_opening) return;
//
//     if (i is! Map) {
//       _snack('Unable to open chat');
//       return;
//     }
//
//     final String id = _txt(i['id'], '');
//     if (id.isEmpty) {
//       _snack('Invalid staff member. Please refresh and try again');
//       return;
//     }
//
//     _opening = true;
//
//     try {
//       final sh = await SharedPreferences.getInstance();
//       String lid = (sh.getString("lid") ?? "").trim();
//
//       if (!mounted) return;
//
//       if (lid.isEmpty) {
//         _snack('Session expired. Please log in again');
//         return;
//       }
//
//       if (lid == id) {
//         _snack('You cannot chat with yourself');
//         return;
//       }
//
//       await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ChatPage(
//             receiverId: id,
//             staffName: _txt(i['name'], 'Staff'),
//             lid: lid,
//           ),
//         ),
//       );
//     } catch (e) {
//       _snack('Unable to open chat');
//     } finally {
//       _opening = false;
//     }
//   }
//
//   // ───────── UI ─────────
//   Widget _avatar(String name) {
//     final initial = name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();
//     return Container(
//       width: 50,
//       height: 50,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [_kCyan, _kTeal],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: const [
//           BoxShadow(
//               color: Color(0x2E0B84A8), blurRadius: 10, offset: Offset(0, 4)),
//         ],
//       ),
//       child: Text(
//         initial,
//         style: const TextStyle(
//           color: _kDeep,
//           fontSize: 22,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
//     );
//   }
//
//   Widget _card(Map i) {
//     final name = _txt(i['name'], 'Unnamed staff');
//     final designation = _txt(i['designation'], '');
//     final email = _txt(i['email'], 'Not provided');
//     final canChat = _txt(i['id'], '').isNotEmpty;
//
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: _Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 _avatar(name),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           color: _kHeading,
//                           fontSize: 17,
//                           fontWeight: FontWeight.w800,
//                           letterSpacing: -0.3,
//                         ),
//                       ),
//                       if (designation.isNotEmpty) ...[
//                         const SizedBox(height: 5),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: _kTile,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Text(
//                             designation,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               color: _kTealDark,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Divider(height: 1, color: _kBorder),
//             const SizedBox(height: 8),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: _InfoRow(Icons.email_rounded, 'Email', email),
//                 ),
//                 const SizedBox(width: 10),
//                 SizedBox(
//                   width: 104,
//                   child: _CompactButton(
//                     label: 'Chat',
//                     icon: Icons.chat_bubble_rounded,
//                     filled: true,
//                     onPressed: canChat ? () => openChat(i) : null,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _scrollable(Widget child) => RefreshIndicator(
//     color: _kTeal,
//     onRefresh: viewStaff,
//     child: ListView(
//       physics: const AlwaysScrollableScrollPhysics(),
//       children: [const SizedBox(height: 70), child],
//     ),
//   );
//
//   Widget _body() {
//     if (loading) {
//       return const Center(child: CircularProgressIndicator(color: _kTeal));
//     }
//
//     if (errorMsg != null && staff.isEmpty) {
//       return _scrollable(_ErrorState(message: errorMsg!, onRetry: _retry));
//     }
//
//     if (staff.isEmpty) {
//       return _scrollable(const _EmptyState(
//         icon: Icons.groups_outlined,
//         title: 'No staff found',
//         message: 'No staff found in your department.',
//       ));
//     }
//
//     return RefreshIndicator(
//       color: _kTeal,
//       onRefresh: viewStaff,
//       child: ListView.builder(
//         physics: const AlwaysScrollableScrollPhysics(
//             parent: BouncingScrollPhysics()),
//         padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
//         itemCount: staff.length,
//         itemBuilder: (context, index) {
//           final item = staff[index];
//           if (item is! Map) return const SizedBox.shrink();
//           return _card(item);
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final subtitle = loading
//         ? 'Loading staff...'
//         : staff.isEmpty
//         ? 'No staff to show right now.'
//         : '${staff.length} staff member${staff.length == 1 ? '' : 's'} in your department';
//
//     return Scaffold(
//       backgroundColor: _kCanvas,
//       appBar: _appBar('Department Staff'),
//       body: Column(
//         children: [
//           _Header(
//             title: 'Department staff',
//             subtitle: subtitle,
//             icon: Icons.groups_rounded,
//           ),
//           Expanded(child: _body()),
//         ],
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
import 'package:labtrackapp/chat.dart';

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


// ═════════════════════════ VIEW DEPARTMENT STAFF PAGE ═════════════════════════
class ViewDepartmentStaffPage extends StatefulWidget {
  const ViewDepartmentStaffPage({super.key});

  @override
  State<ViewDepartmentStaffPage> createState() =>
      _ViewDepartmentStaffPageState();
}

class _ViewDepartmentStaffPageState extends State<ViewDepartmentStaffPage> {
  List staff = [];
  bool loading = true;
  bool _fetching = false; // blocks overlapping requests
  bool _opening = false; // blocks double taps on Chat
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    viewStaff();
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
      if (staff.isEmpty) errorMsg = msg;
    });
    if (staff.isNotEmpty) _snack(msg);
  }

  void _retry() {
    setState(() {
      loading = true;
      errorMsg = null;
    });
    viewStaff();
  }

  // ───────── Load data ─────────
  Future<void> viewStaff() async {
    if (_fetching) return;
    _fetching = true;

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
        Uri.parse("${url}flutter_view_department_staff/"),
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
        final raw = data['staff'];
        setState(() {
          staff = raw is List ? raw : [];
          loading = false;
          errorMsg = null;
        });
      } else {
        _fail((data is Map ? data['message'] : null)?.toString() ??
            'Unable to load staff');
      }
    } on TimeoutException {
      _fail('Request timed out. Check your connection and try again');
    } on SocketException {
      _fail('No internet connection or server unreachable');
    } on FormatException {
      _fail('Unexpected response from server');
    } catch (e) {
      print(e);
      _fail('Unable to load staff');
    } finally {
      _fetching = false;
    }
  }

  Future<void> openChat(var i) async {
    if (_opening) return;

    if (i is! Map) {
      _snack('Unable to open chat');
      return;
    }

    final String id = _txt(i['id'], '');
    if (id.isEmpty) {
      _snack('Invalid staff member. Please refresh and try again');
      return;
    }

    _opening = true;

    try {
      final sh = await SharedPreferences.getInstance();
      String lid = (sh.getString("lid") ?? "").trim();

      if (!mounted) return;

      if (lid.isEmpty) {
        _snack('Session expired. Please log in again');
        return;
      }

      if (lid == id) {
        _snack('You cannot chat with yourself');
        return;
      }

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            receiverId: id,
            staffName: _txt(i['name'], 'Staff'),
            lid: lid,
          ),
        ),
      );
    } catch (e) {
      _snack('Unable to open chat');
    } finally {
      _opening = false;
    }
  }

  // ───────── UI ─────────
  Widget _avatar(String name) {
    final initial = name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_kCyan, _kTeal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x2E0B84A8), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Text(
        initial,
        style: const TextStyle(
          color: _kDeep,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _card(Map i) {
    final name = _txt(i['name'], 'Unnamed staff');
    final designation = _txt(i['designation'], '');
    final email = _txt(i['email'], 'Not provided');
    final canChat = _txt(i['id'], '').isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _avatar(name),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _kHeading,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      if (designation.isNotEmpty) ...[
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _kTile,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            designation,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _kTealDark,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, color: _kBorder),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _InfoRow(Icons.email_rounded, 'Email', email),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 104,
                  child: _CompactButton(
                    label: 'Chat',
                    icon: Icons.chat_bubble_rounded,
                    filled: true,
                    onPressed: canChat ? () => openChat(i) : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollable(Widget child) => RefreshIndicator(
    color: _kTeal,
    onRefresh: viewStaff,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [const SizedBox(height: 70), child],
    ),
  );

  Widget _body() {
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: _kTeal));
    }

    if (errorMsg != null && staff.isEmpty) {
      return _scrollable(_ErrorState(message: errorMsg!, onRetry: _retry));
    }

    if (staff.isEmpty) {
      return _scrollable(const _EmptyState(
        icon: Icons.groups_outlined,
        title: 'No staff found',
        message: 'No staff found in your department.',
      ));
    }

    return RefreshIndicator(
      color: _kTeal,
      onRefresh: viewStaff,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        itemCount: staff.length,
        itemBuilder: (context, index) {
          final item = staff[index];
          if (item is! Map) return const SizedBox.shrink();
          return _card(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitle = loading
        ? 'Loading staff...'
        : staff.isEmpty
        ? 'No staff to show right now.'
        : '${staff.length} staff member${staff.length == 1 ? '' : 's'} in your department';

    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('Department Staff'),
      body: Column(
        children: [
          _Header(
            title: 'Department staff',
            subtitle: subtitle,
            icon: Icons.groups_rounded,
          ),
          Expanded(child: _body()),
        ],
      ),
    );
  }
}