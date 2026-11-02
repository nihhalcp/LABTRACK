// // import 'dart:async';
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class ChatPage extends StatefulWidget {
// //   final String receiverId;
// //   final String staffName;
// //   final String lid;
// //
// //   const ChatPage({
// //     super.key,
// //     required this.receiverId,
// //     required this.staffName,
// //     required this.lid,
// //   });
// //
// //   @override
// //   State<ChatPage> createState() => _ChatPageState();
// // }
// //
// // class _ChatPageState extends State<ChatPage> {
// //   final TextEditingController messageController =
// //   TextEditingController();
// //
// //   Timer? timer;
// //
// //   List messages = [];
// //   bool loading = true;
// //   bool sending = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     viewMessages();
// //     timer_start();
// //   }
// //
// //   Future<void> viewMessages() async {
// //     try {
// //       final sh = await SharedPreferences.getInstance();
// //       String url = sh.getString("url") ?? "";
// //
// //       url = url.endsWith('/') ? url : '$url/';
// //
// //       if (!url.endsWith('/myapp/')) {
// //         url = '${url}myapp/';
// //       }
// //
// //       var response = await http.post(
// //         Uri.parse("${url}flutter_view_chat_messages/"),
// //         body: {
// //           'lid': widget.lid,
// //           'receiver_id': widget.receiverId,
// //         },
// //       );
// //
// //       var data = jsonDecode(response.body);
// //
// //       if (!mounted) return;
// //
// //       if (data['status'] == 'ok') {
// //         setState(() {
// //           messages = data['data'];
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
// //
// //   void timer_start()
// //   {
// //     timer = Timer.periodic(const Duration(seconds: 5), (t) {
// //       viewMessages();
// //     });
// //   }
// //
// //
// //   Future<void> sendMessage() async {
// //     if (messageController.text.trim().isEmpty) {
// //       return;
// //     }
// //
// //     setState(() {
// //       sending = true;
// //     });
// //
// //     try {
// //       final sh = await SharedPreferences.getInstance();
// //       String url = sh.getString("url") ?? "";
// //
// //       url = url.endsWith('/') ? url : '$url/';
// //
// //       if (!url.endsWith('/myapp/')) {
// //         url = '${url}myapp/';
// //       }
// //
// //       var response = await http.post(
// //         Uri.parse("${url}flutter_send_chat_message/"),
// //         body: {
// //           'lid': widget.lid,
// //           'receiver_id': widget.receiverId,
// //           'message': messageController.text.trim(),
// //         },
// //       );
// //
// //       var data = jsonDecode(response.body);
// //
// //       if (!mounted) return;
// //
// //       if (data['status'] == 'ok') {
// //         messageController.clear();
// //         await viewMessages();
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Failed to send message')),
// //         );
// //       }
// //     } catch (e) {
// //       print(e);
// //
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Unable to send message')),
// //         );
// //       }
// //     } finally {
// //       if (mounted) {
// //         setState(() {
// //           sending = false;
// //         });
// //       }
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     messageController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Chat with ${widget.staffName}'),
// //         actions: [
// //           IconButton(
// //             onPressed: viewMessages,
// //             icon: const Icon(Icons.refresh),
// //           ),
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: loading
// //                 ? const Center(
// //               child: CircularProgressIndicator(),
// //             )
// //                 : messages.isEmpty
// //                 ? const Center(
// //               child: Text('No messages yet'),
// //             )
// //                 : ListView.builder(
// //               itemCount: messages.length,
// //               itemBuilder: (context, index) {
// //                 var i = messages[index];
// //
// //                 bool isMine =
// //                     i['from'].toString() == widget.lid;
// //
// //                 return Align(
// //                   alignment: isMine
// //                       ? Alignment.centerRight
// //                       : Alignment.centerLeft,
// //                   child: Card(
// //                     color: isMine
// //                         ? Colors.amber.shade100
// //                         : Colors.grey.shade200,
// //                     margin: const EdgeInsets.all(8),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(10),
// //                       child: Column(
// //                         crossAxisAlignment:
// //                         CrossAxisAlignment.start,
// //                         children: [
// //                           Text(i['msg'] ?? ''),
// //                           const SizedBox(height: 5),
// //                           Text(
// //                             i['date'] ?? '',
// //                             style: const TextStyle(
// //                               fontSize: 11,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(10),
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     controller: messageController,
// //                     decoration: const InputDecoration(
// //                       hintText: 'Type a message',
// //                       border: OutlineInputBorder(),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 IconButton(
// //                   onPressed: sending ? null : sendMessage,
// //                   icon: const Icon(Icons.send),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ChatPage extends StatefulWidget {
//   final String receiverId;
//   final String staffName;
//   final String lid;
//
//   const ChatPage({
//     super.key,
//     required this.receiverId,
//     required this.staffName,
//     required this.lid,
//   });
//
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController messageController =
//   TextEditingController();
//
//   final ScrollController _scrollController = ScrollController();
//
//   Timer? timer;
//
//   List messages = [];
//   bool loading = true;
//   bool sending = false;
//
//   @override
//   void initState() {
//     super.initState();
//     viewMessages();
//     timer_start();
//   }
//
//   void scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   Future<void> viewMessages() async {
//     try {
//       final sh = await SharedPreferences.getInstance();
//       String url = sh.getString("url") ?? "";
//
//       url = url.endsWith('/') ? url : '$url/';
//
//       if (!url.endsWith('/myapp/')) {
//         url = '${url}myapp/';
//       }
//
//       var response = await http.post(
//         Uri.parse("${url}flutter_view_chat_messages/"),
//         body: {
//           'lid': widget.lid,
//           'receiver_id': widget.receiverId,
//         },
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (!mounted) return;
//
//       if (data['status'] == 'ok') {
//         setState(() {
//           messages = data['data'];
//           loading = false;
//         });
//
//         scrollToBottom();
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
//   void timer_start() {
//     timer = Timer.periodic(const Duration(seconds: 5), (t) {
//       viewMessages();
//     });
//   }
//
//   Future<void> sendMessage() async {
//     if (messageController.text.trim().isEmpty) {
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
//
//       url = url.endsWith('/') ? url : '$url/';
//
//       if (!url.endsWith('/myapp/')) {
//         url = '${url}myapp/';
//       }
//
//       var response = await http.post(
//         Uri.parse("${url}flutter_send_chat_message/"),
//         body: {
//           'lid': widget.lid,
//           'receiver_id': widget.receiverId,
//           'message': messageController.text.trim(),
//         },
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (!mounted) return;
//
//       if (data['status'] == 'ok') {
//         messageController.clear();
//         await viewMessages();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to send message')),
//         );
//       }
//     } catch (e) {
//       print(e);
//
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Unable to send message')),
//         );
//       }
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
//     timer?.cancel();
//     messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with ${widget.staffName}'),
//         actions: [
//           IconButton(
//             onPressed: viewMessages,
//             icon: const Icon(Icons.refresh),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: loading
//                 ? const Center(
//               child: CircularProgressIndicator(),
//             )
//                 : messages.isEmpty
//                 ? const Center(
//               child: Text('No messages yet'),
//             )
//                 : ListView.builder(
//               controller: _scrollController,
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 var i = messages[index];
//
//                 bool isMine =
//                     i['from'].toString() == widget.lid;
//
//                 return Align(
//                   alignment: isMine
//                       ? Alignment.centerRight
//                       : Alignment.centerLeft,
//                   child: Card(
//                     color: isMine
//                         ? Colors.amber.shade100
//                         : Colors.grey.shade200,
//                     margin: const EdgeInsets.all(8),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                         children: [
//                           Text(i['msg'] ?? ''),
//                           const SizedBox(height: 5),
//                           Text(
//                             i['date'] ?? '',
//                             style: const TextStyle(
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: const InputDecoration(
//                       hintText: 'Type a message',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 IconButton(
//                   onPressed: sending ? null : sendMessage,
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    // Unknown format: drop 'T', seconds, milliseconds and timezone suffix
    return raw
        .replaceAllMapped(
        RegExp(r'(\d{4}-\d{2}-\d{2})T'), (m) => '${m.group(1)} ')
        .replaceAllMapped(
        RegExp(r'(\d{1,2}:\d{2}):\d{2}(\.\d+)?(\s?(Z|[+-]\d{2}:?\d{2}))?'),
            (m) => m.group(1)!);
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



// ═════════════════════════ CHAT PAGE ═════════════════════════
class ChatPage extends StatefulWidget {
  final String receiverId;
  final String staffName;
  final String lid;

  const ChatPage({
    super.key,
    required this.receiverId,
    required this.staffName,
    required this.lid,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const int _maxLength = 1000;

  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Timer? timer;

  List<Map> messages = [];
  bool loading = true;
  bool sending = false;
  bool _fetching = false; // blocks overlapping requests
  bool _firstLoad = true;
  String? errorMsg; // full-screen error (only when nothing is loaded)
  String? inputError; // inline validation under the text box

  @override
  void initState() {
    super.initState();

    // Validate the chat before doing anything
    if (!_validId(widget.lid) || !_validId(widget.receiverId)) {
      loading = false;
      errorMsg = 'Invalid chat. Please go back and try again';
      return;
    }
    if (widget.lid.trim() == widget.receiverId.trim()) {
      loading = false;
      errorMsg = 'You cannot chat with yourself';
      return;
    }

    viewMessages();
    timer_start();
  }

  @override
  void dispose() {
    timer?.cancel();
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ───────── Helpers ─────────
  void _snack(String msg) {
    if (!mounted) return;
    _snackOn(context, msg);
  }

  bool _validId(String id) => int.tryParse(id.trim()) != null;

  /// Server base url ending with /myapp/, or null if the session is invalid.
  Future<String?> _baseUrl() async {
    final sh = await SharedPreferences.getInstance();
    String url = (sh.getString('url') ?? '').trim();
    if (url.isEmpty) return null;

    url = url.endsWith('/') ? url : '$url/';
    if (!url.endsWith('/myapp/')) {
      url = '${url}myapp/';
    }

    final uri = Uri.tryParse(url);
    if (uri == null ||
        !(uri.scheme == 'http' || uri.scheme == 'https') ||
        uri.host.isEmpty) {
      return null;
    }
    return url;
  }

  void _fail(String msg, {bool notify = false}) {
    if (!mounted) return;
    setState(() {
      loading = false;
      if (messages.isEmpty) errorMsg = msg;
    });
    // Background polling stays silent, only manual actions show a message
    if (notify) _snack(msg);
  }

  void _retry() {
    setState(() {
      loading = true;
      errorMsg = null;
    });
    viewMessages(manual: true);
  }

  bool _nearBottom() {
    if (!_scrollController.hasClients) return true;
    final p = _scrollController.position;
    return p.maxScrollExtent - p.pixels < 120;
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ───────── Load messages ─────────
  Future<void> viewMessages({bool manual = false}) async {
    if (_fetching) return;
    _fetching = true;

    try {
      final url = await _baseUrl();
      if (url == null) {
        _fail('Session expired. Please log in again', notify: manual);
        return;
      }

      final response = await http.post(
        Uri.parse('${url}flutter_view_chat_messages/'),
        body: {
          'lid': widget.lid.trim(),
          'receiver_id': widget.receiverId.trim(),
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        _fail('Server error (${response.statusCode}). Please try again',
            notify: manual);
        return;
      }

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (data is Map && data['status'] == 'ok') {
        final raw = data['data'];
        final list = raw is List ? raw.whereType<Map>().toList() : <Map>[];

        final wasAtBottom = _nearBottom();
        final grew = list.length > messages.length;

        setState(() {
          messages = list;
          loading = false;
          errorMsg = null;
        });

        // Scroll on first load, or when new messages arrive and the user
        // is already at the bottom (so reading old messages is not interrupted)
        if (_firstLoad || (grew && wasAtBottom)) {
          scrollToBottom();
        }
        _firstLoad = false;
      } else {
        _fail(
            (data is Map ? data['message'] : null)?.toString() ??
                'Unable to load messages',
            notify: manual);
      }
    } on TimeoutException {
      _fail('Request timed out. Check your connection and try again',
          notify: manual);
    } on SocketException {
      _fail('No internet connection or server unreachable', notify: manual);
    } on FormatException {
      _fail('Unexpected response from server', notify: manual);
    } catch (e) {
      _fail('Unable to load messages', notify: manual);
    } finally {
      _fetching = false;
    }
  }

  void timer_start() {
    timer = Timer.periodic(const Duration(seconds: 5), (t) {
      if (!mounted) return;
      viewMessages();
    });
  }

  // ───────── Send message ─────────
  Future<void> sendMessage() async {
    if (sending) return; // block double taps

    final text = messageController.text.trim();

    // Validation
    if (text.isEmpty) {
      setState(() => inputError = 'Type a message first');
      return;
    }
    if (text.length > _maxLength) {
      setState(() =>
      inputError = 'Message is too long (max $_maxLength characters)');
      return;
    }

    setState(() {
      sending = true;
      inputError = null;
    });

    try {
      final url = await _baseUrl();
      if (url == null) {
        _snack('Session expired. Please log in again');
        return;
      }

      final response = await http.post(
        Uri.parse('${url}flutter_send_chat_message/'),
        body: {
          'lid': widget.lid.trim(),
          'receiver_id': widget.receiverId.trim(),
          'message': text,
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        _snack('Server error (${response.statusCode}). Message not sent');
        return;
      }

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (data is Map && data['status'] == 'ok') {
        messageController.clear();
        await viewMessages();
        scrollToBottom();
      } else {
        // text stays in the box so nothing is lost
        _snack((data is Map ? data['message'] : null)?.toString() ??
            'Failed to send message');
      }
    } on TimeoutException {
      _snack('Request timed out. Message not sent');
    } on SocketException {
      _snack('No internet connection or server unreachable');
    } on FormatException {
      _snack('Unexpected response from server');
    } catch (e) {
      _snack('Unable to send message');
    } finally {
      if (mounted) setState(() => sending = false);
    }
  }

  // ───────── UI ─────────
  Widget _bubble(Map i) {
    final isMine = _txt(i['from'], '') == widget.lid.trim();
    final msg = _txt(i['msg'], '');
    final date = _fmtDate(i['date'], '');

    if (msg.isEmpty) return const SizedBox.shrink();

    final radius = BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: Radius.circular(isMine ? 18 : 4),
      bottomRight: Radius.circular(isMine ? 4 : 18),
    );

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
          decoration: BoxDecoration(
            gradient: isMine
                ? const LinearGradient(colors: [_kTeal, _kTealDark])
                : null,
            color: isMine ? null : Colors.white,
            border: isMine ? null : Border.all(color: _kBorder, width: 1.2),
            borderRadius: radius,
            boxShadow: const [
              BoxShadow(
                  color: Color(0x0F08203A),
                  blurRadius: 10,
                  offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment:
            isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                msg,
                style: TextStyle(
                  color: isMine ? Colors.white : _kHeading,
                  fontSize: 14.5,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (date.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: isMine ? const Color(0xFFD6EEF5) : _kMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _kBorder, width: 1.2)),
        boxShadow: [
          BoxShadow(
              color: Color(0x0F08203A), blurRadius: 14, offset: Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                enabled: !sending,
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(_maxLength),
                ],
                style: const TextStyle(
                    color: _kHeading, fontWeight: FontWeight.w600),
                onChanged: (_) {
                  if (inputError != null) setState(() => inputError = null);
                },
                decoration: _input('Type a message',
                    icon: Icons.chat_bubble_outline_rounded)
                    .copyWith(errorText: inputError),
              ),
            ),
            const SizedBox(width: 10),
            Opacity(
              opacity: sending ? 0.7 : 1,
              child: Material(
                color: Colors.transparent,
                child: Ink(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient:
                    const LinearGradient(colors: [_kTeal, _kTealDark]),
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
                    onTap: sending ? null : sendMessage,
                    child: Center(
                      child: sending
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2.2, color: Colors.white),
                      )
                          : const Icon(Icons.send_rounded,
                          color: Colors.white, size: 22),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: _kTeal));
    }

    if (errorMsg != null && messages.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          child: _ErrorState(message: errorMsg!, onRetry: _retry),
        ),
      );
    }

    if (messages.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          child: _EmptyState(
            icon: Icons.chat_bubble_outline_rounded,
            title: 'No messages yet',
            message:
            'Say hello to ${_txt(widget.staffName, 'staff')} to start the conversation.',
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 8),
      itemCount: messages.length,
      itemBuilder: (context, index) => _bubble(messages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canUse = !(errorMsg != null && messages.isEmpty);

    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar(
        _txt(widget.staffName, 'Chat'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () => viewMessages(manual: true),
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _body()),
          if (canUse && !loading) _inputBar(),
        ],
      ),
    );
  }
}