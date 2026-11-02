// // // import 'package:flutter/material.dart';
// // // import 'package:labtrackapp/change_password.dart';
// // // import 'package:labtrackapp/complaints.dart';
// // // import 'package:labtrackapp/view_comp.dart';
// // // import 'package:labtrackapp/view_equipments.dart';
// // // import 'package:labtrackapp/view_feedback.dart';
// // // import 'package:labtrackapp/view_fines.dart';
// // // import 'package:labtrackapp/view_labs.dart';
// // // import 'package:labtrackapp/view_ntfcns.dart';
// // // import 'package:labtrackapp/view_profile.dart';
// // // import 'package:labtrackapp/view_references.dart';
// // // import 'package:labtrackapp/view_staffs.dart';
// // // import 'package:labtrackapp/view_subjects.dart';
// // // import 'package:labtrackapp/view_submissions.dart';
// // // import 'login.dart';
// // //
// // //
// // // void main() {
// // //   runApp(const MaterialApp(
// // //     debugShowCheckedModeBanner: false,
// // //     home: StudentHomePage(),
// // //   ));
// // // }
// // //
// // // class StudentHomePage extends StatefulWidget {
// // //   const StudentHomePage({super.key});
// // //
// // //   @override
// // //   State<StudentHomePage> createState() => _StudentHomePageState();
// // // }
// // //
// // // class _StudentHomePageState extends State<StudentHomePage> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         iconTheme: const IconThemeData(color: Colors.black87),
// // //       ),
// // //       backgroundColor: const Color(0xFFF5F6FA),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(20.0),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             const Row(
// // //               children: [
// // //                 CircleAvatar(
// // //                   backgroundColor: Colors.deepPurple,
// // //                   radius: 25,
// // //                   child: Icon(
// // //                     Icons.school,
// // //                     color: Colors.white,
// // //                     size: 30,
// // //                   ),
// // //                 ),
// // //                 SizedBox(width: 12),
// // //                 Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       'Hi Student,',
// // //                       style: TextStyle(
// // //                         fontSize: 18,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                     Text(
// // //                       'Welcome to LabTrack',
// // //                       style: TextStyle(color: Colors.black54),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 30),
// // //             Container(
// // //               padding: const EdgeInsets.all(20),
// // //               decoration: BoxDecoration(
// // //                 color: Colors.white,
// // //                 borderRadius: BorderRadius.circular(20),
// // //               ),
// // //               child: const Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: [
// // //                   Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text('LabTrack'),
// // //                       SizedBox(height: 6),
// // //                       Text(
// // //                         'Student Portal',
// // //                         style: TextStyle(
// // //                           fontSize: 18,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   Icon(
// // //                     Icons.science,
// // //                     size: 45,
// // //                     color: Colors.deepPurple,
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //             const SizedBox(height: 25),
// // //             const Text(
// // //               'Student Functions',
// // //               style: TextStyle(
// // //                 fontSize: 16,
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //             ),
// // //             const SizedBox(height: 15),
// // //             Expanded(
// // //               child: GridView.count(
// // //                 crossAxisCount: 2,
// // //                 crossAxisSpacing: 15,
// // //                 mainAxisSpacing: 15,
// // //                 children: [
// // //                   ActionCard(
// // //                     title: 'View Profile',
// // //                     color: Colors.blue,
// // //                     icon: Icons.person,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => ViewProfilePage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                   ActionCard(
// // //                     title: 'View Labs',
// // //                     color: Colors.orange,
// // //                     icon: Icons.lock,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => ViewLabsPage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                   // ActionCard(
// // //                   //   title: 'Lab Coordinator',
// // //                   //   color: Colors.teal,
// // //                   //   icon: Icons.supervisor_account,
// // //                   //   onTap: () {
// // //                   //     // Navigator.push(
// // //                   //     //   context,
// // //                   //       // MaterialPageRoute(
// // //                   //       //   builder: (context) =>
// // //                   //       //       ViewLabCoordinator(title: ''),
// // //                   //       // ),
// // //                   //     );
// // //                   //   },
// // //                   // ),
// // //                   // ActionCard(
// // //                   //   title: 'Lab Instructions',
// // //                   //   color: Colors.deepPurple,
// // //                   //   icon: Icons.menu_book,
// // //                   //   onTap: () {
// // //                   //     Navigator.push(
// // //                   //       context,
// // //                   //       // MaterialPageRoute(
// // //                   //       //   builder: (context) =>
// // //                   //       //       ViewLabInstructions(title: ''),
// // //                   //       // ),
// // //                   //     );
// // //                   //   },
// // //                   // ),
// // //                   // ActionCard(
// // //                   //   title: 'Upload Lab Work',
// // //                   //   color: Colors.green,
// // //                   //   icon: Icons.upload_file,
// // //                   //   // onTap: () {
// // //                   //   //   Navigator.push(
// // //                   //   //     context,
// // //                   //   //     // MaterialPageRoute(
// // //                   //   //     //   builder: (context) => UploadLabWork(title: ''),
// // //                   //   //     // ),
// // //                   //   //   );
// // //                   //   // },
// // //                   // ),
// // //                   ActionCard(
// // //                     title: 'View Lab Equipments',
// // //                     color: Colors.indigo,
// // //                     icon: Icons.computer,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => ViewEquipmentPage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                   ActionCard(
// // //                     title: 'Fines',
// // //                     color: Colors.red,
// // //                     icon: Icons.money_off,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => ViewMyFinesPage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                   ActionCard(
// // //                     title: 'Subjects & References',
// // //                     color: Colors.brown,
// // //                     icon: Icons.history,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) =>
// // //                               ViewSubjectsPage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                   ActionCard(
// // //                     title: 'Grade & Submissions',
// // //                     color: Colors.pink,
// // //                     icon: Icons.grade,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => ViewLabSubmissionsPage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                   ActionCard(
// // //                     title: 'Chat with Staff',
// // //                     color: Colors.deepOrange,
// // //                     icon: Icons.password_rounded,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => ViewDepartmentStaffPage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                   ActionCard(
// // //                     title: 'Notifications',
// // //                     color: Colors.cyan,
// // //                     icon: Icons.notification_add,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) =>
// // //                               ViewNotificationsPage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //
// // //                   ActionCard(
// // //                     title: 'Complaint & Reply',
// // //                     color: Colors.cyan,
// // //                     icon: Icons.mark_chat_read,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) =>
// // //                               ViewComplaintPage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                   ActionCard(
// // //                     title: 'Send Feedback',
// // //                     color: Colors.purple,
// // //                     icon: Icons.feedback,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => ViewFeedbackPage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                   ActionCard(
// // //                     title: 'Change Password',
// // //                     color: Colors.deepOrange,
// // //                     icon: Icons.password_rounded,
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => ChangePasswordPage(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                   ActionCard(
// // //                     title: 'Logout',
// // //                     color: Colors.grey,
// // //                     icon: Icons.logout,
// // //                     onTap: () {
// // //                       Navigator.pushReplacement(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => MyLoginPage(title: ''),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // class ActionCard extends StatelessWidget {
// // //   final String title;
// // //   final Color color;
// // //   final IconData icon;
// // //   final VoidCallback? onTap;
// // //
// // //   const ActionCard({
// // //     super.key,
// // //     required this.title,
// // //     required this.color,
// // //     required this.icon,
// // //     this.onTap,
// // //   });
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GestureDetector(
// // //       onTap: onTap,
// // //       child: Container(
// // //         padding: const EdgeInsets.all(16),
// // //         decoration: BoxDecoration(
// // //           color: color.withOpacity(0.1),
// // //           borderRadius: BorderRadius.circular(20),
// // //         ),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             CircleAvatar(
// // //               backgroundColor: color,
// // //               child: Icon(icon, color: Colors.white),
// // //             ),
// // //             const SizedBox(height: 10),
// // //             Text(
// // //               title,
// // //               style: const TextStyle(
// // //                 fontWeight: FontWeight.bold,
// // //                 fontSize: 16,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'dart:math' as math;
// // import 'package:flutter/material.dart';
// // import 'package:labtrackapp/change_password.dart';
// // import 'package:labtrackapp/complaints.dart';
// // import 'package:labtrackapp/view_comp.dart';
// // import 'package:labtrackapp/view_equipments.dart';
// // import 'package:labtrackapp/view_feedback.dart';
// // import 'package:labtrackapp/view_fines.dart';
// // import 'package:labtrackapp/view_labs.dart';
// // import 'package:labtrackapp/view_ntfcns.dart';
// // import 'package:labtrackapp/view_profile.dart';
// // import 'package:labtrackapp/view_references.dart';
// // import 'package:labtrackapp/view_staffs.dart';
// // import 'package:labtrackapp/view_subjects.dart';
// // import 'package:labtrackapp/view_submissions.dart';
// // import 'login.dart';
// // import 'package:labtrackapp/home.dart';
// //
// // void main() {
// //   runApp(const MaterialApp(
// //     debugShowCheckedModeBanner: false,
// //     home: StudentHomePage(),
// //   ));
// // }
// //
// // // ═════════════════════════ THEME ═════════════════════════
// // const Color kTop = Color(0xFF164A63);
// // const Color kMid = Color(0xFF0D3048);
// // const Color kDeep = Color(0xFF08203A);
// // const Color kCyan = Color(0xFF5CD0EE);
// // const Color kTeal = Color(0xFF0B84A8);
// // const Color kTealDark = Color(0xFF086A89);
// // const Color kHeading = Color(0xFF0D2B3E);
// // const Color kMuted = Color(0xFF5D7183);
// // const Color kCanvas = Color(0xFFF1F6FB);
// // const Color kBorder = Color(0xFFDAE6F1);
// // const Color kTile = Color(0xFFE2F4FA);
// // const Color kDanger = Color(0xFFC0291F);
// //
// // const gBlue = [Color(0xFF38BDF8), Color(0xFF0B84A8)];
// // const gViolet = [Color(0xFFA78BFA), Color(0xFF6D4FD6)];
// // const gGreen = [Color(0xFF34D399), Color(0xFF1C7C54)];
// // const gAmber = [Color(0xFFFBBF24), Color(0xFFE08A0B)];
// // const gRose = [Color(0xFFFB7185), Color(0xFFC0291F)];
// // const gTeal = [Color(0xFF2DD4BF), Color(0xFF0B7F86)];
// //
// // class Feature {
// //   final String title;
// //   final String sub;
// //   final IconData icon;
// //   final List<Color> gradient;
// //   final WidgetBuilder page;
// //
// //   const Feature({
// //     required this.title,
// //     required this.sub,
// //     required this.icon,
// //     required this.gradient,
// //     required this.page,
// //   });
// // }
// //
// // class StudentHomePage extends StatefulWidget {
// //   const StudentHomePage({super.key});
// //
// //   @override
// //   State<StudentHomePage> createState() => _StudentHomePageState();
// // }
// //
// // class _StudentHomePageState extends State<StudentHomePage> {
// //   // ── Lab work ──
// //   late final Feature labs = Feature(
// //     title: 'My Labs',
// //     sub: 'Coordinator & schedule',
// //     icon: Icons.science_rounded,
// //     gradient: gGreen,
// //     page: (c) => ViewLabsPage(),
// //   );
// //   late final Feature subjects = Feature(
// //     title: 'Subjects & References',
// //     sub: 'Lab instructions',
// //     icon: Icons.menu_book_rounded,
// //     gradient: gTeal,
// //     page: (c) => ViewSubjectsPage(),
// //   );
// //   late final Feature submissions = Feature(
// //     title: 'Grade & Submissions',
// //     sub: 'Upload, edit, results',
// //     icon: Icons.cloud_upload_rounded,
// //     gradient: gAmber,
// //     page: (c) => ViewLabSubmissionsPage(),
// //   );
// //   late final Feature equipments = Feature(
// //     title: 'Lab Equipments',
// //     sub: 'Assigned items & status',
// //     icon: Icons.memory_rounded,
// //     gradient: gViolet,
// //     page: (c) => ViewEquipmentPage(),
// //   );
// //   late final Feature fines = Feature(
// //     title: 'Fines',
// //     sub: 'Damage & loss penalties',
// //     icon: Icons.receipt_long_rounded,
// //     gradient: gRose,
// //     page: (c) => ViewMyFinesPage(),
// //   );
// //
// //   // ── Support ──
// //   late final Feature chat = Feature(
// //     title: 'Chat with Staff',
// //     sub: 'Ask your doubts',
// //     icon: Icons.forum_rounded,
// //     gradient: gBlue,
// //     page: (c) => ViewDepartmentStaffPage(),
// //   );
// //   late final Feature notifications = Feature(
// //     title: 'Notifications',
// //     sub: 'Instructions & alerts',
// //     icon: Icons.notifications_active_rounded,
// //     gradient: gAmber,
// //     page: (c) => ViewNotificationsPage(),
// //   );
// //   late final Feature complaints = Feature(
// //     title: 'Complaint & Reply',
// //     sub: 'Raise issues, get replies',
// //     icon: Icons.support_agent_rounded,
// //     gradient: gTeal,
// //     page: (c) => ViewComplaintPage(),
// //   );
// //   late final Feature feedback = Feature(
// //     title: 'Send Feedback',
// //     sub: 'Help us improve',
// //     icon: Icons.rate_review_rounded,
// //     gradient: gViolet,
// //     page: (c) => ViewFeedbackPage(),
// //   );
// //
// //   // ── Account (shown in drawer) ──
// //   late final Feature profile = Feature(
// //     title: 'View Profile',
// //     sub: 'Your details',
// //     icon: Icons.person_rounded,
// //     gradient: gBlue,
// //     page: (c) => ViewProfilePage(),
// //   );
// //   late final Feature password = Feature(
// //     title: 'Change Password',
// //     sub: 'Keep account secure',
// //     icon: Icons.lock_rounded,
// //     gradient: gAmber,
// //     page: (c) => ChangePasswordPage(),
// //   );
// //
// //   void _open(Feature f) {
// //     Navigator.push(context, MaterialPageRoute(builder: f.page));
// //   }
// //
// //   Future<void> _confirmLogout() async {
// //     final ok = await showDialog<bool>(
// //       context: context,
// //       builder: (ctx) => AlertDialog(
// //         backgroundColor: Colors.white,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //         title: const Text(
// //           'Log out of LabTrack?',
// //           style: TextStyle(
// //               color: kHeading, fontWeight: FontWeight.w800, fontSize: 19),
// //         ),
// //         content: const Text(
// //           'You will need to sign in again to use the student portal.',
// //           style: TextStyle(color: kMuted, height: 1.5),
// //         ),
// //         actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(ctx, false),
// //             child: const Text('Stay signed in',
// //                 style: TextStyle(color: kHeading, fontWeight: FontWeight.w700)),
// //           ),
// //           ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: kTeal,
// //               foregroundColor: Colors.white,
// //               elevation: 0,
// //               shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(11)),
// //             ),
// //             onPressed: () => Navigator.pop(ctx, true),
// //             child: const Text('Log out',
// //                 style: TextStyle(fontWeight: FontWeight.w700)),
// //           ),
// //         ],
// //       ),
// //     );
// //     if (ok == true && mounted) {
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (_) => MyLoginPage(title: '')),
// //       );
// //     }
// //   }
// //
// //   String get _greeting {
// //     final h = DateTime.now().hour;
// //     if (h < 12) return 'Good morning';
// //     if (h < 17) return 'Good afternoon';
// //     return 'Good evening';
// //   }
// //
// //   String get _today {
// //     const days = [
// //       'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
// //     ];
// //     const months = [
// //       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
// //       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
// //     ];
// //     final n = DateTime.now();
// //     return '${days[n.weekday - 1]}, ${n.day} ${months[n.month - 1]} ${n.year}';
// //   }
// //
// //   // ═════════════════════════ BUILD ═════════════════════════
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: kCanvas,
// //       appBar: _appBar(),
// //       drawer: _drawer(),
// //       body: SingleChildScrollView(
// //         physics: const BouncingScrollPhysics(),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             _hero(),
// //             _group('Lab Work', Icons.science_rounded,
// //                 [labs, subjects, submissions, equipments, fines]),
// //             _group('Support & Communication', Icons.forum_rounded,
// //                 [chat, notifications, complaints, feedback]),
// //             const SizedBox(height: 22),
// //             const Center(
// //               child: Text(
// //                 '© LabTrack · Student Panel',
// //                 style: TextStyle(color: Color(0xFF8196A8), fontSize: 12),
// //               ),
// //             ),
// //             const SizedBox(height: 24),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ═════════════════════════ APP BAR ═════════════════════════
// //   PreferredSizeWidget _appBar() {
// //     return AppBar(
// //       toolbarHeight: 60,
// //       elevation: 0,
// //       scrolledUnderElevation: 0,
// //       iconTheme: const IconThemeData(color: Colors.white),
// //       titleSpacing: 0,
// //       flexibleSpace: Container(
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [kTop, kMid, kDeep],
// //             begin: Alignment.centerLeft,
// //             end: Alignment.centerRight,
// //           ),
// //         ),
// //       ),
// //       title: Row(
// //         children: [
// //           Container(
// //             width: 34,
// //             height: 34,
// //             decoration: BoxDecoration(
// //               color: kCyan,
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: const Icon(Icons.biotech_rounded, color: kDeep, size: 21),
// //           ),
// //           const SizedBox(width: 10),
// //           const Text(
// //             'LabTrack',
// //             style: TextStyle(
// //               color: Colors.white,
// //               fontWeight: FontWeight.w800,
// //               fontSize: 19,
// //               letterSpacing: -0.3,
// //             ),
// //           ),
// //         ],
// //       ),
// //       actions: [
// //         IconButton(
// //           tooltip: 'Notifications',
// //           hoverColor: Colors.white24,
// //           icon: const Icon(Icons.notifications_rounded),
// //           onPressed: () => _open(notifications),
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.only(right: 14, left: 2),
// //           child: InkWell(
// //             customBorder: const CircleBorder(),
// //             hoverColor: Colors.white24,
// //             onTap: () => _open(profile),
// //             child: const CircleAvatar(
// //               radius: 16,
// //               backgroundColor: kCyan,
// //               child: Text('S',
// //                   style: TextStyle(
// //                       color: kDeep, fontWeight: FontWeight.w800, fontSize: 14)),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   // ═════════════════════════ DRAWER ═════════════════════════
// //   Drawer _drawer() {
// //     void go(Feature f) {
// //       Navigator.pop(context);
// //       _open(f);
// //     }
// //
// //     return Drawer(
// //       backgroundColor: kCanvas,
// //       width: 300,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.only(
// //           topRight: Radius.circular(26),
// //           bottomRight: Radius.circular(26),
// //         ),
// //       ),
// //       child: Column(
// //         children: [
// //           Container(
// //             width: double.infinity,
// //             padding: EdgeInsets.fromLTRB(
// //                 20, MediaQuery.of(context).padding.top + 22, 20, 20),
// //             decoration: const BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [kTop, kDeep],
// //                 begin: Alignment.topLeft,
// //                 end: Alignment.bottomRight,
// //               ),
// //               borderRadius: BorderRadius.only(topRight: Radius.circular(26)),
// //             ),
// //             child: Row(
// //               children: [
// //                 Container(
// //                   padding: const EdgeInsets.all(3),
// //                   decoration: const BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     color: kCyan,
// //                   ),
// //                   child: const CircleAvatar(
// //                     radius: 28,
// //                     backgroundColor: kMid,
// //                     child:
// //                     Icon(Icons.school_rounded, color: Colors.white, size: 28),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 14),
// //                 const Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         'Hi Student',
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.w800,
// //                         ),
// //                       ),
// //                       SizedBox(height: 2),
// //                       Text(
// //                         'LabTrack Student Portal',
// //                         style:
// //                         TextStyle(color: Color(0xFFB9D3E3), fontSize: 12.5),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Expanded(
// //             child: ListView(
// //               padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
// //               physics: const BouncingScrollPhysics(),
// //               children: [
// //                 // ── Account items first ──
// //                 _drawerLabel('ACCOUNT'),
// //                 _DrawerItem(
// //                   icon: profile.icon,
// //                   label: profile.title,
// //                   onTap: () => go(profile),
// //                 ),
// //                 _DrawerItem(
// //                   icon: password.icon,
// //                   label: password.title,
// //                   onTap: () => go(password),
// //                 ),
// //                 const Divider(height: 22, color: kBorder),
// //                 _DrawerItem(
// //                   icon: Icons.home_rounded,
// //                   label: 'Home',
// //                   selected: true,
// //                   onTap: () => Navigator.pop(context),
// //                 ),
// //                 _drawerLabel('LAB WORK'),
// //                 for (final f in [labs, subjects, submissions, equipments, fines])
// //                   _DrawerItem(
// //                     icon: f.icon,
// //                     label: f.title,
// //                     onTap: () => go(f),
// //                   ),
// //                 _drawerLabel('SUPPORT'),
// //                 for (final f in [chat, notifications, complaints, feedback])
// //                   _DrawerItem(
// //                     icon: f.icon,
// //                     label: f.title,
// //                     onTap: () => go(f),
// //                   ),
// //               ],
// //             ),
// //           ),
// //           // logout pinned at bottom
// //           Container(
// //             padding: EdgeInsets.fromLTRB(
// //                 12, 8, 12, MediaQuery.of(context).padding.bottom + 12),
// //             decoration: const BoxDecoration(
// //               border: Border(top: BorderSide(color: kBorder)),
// //             ),
// //             child: _DrawerItem(
// //               icon: Icons.logout_rounded,
// //               label: 'Logout',
// //               danger: true,
// //               onTap: () {
// //                 Navigator.pop(context);
// //                 _confirmLogout();
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _drawerLabel(String t) => Padding(
// //     padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
// //     child: Text(
// //       t,
// //       style: const TextStyle(
// //         color: kMuted,
// //         fontSize: 11,
// //         fontWeight: FontWeight.w800,
// //         letterSpacing: 1.4,
// //       ),
// //     ),
// //   );
// //
// //   // ═════════════════════════ COMPACT HERO ═════════════════════════
// //   Widget _hero() {
// //     return Container(
// //       width: double.infinity,
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [kTop, kDeep],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //         borderRadius: BorderRadius.only(
// //           bottomLeft: Radius.circular(28),
// //           bottomRight: Radius.circular(28),
// //         ),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Color(0x3308203A),
// //             blurRadius: 24,
// //             offset: Offset(0, 12),
// //           ),
// //         ],
// //       ),
// //       child: ClipRRect(
// //         borderRadius: const BorderRadius.only(
// //           bottomLeft: Radius.circular(28),
// //           bottomRight: Radius.circular(28),
// //         ),
// //         child: Stack(
// //           children: [
// //             Positioned(
// //               right: -50,
// //               top: -70,
// //               child: Container(
// //                 width: 230,
// //                 height: 230,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   gradient: RadialGradient(
// //                     colors: [kCyan.withOpacity(0.32), kCyan.withOpacity(0)],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             Positioned.fill(child: CustomPaint(painter: _DotsPainter())),
// //             Padding(
// //               padding: const EdgeInsets.fromLTRB(20, 16, 14, 22),
// //               child: Row(
// //                 children: [
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Container(
// //                           padding: const EdgeInsets.symmetric(
// //                               horizontal: 12, vertical: 6),
// //                           decoration: BoxDecoration(
// //                             color: Colors.white.withOpacity(0.12),
// //                             borderRadius: BorderRadius.circular(30),
// //                             border: Border.all(
// //                                 color: Colors.white.withOpacity(0.22)),
// //                           ),
// //                           child: Row(
// //                             mainAxisSize: MainAxisSize.min,
// //                             children: [
// //                               const _PulseDot(),
// //                               const SizedBox(width: 8),
// //                               Text(
// //                                 _today,
// //                                 style: const TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 11.5,
// //                                   fontWeight: FontWeight.w700,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         const SizedBox(height: 12),
// //                         Text(
// //                           '$_greeting 👋',
// //                           style: const TextStyle(
// //                             color: kCyan,
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.w700,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 2),
// //                         const Text(
// //                           'Your LabTrack\nStudent Desk',
// //                           style: TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 24,
// //                             fontWeight: FontWeight.w800,
// //                             height: 1.15,
// //                             letterSpacing: -0.5,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 8),
// //                         const Text(
// //                           'Lab notebooks, equipment, fines & staff chat.',
// //                           style: TextStyle(
// //                             color: Color(0xFFB9D3E3),
// //                             fontSize: 12.5,
// //                             height: 1.4,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   const _HeroArt(),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ═════════════════════════ CARD GROUP ═════════════════════════
// //   Widget _group(String title, IconData icon, List<Feature> items) {
// //     return Padding(
// //       padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.all(7),
// //                 decoration: BoxDecoration(
// //                   color: kTile,
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 child: Icon(icon, size: 17, color: kTeal),
// //               ),
// //               const SizedBox(width: 10),
// //               Text(
// //                 title,
// //                 style: const TextStyle(
// //                   color: kHeading,
// //                   fontSize: 17,
// //                   fontWeight: FontWeight.w800,
// //                   letterSpacing: -0.3,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 12),
// //           LayoutBuilder(
// //             builder: (context, c) {
// //               final cols = c.maxWidth >= 980 ? 4 : (c.maxWidth >= 620 ? 3 : 2);
// //               const gap = 12.0;
// //               final w = (c.maxWidth - gap * (cols - 1)) / cols;
// //               return Wrap(
// //                 spacing: gap,
// //                 runSpacing: gap,
// //                 children: [
// //                   for (var i = 0; i < items.length; i++)
// //                     SizedBox(
// //                       width: w,
// //                       height: 128,
// //                       child: _FadeSlide(
// //                         index: i,
// //                         child: _FeatureCard(
// //                           feature: items[i],
// //                           onTap: () => _open(items[i]),
// //                         ),
// //                       ),
// //                     ),
// //                 ],
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // // ═════════════════════════ WIDGETS ═════════════════════════
// //
// // /// Hover (desktop/web) + press (touch) wrapper.
// // class _Hover extends StatefulWidget {
// //   final Widget Function(bool hover, bool pressed) builder;
// //   final VoidCallback? onTap;
// //   final double lift;
// //   final double pressScale;
// //
// //   const _Hover({
// //     required this.builder,
// //     this.onTap,
// //     this.lift = 5,
// //     this.pressScale = 0.96,
// //   });
// //
// //   @override
// //   State<_Hover> createState() => _HoverState();
// // }
// //
// // class _HoverState extends State<_Hover> {
// //   bool _hover = false;
// //   bool _pressed = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final dy = (_hover && !_pressed) ? -widget.lift : 0.0;
// //     final s = _pressed ? widget.pressScale : 1.0;
// //     return MouseRegion(
// //       cursor: SystemMouseCursors.click,
// //       onEnter: (_) => setState(() => _hover = true),
// //       onExit: (_) => setState(() => _hover = false),
// //       child: GestureDetector(
// //         behavior: HitTestBehavior.opaque,
// //         onTapDown: (_) => setState(() => _pressed = true),
// //         onTapCancel: () => setState(() => _pressed = false),
// //         onTapUp: (_) => setState(() => _pressed = false),
// //         onTap: widget.onTap,
// //         child: AnimatedContainer(
// //           duration: const Duration(milliseconds: 220),
// //           curve: Curves.easeOut,
// //           transformAlignment: Alignment.center,
// //           transform: Matrix4.translationValues(0, dy, 0)..scale(s),
// //           child: widget.builder(_hover || _pressed, _pressed),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // /// Compact card used in the grid.
// // class _FeatureCard extends StatelessWidget {
// //   final Feature feature;
// //   final VoidCallback onTap;
// //   const _FeatureCard({required this.feature, required this.onTap});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return _Hover(
// //       onTap: onTap,
// //       builder: (active, pressed) => AnimatedContainer(
// //         duration: const Duration(milliseconds: 250),
// //         clipBehavior: Clip.antiAlias,
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(18),
// //           border: Border.all(color: active ? kTeal : kBorder, width: 1.2),
// //           boxShadow: [
// //             BoxShadow(
// //               color: active
// //                   ? const Color(0x2E0B5478)
// //                   : const Color(0x0F08203A),
// //               blurRadius: active ? 24 : 10,
// //               offset: Offset(0, active ? 12 : 5),
// //             ),
// //           ],
// //         ),
// //         child: Stack(
// //           children: [
// //             // accent bar
// //             Positioned(
// //               left: 0,
// //               right: 0,
// //               top: 0,
// //               height: 3.5,
// //               child: AnimatedFractionallySizedBox(
// //                 duration: const Duration(milliseconds: 350),
// //                 curve: Curves.easeOut,
// //                 alignment: Alignment.centerLeft,
// //                 widthFactor: active ? 1 : 0,
// //                 heightFactor: 1,
// //                 child: const DecoratedBox(
// //                   decoration: BoxDecoration(
// //                     gradient: LinearGradient(colors: [kCyan, kTeal]),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(14),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       AnimatedRotation(
// //                         turns: active ? -0.022 : 0,
// //                         duration: const Duration(milliseconds: 300),
// //                         child: AnimatedScale(
// //                           scale: active ? 1.1 : 1,
// //                           duration: const Duration(milliseconds: 300),
// //                           child: Container(
// //                             width: 44,
// //                             height: 44,
// //                             decoration: BoxDecoration(
// //                               gradient: LinearGradient(
// //                                 colors: feature.gradient,
// //                                 begin: Alignment.topLeft,
// //                                 end: Alignment.bottomRight,
// //                               ),
// //                               borderRadius: BorderRadius.circular(14),
// //                               boxShadow: [
// //                                 BoxShadow(
// //                                   color:
// //                                   feature.gradient.last.withOpacity(0.35),
// //                                   blurRadius: 12,
// //                                   offset: const Offset(0, 5),
// //                                 ),
// //                               ],
// //                             ),
// //                             child: Icon(feature.icon,
// //                                 color: Colors.white, size: 22),
// //                           ),
// //                         ),
// //                       ),
// //                       AnimatedContainer(
// //                         duration: const Duration(milliseconds: 250),
// //                         width: 28,
// //                         height: 28,
// //                         margin: EdgeInsets.only(left: active ? 3 : 0),
// //                         decoration: BoxDecoration(
// //                           shape: BoxShape.circle,
// //                           color: active ? kTeal : kCanvas,
// //                         ),
// //                         child: Icon(
// //                           Icons.chevron_right_rounded,
// //                           size: 18,
// //                           color: active ? Colors.white : kMuted,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const Spacer(),
// //                   Text(
// //                     feature.title,
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: const TextStyle(
// //                       color: kHeading,
// //                       fontSize: 14.5,
// //                       fontWeight: FontWeight.w800,
// //                       letterSpacing: -0.2,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 2),
// //                   Text(
// //                     feature.sub,
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: const TextStyle(
// //                       color: kMuted,
// //                       fontSize: 11.5,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class _DrawerItem extends StatelessWidget {
// //   final IconData icon;
// //   final String label;
// //   final VoidCallback onTap;
// //   final bool selected;
// //   final bool danger;
// //
// //   const _DrawerItem({
// //     required this.icon,
// //     required this.label,
// //     required this.onTap,
// //     this.selected = false,
// //     this.danger = false,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final fg = danger ? kDanger : (selected ? kTealDark : kHeading);
// //     final ic = danger ? kDanger : kTeal;
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 2),
// //       child: Material(
// //         color: selected ? kTile : Colors.transparent,
// //         borderRadius: BorderRadius.circular(12),
// //         child: InkWell(
// //           borderRadius: BorderRadius.circular(12),
// //           hoverColor: danger ? const Color(0xFFFDECEB) : kTile,
// //           splashColor: kCyan.withOpacity(0.25),
// //           onTap: onTap,
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //             child: Row(
// //               children: [
// //                 Icon(icon, size: 21, color: ic),
// //                 const SizedBox(width: 14),
// //                 Expanded(
// //                   child: Text(
// //                     label,
// //                     style: TextStyle(
// //                       color: fg,
// //                       fontWeight: FontWeight.w700,
// //                       fontSize: 14.5,
// //                     ),
// //                   ),
// //                 ),
// //                 if (selected)
// //                   Container(
// //                     width: 6,
// //                     height: 6,
// //                     decoration: const BoxDecoration(
// //                       color: kTeal,
// //                       shape: BoxShape.circle,
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // /// Pulsing green dot.
// // class _PulseDot extends StatefulWidget {
// //   const _PulseDot();
// //
// //   @override
// //   State<_PulseDot> createState() => _PulseDotState();
// // }
// //
// // class _PulseDotState extends State<_PulseDot>
// //     with SingleTickerProviderStateMixin {
// //   late final AnimationController _c = AnimationController(
// //     vsync: this,
// //     duration: const Duration(seconds: 2),
// //   )..repeat();
// //
// //   @override
// //   void dispose() {
// //     _c.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: _c,
// //       builder: (context, _) => Container(
// //         width: 8,
// //         height: 8,
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF34D399),
// //           shape: BoxShape.circle,
// //           boxShadow: [
// //             BoxShadow(
// //               color: const Color(0xFF34D399).withOpacity(0.6 * (1 - _c.value)),
// //               blurRadius: 0,
// //               spreadRadius: 8 * _c.value,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // /// Rotating orbit rings around a gradient core.
// // class _HeroArt extends StatefulWidget {
// //   const _HeroArt();
// //
// //   @override
// //   State<_HeroArt> createState() => _HeroArtState();
// // }
// //
// // class _HeroArtState extends State<_HeroArt>
// //     with SingleTickerProviderStateMixin {
// //   late final AnimationController _c = AnimationController(
// //     vsync: this,
// //     duration: const Duration(seconds: 24),
// //   )..repeat();
// //
// //   @override
// //   void dispose() {
// //     _c.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       width: 92,
// //       height: 92,
// //       child: AnimatedBuilder(
// //         animation: _c,
// //         builder: (context, _) {
// //           final bob = math.sin(_c.value * 2 * math.pi * 6) * 3;
// //           return Stack(
// //             alignment: Alignment.center,
// //             children: [
// //               Transform.rotate(
// //                 angle: _c.value * 2 * math.pi,
// //                 child: CustomPaint(
// //                   size: const Size(92, 92),
// //                   painter: _RingPainter(kCyan.withOpacity(0.55)),
// //                 ),
// //               ),
// //               Transform.rotate(
// //                 angle: -_c.value * 2 * math.pi * 1.4,
// //                 child: CustomPaint(
// //                   size: const Size(64, 64),
// //                   painter: _RingPainter(Colors.white.withOpacity(0.35)),
// //                 ),
// //               ),
// //               Transform.translate(
// //                 offset: Offset(0, bob),
// //                 child: Transform.rotate(
// //                   angle: -0.1,
// //                   child: Container(
// //                     width: 40,
// //                     height: 40,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(12),
// //                       gradient: const LinearGradient(
// //                         colors: [kCyan, kTeal],
// //                         begin: Alignment.topLeft,
// //                         end: Alignment.bottomRight,
// //                       ),
// //                       boxShadow: const [
// //                         BoxShadow(
// //                           color: Color(0x4D000000),
// //                           blurRadius: 14,
// //                           offset: Offset(0, 6),
// //                         ),
// //                       ],
// //                     ),
// //                     child: const Icon(Icons.school_rounded,
// //                         color: kDeep, size: 23),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// // class _RingPainter extends CustomPainter {
// //   final Color color;
// //   _RingPainter(this.color);
// //
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()
// //       ..color = color
// //       ..style = PaintingStyle.stroke
// //       ..strokeWidth = 1.6
// //       ..strokeCap = StrokeCap.round;
// //     final rect = Rect.fromLTWH(1, 1, size.width - 2, size.height - 2);
// //     const n = 18;
// //     const sweep = 2 * math.pi / n;
// //     for (var i = 0; i < n; i++) {
// //       canvas.drawArc(rect, i * sweep, sweep * 0.55, false, paint);
// //     }
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant _RingPainter old) => old.color != color;
// // }
// //
// // class _DotsPainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final p = Paint()..color = Colors.white.withOpacity(0.09);
// //     for (double x = 12; x < size.width; x += 24) {
// //       for (double y = 12; y < size.height; y += 24) {
// //         canvas.drawCircle(Offset(x, y), 1, p);
// //       }
// //     }
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant CustomPainter old) => false;
// // }
// //
// // /// Staggered fade + slide-up entrance.
// // class _FadeSlide extends StatelessWidget {
// //   final int index;
// //   final Widget child;
// //   const _FadeSlide({required this.index, required this.child});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final ms = 420 + (index * 70).clamp(0, 420);
// //     return TweenAnimationBuilder<double>(
// //       tween: Tween(begin: 0, end: 1),
// //       duration: Duration(milliseconds: ms),
// //       curve: Curves.easeOutCubic,
// //       builder: (context, v, child) => Opacity(
// //         opacity: v,
// //         child: Transform.translate(
// //           offset: Offset(0, 22 * (1 - v)),
// //           child: child,
// //         ),
// //       ),
// //       child: child,
// //     );
// //   }
// // }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:labtrackapp/change_password.dart';
// // import 'package:labtrackapp/complaints.dart';
// // import 'package:labtrackapp/view_comp.dart';
// // import 'package:labtrackapp/view_equipments.dart';
// // import 'package:labtrackapp/view_feedback.dart';
// // import 'package:labtrackapp/view_fines.dart';
// // import 'package:labtrackapp/view_labs.dart';
// // import 'package:labtrackapp/view_ntfcns.dart';
// // import 'package:labtrackapp/view_profile.dart';
// // import 'package:labtrackapp/view_references.dart';
// // import 'package:labtrackapp/view_staffs.dart';
// // import 'package:labtrackapp/view_subjects.dart';
// // import 'package:labtrackapp/view_submissions.dart';
// // import 'login.dart';
// //
// //
// // void main() {
// //   runApp(const MaterialApp(
// //     debugShowCheckedModeBanner: false,
// //     home: StudentHomePage(),
// //   ));
// // }
// //
// // class StudentHomePage extends StatefulWidget {
// //   const StudentHomePage({super.key});
// //
// //   @override
// //   State<StudentHomePage> createState() => _StudentHomePageState();
// // }
// //
// // class _StudentHomePageState extends State<StudentHomePage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         iconTheme: const IconThemeData(color: Colors.black87),
// //       ),
// //       backgroundColor: const Color(0xFFF5F6FA),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Row(
// //               children: [
// //                 CircleAvatar(
// //                   backgroundColor: Colors.deepPurple,
// //                   radius: 25,
// //                   child: Icon(
// //                     Icons.school,
// //                     color: Colors.white,
// //                     size: 30,
// //                   ),
// //                 ),
// //                 SizedBox(width: 12),
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       'Hi Student,',
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     Text(
// //                       'Welcome to LabTrack',
// //                       style: TextStyle(color: Colors.black54),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 30),
// //             Container(
// //               padding: const EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               child: const Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text('LabTrack'),
// //                       SizedBox(height: 6),
// //                       Text(
// //                         'Student Portal',
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   Icon(
// //                     Icons.science,
// //                     size: 45,
// //                     color: Colors.deepPurple,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 25),
// //             const Text(
// //               'Student Functions',
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //             const SizedBox(height: 15),
// //             Expanded(
// //               child: GridView.count(
// //                 crossAxisCount: 2,
// //                 crossAxisSpacing: 15,
// //                 mainAxisSpacing: 15,
// //                 children: [
// //                   ActionCard(
// //                     title: 'View Profile',
// //                     color: Colors.blue,
// //                     icon: Icons.person,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => ViewProfilePage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'View Labs',
// //                     color: Colors.orange,
// //                     icon: Icons.lock,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => ViewLabsPage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   // ActionCard(
// //                   //   title: 'Lab Coordinator',
// //                   //   color: Colors.teal,
// //                   //   icon: Icons.supervisor_account,
// //                   //   onTap: () {
// //                   //     // Navigator.push(
// //                   //     //   context,
// //                   //       // MaterialPageRoute(
// //                   //       //   builder: (context) =>
// //                   //       //       ViewLabCoordinator(title: ''),
// //                   //       // ),
// //                   //     );
// //                   //   },
// //                   // ),
// //                   // ActionCard(
// //                   //   title: 'Lab Instructions',
// //                   //   color: Colors.deepPurple,
// //                   //   icon: Icons.menu_book,
// //                   //   onTap: () {
// //                   //     Navigator.push(
// //                   //       context,
// //                   //       // MaterialPageRoute(
// //                   //       //   builder: (context) =>
// //                   //       //       ViewLabInstructions(title: ''),
// //                   //       // ),
// //                   //     );
// //                   //   },
// //                   // ),
// //                   // ActionCard(
// //                   //   title: 'Upload Lab Work',
// //                   //   color: Colors.green,
// //                   //   icon: Icons.upload_file,
// //                   //   // onTap: () {
// //                   //   //   Navigator.push(
// //                   //   //     context,
// //                   //   //     // MaterialPageRoute(
// //                   //   //     //   builder: (context) => UploadLabWork(title: ''),
// //                   //   //     // ),
// //                   //   //   );
// //                   //   // },
// //                   // ),
// //                   ActionCard(
// //                     title: 'View Lab Equipments',
// //                     color: Colors.indigo,
// //                     icon: Icons.computer,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => ViewEquipmentPage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Fines',
// //                     color: Colors.red,
// //                     icon: Icons.money_off,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => ViewMyFinesPage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Subjects & References',
// //                     color: Colors.brown,
// //                     icon: Icons.history,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) =>
// //                               ViewSubjectsPage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Grade & Submissions',
// //                     color: Colors.pink,
// //                     icon: Icons.grade,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => ViewLabSubmissionsPage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Chat with Staff',
// //                     color: Colors.deepOrange,
// //                     icon: Icons.password_rounded,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => ViewDepartmentStaffPage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Notifications',
// //                     color: Colors.cyan,
// //                     icon: Icons.notification_add,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) =>
// //                               ViewNotificationsPage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //
// //                   ActionCard(
// //                     title: 'Complaint & Reply',
// //                     color: Colors.cyan,
// //                     icon: Icons.mark_chat_read,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) =>
// //                               ViewComplaintPage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Send Feedback',
// //                     color: Colors.purple,
// //                     icon: Icons.feedback,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => ViewFeedbackPage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Change Password',
// //                     color: Colors.deepOrange,
// //                     icon: Icons.password_rounded,
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => ChangePasswordPage(),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                   ActionCard(
// //                     title: 'Logout',
// //                     color: Colors.grey,
// //                     icon: Icons.logout,
// //                     onTap: () {
// //                       Navigator.pushReplacement(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => MyLoginPage(title: ''),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class ActionCard extends StatelessWidget {
// //   final String title;
// //   final Color color;
// //   final IconData icon;
// //   final VoidCallback? onTap;
// //
// //   const ActionCard({
// //     super.key,
// //     required this.title,
// //     required this.color,
// //     required this.icon,
// //     this.onTap,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.all(16),
// //         decoration: BoxDecoration(
// //           color: color.withOpacity(0.1),
// //           borderRadius: BorderRadius.circular(20),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             CircleAvatar(
// //               backgroundColor: color,
// //               child: Icon(icon, color: Colors.white),
// //             ),
// //             const SizedBox(height: 10),
// //             Text(
// //               title,
// //               style: const TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 16,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
// // ##################previous##################
// import 'dart:convert';
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:labtrackapp/change_password.dart';
// import 'package:labtrackapp/complaints.dart';
// import 'package:labtrackapp/view_comp.dart';
// import 'package:labtrackapp/view_equipments.dart';
// import 'package:labtrackapp/view_feedback.dart';
// import 'package:labtrackapp/view_fines.dart';
// import 'package:labtrackapp/view_labs.dart';
// import 'package:labtrackapp/view_ntfcns.dart';
// import 'package:labtrackapp/view_profile.dart';
// import 'package:labtrackapp/view_references.dart';
// import 'package:labtrackapp/view_staffs.dart';
// import 'package:labtrackapp/view_subjects.dart';
// import 'package:labtrackapp/view_submissions.dart';
// import 'login.dart';
// import 'package:labtrackapp/home.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: StudentHomePage(),
//   ));
// }
//
// // ═════════════════════════ THEME ═════════════════════════
// const Color kTop = Color(0xFF164A63);
// const Color kMid = Color(0xFF0D3048);
// const Color kDeep = Color(0xFF08203A);
// const Color kCyan = Color(0xFF5CD0EE);
// const Color kTeal = Color(0xFF0B84A8);
// const Color kTealDark = Color(0xFF086A89);
// const Color kHeading = Color(0xFF0D2B3E);
// const Color kMuted = Color(0xFF5D7183);
// const Color kCanvas = Color(0xFFF1F6FB);
// const Color kBorder = Color(0xFFDAE6F1);
// const Color kTile = Color(0xFFE2F4FA);
// const Color kDanger = Color(0xFFC0291F);
//
// const gBlue = [Color(0xFF38BDF8), Color(0xFF0B84A8)];
// const gViolet = [Color(0xFFA78BFA), Color(0xFF6D4FD6)];
// const gGreen = [Color(0xFF34D399), Color(0xFF1C7C54)];
// const gAmber = [Color(0xFFFBBF24), Color(0xFFE08A0B)];
// const gRose = [Color(0xFFFB7185), Color(0xFFC0291F)];
// const gTeal = [Color(0xFF2DD4BF), Color(0xFF0B7F86)];
//
// class Feature {
//   final String title;
//   final String sub;
//   final IconData icon;
//   final List<Color> gradient;
//   final WidgetBuilder page;
//
//   const Feature({
//     required this.title,
//     required this.sub,
//     required this.icon,
//     required this.gradient,
//     required this.page,
//   });
// }
//
// class StudentHomePage extends StatefulWidget {
//   const StudentHomePage({super.key});
//
//   @override
//   State<StudentHomePage> createState() => _StudentHomePageState();
// }
//
// class _StudentHomePageState extends State<StudentHomePage> {
//   // Profile picture shown on the round icon in the app bar
//   String _photo = '';
//   String _name = '';
//   bool _avatarFetching = false; // blocks overlapping requests
//
//   @override
//   void initState() {
//     super.initState();
//     _loadAvatar();
//   }
//
//   // ── Lab work ──
//   late final Feature labs = Feature(
//     title: 'My Labs',
//     sub: 'Coordinator & schedule',
//     icon: Icons.science_rounded,
//     gradient: gGreen,
//     page: (c) => ViewLabsPage(),
//   );
//   late final Feature subjects = Feature(
//     title: 'Subjects & References',
//     sub: 'Lab instructions',
//     icon: Icons.menu_book_rounded,
//     gradient: gTeal,
//     page: (c) => ViewSubjectsPage(),
//   );
//   late final Feature submissions = Feature(
//     title: 'Grade & Submissions',
//     sub: 'Upload, edit, results',
//     icon: Icons.cloud_upload_rounded,
//     gradient: gAmber,
//     page: (c) => ViewLabSubmissionsPage(),
//   );
//   late final Feature equipments = Feature(
//     title: 'Lab Equipments',
//     sub: 'Assigned items & status',
//     icon: Icons.memory_rounded,
//     gradient: gViolet,
//     page: (c) => ViewEquipmentPage(),
//   );
//   late final Feature fines = Feature(
//     title: 'Fines',
//     sub: 'Damage & loss penalties',
//     icon: Icons.receipt_long_rounded,
//     gradient: gRose,
//     page: (c) => ViewMyFinesPage(),
//   );
//
//   // ── Support ──
//   late final Feature chat = Feature(
//     title: 'Chat with Staff',
//     sub: 'Ask your doubts',
//     icon: Icons.forum_rounded,
//     gradient: gBlue,
//     page: (c) => ViewDepartmentStaffPage(),
//   );
//   late final Feature notifications = Feature(
//     title: 'Notifications',
//     sub: 'Instructions & alerts',
//     icon: Icons.notifications_active_rounded,
//     gradient: gAmber,
//     page: (c) => ViewNotificationsPage(),
//   );
//   late final Feature complaints = Feature(
//     title: 'Complaint & Reply',
//     sub: 'Raise issues, get replies',
//     icon: Icons.support_agent_rounded,
//     gradient: gTeal,
//     page: (c) => ViewComplaintPage(),
//   );
//   late final Feature feedback = Feature(
//     title: 'Send Feedback',
//     sub: 'Help us improve',
//     icon: Icons.rate_review_rounded,
//     gradient: gViolet,
//     page: (c) => ViewFeedbackPage(),
//   );
//
//   // ── Account (shown in drawer) ──
//   late final Feature profile = Feature(
//     title: 'View Profile',
//     sub: 'Your details',
//     icon: Icons.person_rounded,
//     gradient: gBlue,
//     page: (c) => ViewProfilePage(),
//   );
//   late final Feature password = Feature(
//     title: 'Change Password',
//     sub: 'Keep account secure',
//     icon: Icons.lock_rounded,
//     gradient: gAmber,
//     page: (c) => ChangePasswordPage(),
//   );
//
//   // ───────── Profile picture (app bar icon) ─────────
//   String _clean(dynamic v) {
//     final s = (v ?? '').toString().trim();
//     final l = s.toLowerCase();
//     return (s.isEmpty || l == 'null' || l == 'none') ? '' : s;
//   }
//
//   Uri? get _photoUri {
//     final uri = Uri.tryParse(_photo.trim());
//     if (uri == null || uri.host.isEmpty) return null;
//     if (uri.scheme != 'http' && uri.scheme != 'https') return null;
//     return uri;
//   }
//
//   Future<void> _loadAvatar() async {
//     if (_avatarFetching) return;
//     _avatarFetching = true;
//
//     try {
//       final sh = await SharedPreferences.getInstance();
//       String url = (sh.getString('url') ?? '').trim();
//       final lid = (sh.getString('lid') ?? '').trim();
//
//       if (url.isEmpty || lid.isEmpty) return;
//
//       while (url.endsWith('/')) {
//         url = url.substring(0, url.length - 1);
//       }
//
//       final response = await http.post(
//         Uri.parse('$url/flutter_view_profile/'),
//         body: {'lid': lid},
//       ).timeout(const Duration(seconds: 15));
//
//       if (response.statusCode != 200) return;
//
//       final data = jsonDecode(response.body);
//
//       if (!mounted) return;
//
//       if (data is Map && data['status'].toString() == 'ok') {
//         setState(() {
//           _photo = _clean(data['photo']);
//           _name = _clean(data['name']);
//         });
//       }
//     } catch (_) {
//       // The home page stays quiet; the icon simply keeps showing the letter
//     } finally {
//       _avatarFetching = false;
//     }
//   }
//
//   Widget _profileAvatar() {
//     final initial = _name.isEmpty ? 'S' : _name[0].toUpperCase();
//     final fallback = Center(
//       child: Text(
//         initial,
//         style: const TextStyle(
//             color: kDeep, fontWeight: FontWeight.w800, fontSize: 14),
//       ),
//     );
//     final uri = _photoUri;
//
//     return Container(
//       width: 36,
//       height: 36,
//       padding: const EdgeInsets.all(2),
//       decoration: const BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: LinearGradient(
//           colors: [kCyan, kTeal],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: ClipOval(
//         child: Container(
//           color: uri == null ? kCyan : kTile,
//           child: uri == null
//               ? fallback
//               : Image.network(
//             uri.toString(),
//             fit: BoxFit.cover,
//             gaplessPlayback: true,
//             loadingBuilder: (context, child, progress) {
//               if (progress == null) return child;
//               return const Center(
//                 child: SizedBox(
//                   width: 14,
//                   height: 14,
//                   child: CircularProgressIndicator(
//                       strokeWidth: 2, color: kTeal),
//                 ),
//               );
//             },
//             errorBuilder: (context, error, stack) => Container(
//               color: kCyan,
//               child: fallback,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _open(Feature f) {
//     Navigator.push(context, MaterialPageRoute(builder: f.page)).then((_) {
//       // Refresh the picture when coming back from the profile page
//       if (identical(f, profile) && mounted) _loadAvatar();
//     });
//   }
//
//   Future<void> _confirmLogout() async {
//     final ok = await showDialog<bool>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text(
//           'Log out of LabTrack?',
//           style: TextStyle(
//               color: kHeading, fontWeight: FontWeight.w800, fontSize: 19),
//         ),
//         content: const Text(
//           'You will need to sign in again to use the student portal.',
//           style: TextStyle(color: kMuted, height: 1.5),
//         ),
//         actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, false),
//             child: const Text('Stay signed in',
//                 style: TextStyle(color: kHeading, fontWeight: FontWeight.w700)),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: kTeal,
//               foregroundColor: Colors.white,
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(11)),
//             ),
//             onPressed: () => Navigator.pop(ctx, true),
//             child: const Text('Log out',
//                 style: TextStyle(fontWeight: FontWeight.w700)),
//           ),
//         ],
//       ),
//     );
//     if (ok == true && mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => MyLoginPage(title: '')),
//       );
//     }
//   }
//
//   String get _greeting {
//     final h = DateTime.now().hour;
//     if (h < 12) return 'Good morning';
//     if (h < 17) return 'Good afternoon';
//     return 'Good evening';
//   }
//
//   String get _today {
//     const days = [
//       'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
//     ];
//     const months = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     final n = DateTime.now();
//     return '${days[n.weekday - 1]}, ${n.day} ${months[n.month - 1]} ${n.year}';
//   }
//
//   // ═════════════════════════ BUILD ═════════════════════════
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kCanvas,
//       appBar: _appBar(),
//       drawer: _drawer(),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _hero(),
//             _group('Lab Work', Icons.science_rounded,
//                 [labs, subjects, submissions, equipments, fines]),
//             _group('Support & Communication', Icons.forum_rounded,
//                 [chat, notifications, complaints, feedback]),
//             const SizedBox(height: 22),
//             const Center(
//               child: Text(
//                 '© LabTrack · Student Panel',
//                 style: TextStyle(color: Color(0xFF8196A8), fontSize: 12),
//               ),
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ═════════════════════════ APP BAR ═════════════════════════
//   PreferredSizeWidget _appBar() {
//     return AppBar(
//       toolbarHeight: 60,
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       iconTheme: const IconThemeData(color: Colors.white),
//       titleSpacing: 0,
//       flexibleSpace: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [kTop, kMid, kDeep],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//       ),
//       title: Row(
//         children: [
//           Container(
//             width: 34,
//             height: 34,
//             decoration: BoxDecoration(
//               color: kCyan,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(Icons.biotech_rounded, color: kDeep, size: 21),
//           ),
//           const SizedBox(width: 10),
//           const Text(
//             'LabTrack',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w800,
//               fontSize: 19,
//               letterSpacing: -0.3,
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         IconButton(
//           tooltip: 'Notifications',
//           hoverColor: Colors.white24,
//           icon: const Icon(Icons.notifications_rounded),
//           onPressed: () => _open(notifications),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 14, left: 2),
//           child: InkWell(
//             customBorder: const CircleBorder(),
//             hoverColor: Colors.white24,
//             onTap: () => _open(profile),
//             child: _profileAvatar(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ═════════════════════════ DRAWER ═════════════════════════
//   Drawer _drawer() {
//     void go(Feature f) {
//       Navigator.pop(context);
//       _open(f);
//     }
//
//     return Drawer(
//       backgroundColor: kCanvas,
//       width: 300,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(26),
//           bottomRight: Radius.circular(26),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.fromLTRB(
//                 20, MediaQuery.of(context).padding.top + 22, 20, 20),
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [kTop, kDeep],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.only(topRight: Radius.circular(26)),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: kCyan,
//                   ),
//                   child: const CircleAvatar(
//                     radius: 28,
//                     backgroundColor: kMid,
//                     child:
//                     Icon(Icons.school_rounded, color: Colors.white, size: 28),
//                   ),
//                 ),
//                 const SizedBox(width: 14),
//                 const Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hi Student',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Text(
//                         'LabTrack Student Portal',
//                         style:
//                         TextStyle(color: Color(0xFFB9D3E3), fontSize: 12.5),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
//               physics: const BouncingScrollPhysics(),
//               children: [
//                 // ── Account items first ──
//                 _drawerLabel('ACCOUNT'),
//                 _DrawerItem(
//                   icon: profile.icon,
//                   label: profile.title,
//                   onTap: () => go(profile),
//                 ),
//                 _DrawerItem(
//                   icon: password.icon,
//                   label: password.title,
//                   onTap: () => go(password),
//                 ),
//                 const Divider(height: 22, color: kBorder),
//                 _DrawerItem(
//                   icon: Icons.home_rounded,
//                   label: 'Home',
//                   selected: true,
//                   onTap: () => Navigator.pop(context),
//                 ),
//                 _drawerLabel('LAB WORK'),
//                 for (final f in [labs, subjects, submissions, equipments, fines])
//                   _DrawerItem(
//                     icon: f.icon,
//                     label: f.title,
//                     onTap: () => go(f),
//                   ),
//                 _drawerLabel('SUPPORT'),
//                 for (final f in [chat, notifications, complaints, feedback])
//                   _DrawerItem(
//                     icon: f.icon,
//                     label: f.title,
//                     onTap: () => go(f),
//                   ),
//               ],
//             ),
//           ),
//           // logout pinned at bottom
//           Container(
//             padding: EdgeInsets.fromLTRB(
//                 12, 8, 12, MediaQuery.of(context).padding.bottom + 12),
//             decoration: const BoxDecoration(
//               border: Border(top: BorderSide(color: kBorder)),
//             ),
//             child: _DrawerItem(
//               icon: Icons.logout_rounded,
//               label: 'Logout',
//               danger: true,
//               onTap: () {
//                 Navigator.pop(context);
//                 _confirmLogout();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _drawerLabel(String t) => Padding(
//     padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
//     child: Text(
//       t,
//       style: const TextStyle(
//         color: kMuted,
//         fontSize: 11,
//         fontWeight: FontWeight.w800,
//         letterSpacing: 1.4,
//       ),
//     ),
//   );
//
//   // ═════════════════════════ COMPACT HERO ═════════════════════════
//   Widget _hero() {
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [kTop, kDeep],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(28),
//           bottomRight: Radius.circular(28),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0x3308203A),
//             blurRadius: 24,
//             offset: Offset(0, 12),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(28),
//           bottomRight: Radius.circular(28),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               right: -50,
//               top: -70,
//               child: Container(
//                 width: 230,
//                 height: 230,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: RadialGradient(
//                     colors: [kCyan.withOpacity(0.32), kCyan.withOpacity(0)],
//                   ),
//                 ),
//               ),
//             ),
//             Positioned.fill(child: CustomPaint(painter: _DotsPainter())),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 16, 14, 22),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.12),
//                             borderRadius: BorderRadius.circular(30),
//                             border: Border.all(
//                                 color: Colors.white.withOpacity(0.22)),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const _PulseDot(),
//                               const SizedBox(width: 8),
//                               Text(
//                                 _today,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 11.5,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           '$_greeting 👋',
//                           style: const TextStyle(
//                             color: kCyan,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         const Text(
//                           'Your LabTrack\nStudent Desk',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.w800,
//                             height: 1.15,
//                             letterSpacing: -0.5,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Lab notebooks, equipment, fines & staff chat.',
//                           style: TextStyle(
//                             color: Color(0xFFB9D3E3),
//                             fontSize: 12.5,
//                             height: 1.4,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const _HeroArt(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ═════════════════════════ CARD GROUP ═════════════════════════
//   Widget _group(String title, IconData icon, List<Feature> items) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(7),
//                 decoration: BoxDecoration(
//                   color: kTile,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(icon, size: 17, color: kTeal),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   color: kHeading,
//                   fontSize: 17,
//                   fontWeight: FontWeight.w800,
//                   letterSpacing: -0.3,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           LayoutBuilder(
//             builder: (context, c) {
//               final cols = c.maxWidth >= 980 ? 4 : (c.maxWidth >= 620 ? 3 : 2);
//               const gap = 12.0;
//               final w = (c.maxWidth - gap * (cols - 1)) / cols;
//               return Wrap(
//                 spacing: gap,
//                 runSpacing: gap,
//                 children: [
//                   for (var i = 0; i < items.length; i++)
//                     SizedBox(
//                       width: w,
//                       height: 128,
//                       child: _FadeSlide(
//                         index: i,
//                         child: _FeatureCard(
//                           feature: items[i],
//                           onTap: () => _open(items[i]),
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ═════════════════════════ WIDGETS ═════════════════════════
//
// /// Hover (desktop/web) + press (touch) wrapper.
// class _Hover extends StatefulWidget {
//   final Widget Function(bool hover, bool pressed) builder;
//   final VoidCallback? onTap;
//   final double lift;
//   final double pressScale;
//
//   const _Hover({
//     required this.builder,
//     this.onTap,
//     this.lift = 5,
//     this.pressScale = 0.96,
//   });
//
//   @override
//   State<_Hover> createState() => _HoverState();
// }
//
// class _HoverState extends State<_Hover> {
//   bool _hover = false;
//   bool _pressed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final dy = (_hover && !_pressed) ? -widget.lift : 0.0;
//     final s = _pressed ? widget.pressScale : 1.0;
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) => setState(() => _hover = true),
//       onExit: (_) => setState(() => _hover = false),
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTapDown: (_) => setState(() => _pressed = true),
//         onTapCancel: () => setState(() => _pressed = false),
//         onTapUp: (_) => setState(() => _pressed = false),
//         onTap: widget.onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 220),
//           curve: Curves.easeOut,
//           transformAlignment: Alignment.center,
//           transform: Matrix4.translationValues(0, dy, 0)..scale(s),
//           child: widget.builder(_hover || _pressed, _pressed),
//         ),
//       ),
//     );
//   }
// }
//
// /// Compact card used in the grid.
// class _FeatureCard extends StatelessWidget {
//   final Feature feature;
//   final VoidCallback onTap;
//   const _FeatureCard({required this.feature, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return _Hover(
//       onTap: onTap,
//       builder: (active, pressed) => AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         clipBehavior: Clip.antiAlias,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: active ? kTeal : kBorder, width: 1.2),
//           boxShadow: [
//             BoxShadow(
//               color: active
//                   ? const Color(0x2E0B5478)
//                   : const Color(0x0F08203A),
//               blurRadius: active ? 24 : 10,
//               offset: Offset(0, active ? 12 : 5),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             // accent bar
//             Positioned(
//               left: 0,
//               right: 0,
//               top: 0,
//               height: 3.5,
//               child: AnimatedFractionallySizedBox(
//                 duration: const Duration(milliseconds: 350),
//                 curve: Curves.easeOut,
//                 alignment: Alignment.centerLeft,
//                 widthFactor: active ? 1 : 0,
//                 heightFactor: 1,
//                 child: const DecoratedBox(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(colors: [kCyan, kTeal]),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       AnimatedRotation(
//                         turns: active ? -0.022 : 0,
//                         duration: const Duration(milliseconds: 300),
//                         child: AnimatedScale(
//                           scale: active ? 1.1 : 1,
//                           duration: const Duration(milliseconds: 300),
//                           child: Container(
//                             width: 44,
//                             height: 44,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: feature.gradient,
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                               borderRadius: BorderRadius.circular(14),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color:
//                                   feature.gradient.last.withOpacity(0.35),
//                                   blurRadius: 12,
//                                   offset: const Offset(0, 5),
//                                 ),
//                               ],
//                             ),
//                             child: Icon(feature.icon,
//                                 color: Colors.white, size: 22),
//                           ),
//                         ),
//                       ),
//                       AnimatedContainer(
//                         duration: const Duration(milliseconds: 250),
//                         width: 28,
//                         height: 28,
//                         margin: EdgeInsets.only(left: active ? 3 : 0),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: active ? kTeal : kCanvas,
//                         ),
//                         child: Icon(
//                           Icons.chevron_right_rounded,
//                           size: 18,
//                           color: active ? Colors.white : kMuted,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   Text(
//                     feature.title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: kHeading,
//                       fontSize: 14.5,
//                       fontWeight: FontWeight.w800,
//                       letterSpacing: -0.2,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     feature.sub,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: kMuted,
//                       fontSize: 11.5,
//                       fontWeight: FontWeight.w600,
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
// class _DrawerItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//   final bool selected;
//   final bool danger;
//
//   const _DrawerItem({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//     this.selected = false,
//     this.danger = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final fg = danger ? kDanger : (selected ? kTealDark : kHeading);
//     final ic = danger ? kDanger : kTeal;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Material(
//         color: selected ? kTile : Colors.transparent,
//         borderRadius: BorderRadius.circular(12),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12),
//           hoverColor: danger ? const Color(0xFFFDECEB) : kTile,
//           splashColor: kCyan.withOpacity(0.25),
//           onTap: onTap,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//             child: Row(
//               children: [
//                 Icon(icon, size: 21, color: ic),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: Text(
//                     label,
//                     style: TextStyle(
//                       color: fg,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 14.5,
//                     ),
//                   ),
//                 ),
//                 if (selected)
//                   Container(
//                     width: 6,
//                     height: 6,
//                     decoration: const BoxDecoration(
//                       color: kTeal,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// Pulsing green dot.
// class _PulseDot extends StatefulWidget {
//   const _PulseDot();
//
//   @override
//   State<_PulseDot> createState() => _PulseDotState();
// }
//
// class _PulseDotState extends State<_PulseDot>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _c = AnimationController(
//     vsync: this,
//     duration: const Duration(seconds: 2),
//   )..repeat();
//
//   @override
//   void dispose() {
//     _c.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _c,
//       builder: (context, _) => Container(
//         width: 8,
//         height: 8,
//         decoration: BoxDecoration(
//           color: const Color(0xFF34D399),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF34D399).withOpacity(0.6 * (1 - _c.value)),
//               blurRadius: 0,
//               spreadRadius: 8 * _c.value,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// Rotating orbit rings around a gradient core.
// class _HeroArt extends StatefulWidget {
//   const _HeroArt();
//
//   @override
//   State<_HeroArt> createState() => _HeroArtState();
// }
//
// class _HeroArtState extends State<_HeroArt>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _c = AnimationController(
//     vsync: this,
//     duration: const Duration(seconds: 24),
//   )..repeat();
//
//   @override
//   void dispose() {
//     _c.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 92,
//       height: 92,
//       child: AnimatedBuilder(
//         animation: _c,
//         builder: (context, _) {
//           final bob = math.sin(_c.value * 2 * math.pi * 6) * 3;
//           return Stack(
//             alignment: Alignment.center,
//             children: [
//               Transform.rotate(
//                 angle: _c.value * 2 * math.pi,
//                 child: CustomPaint(
//                   size: const Size(92, 92),
//                   painter: _RingPainter(kCyan.withOpacity(0.55)),
//                 ),
//               ),
//               Transform.rotate(
//                 angle: -_c.value * 2 * math.pi * 1.4,
//                 child: CustomPaint(
//                   size: const Size(64, 64),
//                   painter: _RingPainter(Colors.white.withOpacity(0.35)),
//                 ),
//               ),
//               Transform.translate(
//                 offset: Offset(0, bob),
//                 child: Transform.rotate(
//                   angle: -0.1,
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       gradient: const LinearGradient(
//                         colors: [kCyan, kTeal],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color(0x4D000000),
//                           blurRadius: 14,
//                           offset: Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(Icons.school_rounded,
//                         color: kDeep, size: 23),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _RingPainter extends CustomPainter {
//   final Color color;
//   _RingPainter(this.color);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.6
//       ..strokeCap = StrokeCap.round;
//     final rect = Rect.fromLTWH(1, 1, size.width - 2, size.height - 2);
//     const n = 18;
//     const sweep = 2 * math.pi / n;
//     for (var i = 0; i < n; i++) {
//       canvas.drawArc(rect, i * sweep, sweep * 0.55, false, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _RingPainter old) => old.color != color;
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
// /// Staggered fade + slide-up entrance.
// class _FadeSlide extends StatelessWidget {
//   final int index;
//   final Widget child;
//   const _FadeSlide({required this.index, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     final ms = 420 + (index * 70).clamp(0, 420);
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0, end: 1),
//       duration: Duration(milliseconds: ms),
//       curve: Curves.easeOutCubic,
//       builder: (context, v, child) => Opacity(
//         opacity: v,
//         child: Transform.translate(
//           offset: Offset(0, 22 * (1 - v)),
//           child: child,
//         ),
//       ),
//       child: child,
//     );
//   }
// }












import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labtrackapp/labschedule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:labtrackapp/change_password.dart';
import 'package:labtrackapp/complaints.dart';
import 'package:labtrackapp/view_comp.dart';
import 'package:labtrackapp/view_equipments.dart';
import 'package:labtrackapp/view_feedback.dart';
import 'package:labtrackapp/view_fines.dart';
import 'package:labtrackapp/view_labs.dart';

import 'package:labtrackapp/view_ntfcns.dart';
import 'package:labtrackapp/view_profile.dart';
import 'package:labtrackapp/view_references.dart';
import 'package:labtrackapp/view_staffs.dart';
import 'package:labtrackapp/view_subjects.dart';
import 'package:labtrackapp/view_submissions.dart';
import 'login.dart';
import 'package:labtrackapp/home.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StudentHomePage(),
  ));
}

