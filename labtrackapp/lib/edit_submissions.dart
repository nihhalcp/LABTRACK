//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';
//
// class EditLabSubmissionPage extends StatefulWidget {
//   final String submissionId;
//   final String description;
//
//   const EditLabSubmissionPage({
//     super.key,
//     required this.submissionId,
//     required this.description,
//   });
//
//   @override
//   State<EditLabSubmissionPage> createState() =>
//       _EditLabSubmissionPageState();
// }
//
// class _EditLabSubmissionPageState extends State<EditLabSubmissionPage> {
//
//   TextEditingController descriptionController = TextEditingController();
//
//   File? selectedFile;
//   String? selectedFileName;
//   bool isSubmitting = false;
//
//   @override
//   void initState() {
//     super.initState();
//     descriptionController.text = widget.description;
//   }
//
//   Future<void> chooseFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         selectedFile = File(result.files.single.path!);
//         selectedFileName = result.files.single.name;
//       });
//     }
//   }
//
//   Future<void> editSubmission() async {
//     if (descriptionController.text.trim().isEmpty) {
//       Fluttertoast.showToast(msg: "Please enter description");
//       return;
//     }
//
//     setState(() {
//       isSubmitting = true;
//     });
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('$url/flutter_edit_lab_submission/'),
//       );
//
//       request.fields['lid'] = lid;
//       request.fields['submission_id'] = widget.submissionId;
//       request.fields['description'] = descriptionController.text;
//
//       if (selectedFile != null) {
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'file',
//             selectedFile!.path,
//           ),
//         );
//       }
//
//       var response = await request.send();
//       var responseData = await response.stream.bytesToString();
//       var data = jsonDecode(responseData);
//
//       if (data['status'] == 'ok') {
//         Fluttertoast.showToast(
//           msg: "Submission updated successfully",
//         );
//
//         if (mounted) {
//           Navigator.pop(context, true);
//         }
//       } else {
//         Fluttertoast.showToast(
//           msg: data['message'] ?? "Update failed",
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error updating submission");
//     }
//
//     if (mounted) {
//       setState(() {
//         isSubmitting = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     descriptionController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Uploaded Exercise"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             const Text("Description"),
//
//             TextField(
//               controller: descriptionController,
//               maxLength: 200,
//               maxLines: 4,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter description",
//               ),
//             ),
//
//             const SizedBox(height: 15),
//
//             ElevatedButton.icon(
//               onPressed: chooseFile,
//               icon: const Icon(Icons.attach_file),
//               label: const Text("Choose Replacement File"),
//             ),
//
//             const SizedBox(height: 10),
//
//             Text(
//               selectedFileName ??
//                   "No new file selected. Current file will be kept.",
//             ),
//
//             const SizedBox(height: 25),
//
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: isSubmitting ? null : editSubmission,
//                 child: Text(
//                   isSubmitting ? "Updating..." : "Update Submission",
//                 ),
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
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

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

class EditLabSubmissionPage extends StatefulWidget {
  final String submissionId;
  final String description;

  const EditLabSubmissionPage({
    super.key,
    required this.submissionId,
    required this.description,
  });

  @override
  State<EditLabSubmissionPage> createState() => _EditLabSubmissionPageState();
}

class _EditLabSubmissionPageState extends State<EditLabSubmissionPage> {
  // ── Limits (change these to match your server rules) ──
  static const int _maxFileMb = 10;
  static const int _minDescLen = 3;
  static const int _maxDescLen = 200;
  static const List<String> _allowedExt = [
    'pdf', 'doc', 'docx', 'txt', 'ppt', 'pptx', 'xls', 'xlsx', 'csv',
    'zip', 'rar', 'png', 'jpg', 'jpeg', 'py', 'java', 'c', 'cpp', 'js',
    'html', 'css', 'sql', 'ipynb',
  ];

  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();