// ═════════════════════════ THEME ═════════════════════════
const Color kTop = Color(0xFF164A63);
const Color kMid = Color(0xFF0D3048);
const Color kDeep = Color(0xFF08203A);
const Color kCyan = Color(0xFF5CD0EE);
const Color kTeal = Color(0xFF0B84A8);
const Color kTealDark = Color(0xFF086A89);
const Color kHeading = Color(0xFF0D2B3E);
const Color kMuted = Color(0xFF5D7183);
const Color kCanvas = Color(0xFFF1F6FB);
const Color kBorder = Color(0xFFDAE6F1);
const Color kTile = Color(0xFFE2F4FA);
const Color kDanger = Color(0xFFC0291F);

const gBlue = [Color(0xFF38BDF8), Color(0xFF0B84A8)];
const gViolet = [Color(0xFFA78BFA), Color(0xFF6D4FD6)];
const gGreen = [Color(0xFF34D399), Color(0xFF1C7C54)];
const gAmber = [Color(0xFFFBBF24), Color(0xFFE08A0B)];
const gRose = [Color(0xFFFB7185), Color(0xFFC0291F)];
const gTeal = [Color(0xFF2DD4BF), Color(0xFF0B7F86)];

class Feature {
  final String title;
  final String sub;
  final IconData icon;
  final List<Color> gradient;
  final WidgetBuilder page;

  const Feature({
    required this.title,
    required this.sub,
    required this.icon,
    required this.gradient,
    required this.page,
  });
}

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  // Profile picture shown on the round icon in the app bar
  String _photo = '';
  String _name = '';
  bool _avatarFetching = false; // blocks overlapping requests

  @override
  void initState() {
    super.initState();
    _loadAvatar();
  }

  // ── Lab work ──
  late final Feature labs = Feature(
    title: 'My Labs',
    sub: 'Coordinator & schedule',
    icon: Icons.science_rounded,
    gradient: gGreen,
    page: (c) => ViewLabsPage(),
  );
  late final Feature timetable = Feature(
    title: 'View Timetable',
    sub: 'Lab schedules & hours',
    icon: Icons.calendar_month_rounded,
    gradient: gBlue,
    page: (c) => const ViewTimetable(),
  );
  late final Feature subjects = Feature(
    title: 'Subjects & References',
    sub: 'Lab instructions',
    icon: Icons.menu_book_rounded,
    gradient: gTeal,
    page: (c) => ViewSubjectsPage(),
  );
  late final Feature submissions = Feature(
    title: 'Grade & Submissions',
    sub: 'Upload, edit, results',
    icon: Icons.cloud_upload_rounded,
    gradient: gAmber,
    page: (c) => ViewLabSubmissionsPage(),
  );
  late final Feature equipments = Feature(
    title: 'Lab Equipments',
    sub: 'Assigned items & status',
    icon: Icons.memory_rounded,
    gradient: gViolet,
    page: (c) => ViewEquipmentPage(),
  );
  late final Feature fines = Feature(
    title: 'Fines',
    sub: 'Damage & loss penalties',
    icon: Icons.receipt_long_rounded,
    gradient: gRose,
    page: (c) => ViewMyFinesPage(),
  );

  // ── Support ──
  late final Feature chat = Feature(
    title: 'Chat with Staff',
    sub: 'Ask your doubts',
    icon: Icons.forum_rounded,
    gradient: gBlue,
    page: (c) => ViewDepartmentStaffPage(),
  );
  late final Feature notifications = Feature(
    title: 'Notifications',
    sub: 'Instructions & alerts',
    icon: Icons.notifications_active_rounded,
    gradient: gAmber,
    page: (c) => ViewNotificationsPage(),
  );
  late final Feature complaints = Feature(
    title: 'Complaint & Reply',
    sub: 'Raise issues, get replies',
    icon: Icons.support_agent_rounded,
    gradient: gTeal,
    page: (c) => ViewComplaintPage(),
  );
  late final Feature feedback = Feature(
    title: 'Send Feedback',
    sub: 'Help us improve',
    icon: Icons.rate_review_rounded,
    gradient: gViolet,
    page: (c) => ViewFeedbackPage(),
  );

  // ── Account (shown in drawer) ──
  late final Feature profile = Feature(
    title: 'View Profile',
    sub: 'Your details',
    icon: Icons.person_rounded,
    gradient: gBlue,
    page: (c) => ViewProfilePage(),
  );
  late final Feature password = Feature(
    title: 'Change Password',
    sub: 'Keep account secure',
    icon: Icons.lock_rounded,
    gradient: gAmber,
    page: (c) => ChangePasswordPage(),
  );

  // ───────── Profile picture (app bar icon) ─────────
  String _clean(dynamic v) {
    final s = (v ?? '').toString().trim();
    final l = s.toLowerCase();
    return (s.isEmpty || l == 'null' || l == 'none') ? '' : s;
  }

  Uri? get _photoUri {
    final uri = Uri.tryParse(_photo.trim());
    if (uri == null || uri.host.isEmpty) return null;
    if (uri.scheme != 'http' && uri.scheme != 'https') return null;
    return uri;
  }

  Future<void> _loadAvatar() async {
    if (_avatarFetching) return;
    _avatarFetching = true;

    try {
      final sh = await SharedPreferences.getInstance();
      String url = (sh.getString('url') ?? '').trim();
      final lid = (sh.getString('lid') ?? '').trim();

      if (url.isEmpty || lid.isEmpty) return;

      while (url.endsWith('/')) {
        url = url.substring(0, url.length - 1);
      }

      final response = await http.post(
        Uri.parse('$url/flutter_view_profile/'),
        body: {'lid': lid},
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) return;

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (data is Map && data['status'].toString() == 'ok') {
        setState(() {
          _photo = _clean(data['photo']);
          _name = _clean(data['name']);
        });
      }
    } catch (_) {
      // The home page stays quiet; the icon simply keeps showing the letter
    } finally {
      _avatarFetching = false;
    }
  }

  Widget _profileAvatar() {
    final initial = _name.isEmpty ? 'S' : _name[0].toUpperCase();
    final fallback = Center(
      child: Text(
        initial,
        style: const TextStyle(
            color: kDeep, fontWeight: FontWeight.w800, fontSize: 14),
      ),
    );
    final uri = _photoUri;

    return Container(
      width: 36,
      height: 36,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [kCyan, kTeal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipOval(
        child: Container(
          color: uri == null ? kCyan : kTile,
          child: uri == null
              ? fallback
              : Image.network(
            uri.toString(),
            fit: BoxFit.cover,
            gaplessPlayback: true,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(
                child: SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: kTeal),
                ),
              );
            },
            errorBuilder: (context, error, stack) => Container(
              color: kCyan,
              child: fallback,
            ),
          ),
        ),
      ),
    );
  }

  void _open(Feature f) {
    Navigator.push(context, MaterialPageRoute(builder: f.page)).then((_) {
      // Refresh the picture when coming back from the profile page
      if (identical(f, profile) && mounted) _loadAvatar();
    });
  }

  Future<void> _confirmLogout() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Log out of LabTrack?',
          style: TextStyle(
              color: kHeading, fontWeight: FontWeight.w800, fontSize: 19),
        ),
        content: const Text(
          'You will need to sign in again to use the student portal.',
          style: TextStyle(color: kMuted, height: 1.5),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Stay signed in',
                style: TextStyle(color: kHeading, fontWeight: FontWeight.w700)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kTeal,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Log out',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (ok == true && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MyLoginPage(title: '')),
      );
    }
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String get _today {
    const days = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
    ];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final n = DateTime.now();
    return '${days[n.weekday - 1]}, ${n.day} ${months[n.month - 1]} ${n.year}';
  }

  // ═════════════════════════ BUILD ═════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCanvas,
      appBar: _appBar(),
      drawer: _drawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _hero(),
            _group('Lab Work', Icons.science_rounded,
                [labs, timetable, subjects, submissions, equipments, fines]),
            _group('Support & Communication', Icons.forum_rounded,
                [chat, notifications, complaints, feedback]),
            const SizedBox(height: 22),
            const Center(
              child: Text(
                '© LabTrack · Student Panel',
                style: TextStyle(color: Color(0xFF8196A8), fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ═════════════════════════ APP BAR ═════════════════════════
  PreferredSizeWidget _appBar() {
    return AppBar(
      toolbarHeight: 60,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleSpacing: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kTop, kMid, kDeep],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: kCyan,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.biotech_rounded, color: kDeep, size: 21),
          ),
          const SizedBox(width: 10),
          const Text(
            'LabTrack',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 19,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Notifications',
          hoverColor: Colors.white24,
          icon: const Icon(Icons.notifications_rounded),
          onPressed: () => _open(notifications),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14, left: 2),
          child: InkWell(
            customBorder: const CircleBorder(),
            hoverColor: Colors.white24,
            onTap: () => _open(profile),
            child: _profileAvatar(),
          ),
        ),
      ],
    );
  }

  // ═════════════════════════ DRAWER ═════════════════════════
  Drawer _drawer() {
    void go(Feature f) {
      Navigator.pop(context);
      _open(f);
    }

    return Drawer(
      backgroundColor: kCanvas,
      width: 300,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).padding.top + 22, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kTop, kDeep],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(topRight: Radius.circular(26)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kCyan,
                  ),
                  child: const CircleAvatar(
                    radius: 28,
                    backgroundColor: kMid,
                    child:
                    Icon(Icons.school_rounded, color: Colors.white, size: 28),
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi Student',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'LabTrack Student Portal',
                        style:
                        TextStyle(color: Color(0xFFB9D3E3), fontSize: 12.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
              physics: const BouncingScrollPhysics(),
              children: [
                // ── Account items first ──
                _drawerLabel('ACCOUNT'),
                _DrawerItem(
                  icon: profile.icon,
                  label: profile.title,
                  onTap: () => go(profile),
                ),
                _DrawerItem(
                  icon: password.icon,
                  label: password.title,
                  onTap: () => go(password),
                ),
                const Divider(height: 22, color: kBorder),
                _DrawerItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  selected: true,
                  onTap: () => Navigator.pop(context),
                ),
                _drawerLabel('LAB WORK'),
                for (final f in [labs, timetable, subjects, submissions, equipments, fines])
                  _DrawerItem(
                    icon: f.icon,
                    label: f.title,
                    onTap: () => go(f),
                  ),
                _drawerLabel('SUPPORT'),
                for (final f in [chat, notifications, complaints, feedback])
                  _DrawerItem(
                    icon: f.icon,
                    label: f.title,
                    onTap: () => go(f),
                  ),
              ],
            ),
          ),
          // logout pinned at bottom
          Container(
            padding: EdgeInsets.fromLTRB(
                12, 8, 12, MediaQuery.of(context).padding.bottom + 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: kBorder)),
            ),
            child: _DrawerItem(
              icon: Icons.logout_rounded,
              label: 'Logout',
              danger: true,
              onTap: () {
                Navigator.pop(context);
                _confirmLogout();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerLabel(String t) => Padding(
    padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
    child: Text(
      t,
      style: const TextStyle(
        color: kMuted,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.4,
      ),
    ),
  );

  // ═════════════════════════ COMPACT HERO ═════════════════════════
  Widget _hero() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kTop, kDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x3308203A),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -50,
              top: -70,
              child: Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [kCyan.withOpacity(0.32), kCyan.withOpacity(0)],
                  ),
                ),
              ),
            ),
            Positioned.fill(child: CustomPaint(painter: _DotsPainter())),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 14, 22),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.22)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const _PulseDot(),
                              const SizedBox(width: 8),
                              Text(
                                _today,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '$_greeting 👋',
                          style: const TextStyle(
                            color: kCyan,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Your LabTrack\nStudent Desk',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Lab notebooks, equipment, fines & staff chat.',
                          style: TextStyle(
                            color: Color(0xFFB9D3E3),
                            fontSize: 12.5,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const _HeroArt(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═════════════════════════ CARD GROUP ═════════════════════════
  Widget _group(String title, IconData icon, List<Feature> items) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: kTile,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 17, color: kTeal),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: kHeading,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 980 ? 4 : (c.maxWidth >= 620 ? 3 : 2);
              const gap = 12.0;
              final w = (c.maxWidth - gap * (cols - 1)) / cols;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < items.length; i++)
                    SizedBox(
                      width: w,
                      height: 128,
                      child: _FadeSlide(
                        index: i,
                        child: _FeatureCard(
                          feature: items[i],
                          onTap: () => _open(items[i]),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════ WIDGETS ═════════════════════════

/// Hover (desktop/web) + press (touch) wrapper.
class _Hover extends StatefulWidget {
  final Widget Function(bool hover, bool pressed) builder;
  final VoidCallback? onTap;
  final double lift;
  final double pressScale;

  const _Hover({
    required this.builder,
    this.onTap,
    this.lift = 5,
    this.pressScale = 0.96,
  });

  @override
  State<_Hover> createState() => _HoverState();
}

class _HoverState extends State<_Hover> {
  bool _hover = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final dy = (_hover && !_pressed) ? -widget.lift : 0.0;
    final s = _pressed ? widget.pressScale : 1.0;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transformAlignment: Alignment.center,
          transform: Matrix4.translationValues(0, dy, 0)..scale(s),
          child: widget.builder(_hover || _pressed, _pressed),
        ),
      ),
    );
  }
}

/// Compact card used in the grid.
class _FeatureCard extends StatelessWidget {
  final Feature feature;
  final VoidCallback onTap;
  const _FeatureCard({required this.feature, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _Hover(
      onTap: onTap,
      builder: (active, pressed) => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: active ? kTeal : kBorder, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: active
                  ? const Color(0x2E0B5478)
                  : const Color(0x0F08203A),
              blurRadius: active ? 24 : 10,
              offset: Offset(0, active ? 12 : 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // accent bar
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 3.5,
              child: AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                alignment: Alignment.centerLeft,
                widthFactor: active ? 1 : 0,
                heightFactor: 1,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [kCyan, kTeal]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedRotation(
                        turns: active ? -0.022 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: AnimatedScale(
                          scale: active ? 1.1 : 1,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: feature.gradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  feature.gradient.last.withOpacity(0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Icon(feature.icon,
                                color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 28,
                        height: 28,
                        margin: EdgeInsets.only(left: active ? 3 : 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: active ? kTeal : kCanvas,
                        ),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: active ? Colors.white : kMuted,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    feature.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: kHeading,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    feature.sub,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: kMuted,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
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

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final bool danger;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final fg = danger ? kDanger : (selected ? kTealDark : kHeading);
    final ic = danger ? kDanger : kTeal;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: selected ? kTile : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          hoverColor: danger ? const Color(0xFFFDECEB) : kTile,
          splashColor: kCyan.withOpacity(0.25),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(icon, size: 21, color: ic),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: fg,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.5,
                    ),
                  ),
                ),
                if (selected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: kTeal,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Pulsing green dot.
class _PulseDot extends StatefulWidget {
  const _PulseDot();

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: const Color(0xFF34D399),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF34D399).withOpacity(0.6 * (1 - _c.value)),
              blurRadius: 0,
              spreadRadius: 8 * _c.value,
            ),
          ],
        ),
      ),
    );
  }
}

/// Rotating orbit rings around a gradient core.
class _HeroArt extends StatefulWidget {
  const _HeroArt();

  @override
  State<_HeroArt> createState() => _HeroArtState();
}

class _HeroArtState extends State<_HeroArt>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 24),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      height: 92,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final bob = math.sin(_c.value * 2 * math.pi * 6) * 3;
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: _c.value * 2 * math.pi,
                child: CustomPaint(
                  size: const Size(92, 92),
                  painter: _RingPainter(kCyan.withOpacity(0.55)),
                ),
              ),
              Transform.rotate(
                angle: -_c.value * 2 * math.pi * 1.4,
                child: CustomPaint(
                  size: const Size(64, 64),
                  painter: _RingPainter(Colors.white.withOpacity(0.35)),
                ),
              ),
              Transform.translate(
                offset: Offset(0, bob),
                child: Transform.rotate(
                  angle: -0.1,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [kCyan, kTeal],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x4D000000),
                          blurRadius: 14,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.school_rounded,
                        color: kDeep, size: 23),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final Color color;
  _RingPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    final rect = Rect.fromLTWH(1, 1, size.width - 2, size.height - 2);
    const n = 18;
    const sweep = 2 * math.pi / n;
    for (var i = 0; i < n; i++) {
      canvas.drawArc(rect, i * sweep, sweep * 0.55, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) => old.color != color;
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

/// Staggered fade + slide-up entrance.
class _FadeSlide extends StatelessWidget {
  final int index;
  final Widget child;
  const _FadeSlide({required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    final ms = 420 + (index * 70).clamp(0, 420);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: ms),
      curve: Curves.easeOutCubic,
      builder: (context, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 22 * (1 - v)),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