  File? selectedFile;
  String? selectedFileName;
  String? fileError;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.description;
  }

  String? _validateDescription(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return 'Please enter a description';
    if (t.length < _minDescLen) {
      return 'Description must be at least $_minDescLen characters';
    }
    if (t.length > _maxDescLen) {
      return 'Description must be at most $_maxDescLen characters';
    }
    if (!RegExp(r'[A-Za-z0-9]').hasMatch(t)) {
      return 'Description must contain letters or numbers';
    }
    return null;
  }

  /// Returns an error message, or null if the file is fine.
  Future<String?> _validateFile(File file, String name) async {
    if (!await file.exists()) return 'The selected file could not be found';
    final size = await file.length();
    if (size == 0) return 'The selected file is empty';
    if (size > _maxFileMb * 1024 * 1024) {
      return 'File is too large (max $_maxFileMb MB)';
    }
    final dot = name.lastIndexOf('.');
    final ext = dot == -1 ? '' : name.substring(dot + 1).toLowerCase();
    if (ext.isEmpty) return 'The file must have an extension';
    if (!_allowedExt.contains(ext)) {
      return 'Unsupported file type (.$ext)';
    }
    return null;
  }

  Future<void> chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final name = result.files.single.name;
      final err = await _validateFile(file, name);

      if (!mounted) return;
      setState(() {
        fileError = err;
        if (err == null) {
          selectedFile = file;
          selectedFileName = name;
        } else {
          selectedFile = null;
          selectedFileName = null;
        }
      });
    }
  }

  Future<void> editSubmission() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Please fix the highlighted fields");
      return;
    }

    if (fileError != null) {
      Fluttertoast.showToast(msg: fileError!);
      return;
    }

    final newDesc = descriptionController.text.trim();
    if (selectedFile == null && newDesc == widget.description.trim()) {
      Fluttertoast.showToast(msg: "No changes to update");
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();

      String url = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';

      if (url.trim().isEmpty || lid.trim().isEmpty) {
        Fluttertoast.showToast(msg: "Session expired. Please log in again.");
        return;
      }

      if (widget.submissionId.trim().isEmpty) {
        Fluttertoast.showToast(msg: "Invalid submission");
        return;
      }

      if (selectedFile != null) {
        final err = await _validateFile(selectedFile!, selectedFileName ?? '');
        if (err != null) {
          if (mounted) setState(() => fileError = err);
          Fluttertoast.showToast(msg: err);
          return;
        }
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/flutter_edit_lab_submission/'),
      );

      request.fields['lid'] = lid;
      request.fields['submission_id'] = widget.submissionId;
      request.fields['description'] = newDesc;

      if (selectedFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            selectedFile!.path,
          ),
        );
      }

      var response = await request.send().timeout(const Duration(seconds: 60));

      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg: "Server error (${response.statusCode}). Try again.");
        return;
      }

      var responseData = await response.stream.bytesToString();
      var data = jsonDecode(responseData);

      if (data['status'] == 'ok') {
        Fluttertoast.showToast(
          msg: "Submission updated successfully",
        );

        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        Fluttertoast.showToast(
          msg: data['message'] ?? "Update failed",
        );
      }
    } on TimeoutException {
      Fluttertoast.showToast(msg: "Request timed out. Check your connection.");
    } on FormatException {
      Fluttertoast.showToast(msg: "Invalid response from server");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating submission");
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Widget _filePicker() {
    final has = selectedFileName != null;
    final bad = fileError != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: chooseFile,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: has ? _kTile : _kCanvas,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: bad ? _kDanger : (has ? _kTeal : _kBorder),
                  width: 1.2),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: bad
                          ? const [Color(0xFFFB7185), Color(0xFFC0291F)]
                          : (has
                          ? const [Color(0xFF34D399), Color(0xFF1C7C54)]
                          : const [Color(0xFFFBBF24), Color(0xFFE08A0B)]),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    bad
                        ? Icons.error_outline_rounded
                        : (has
                        ? Icons.insert_drive_file_rounded
                        : Icons.attach_file_rounded),
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        has ? selectedFileName! : 'Choose Replacement File',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _kHeading,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        has
                            ? 'Tap to pick a different file'
                            : 'No new file selected. Current file will be kept.',
                        style: const TextStyle(
                          color: _kMuted,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: _kMuted),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, left: 4),
          child: Text(
            bad
                ? fileError!
                : 'Optional · max $_maxFileMb MB · ${_allowedExt.take(6).join(', ')}…',
            style: TextStyle(
              color: bad ? _kDanger : _kMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCanvas,
      appBar: _appBar('Edit Uploaded Exercise'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(
              title: 'Edit submission',
              subtitle: 'Update the description or replace your file.',
              icon: Icons.cloud_upload_rounded,
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
                      const _SectionLabel('Description', Icons.notes_rounded),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: descriptionController,
                        maxLength: _maxDescLen,
                        maxLines: 4,
                        validator: _validateDescription,
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(color: _kHeading, height: 1.4),
                        decoration: _input(
                          'Description',
                          hint: 'Enter description',
                          alignTop: true,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const _SectionLabel(
                          'Attachment', Icons.attach_file_rounded),
                      const SizedBox(height: 14),
                      _filePicker(),
                      const SizedBox(height: 26),
                      _GradButton(
                        label:
                        isSubmitting ? 'Updating...' : 'Update Submission',
                        icon: Icons.check_rounded,
                        loading: isSubmitting,
                        onPressed: editSubmission,
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
