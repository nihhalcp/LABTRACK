//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';
//
// class SubmitLabExercisePage extends StatefulWidget {
//   final String instructionId;
//   final String exerciseTitle;
//
//   const SubmitLabExercisePage({
//     super.key,
//     required this.instructionId,
//     required this.exerciseTitle,
//   });
//
//   @override
//   State<SubmitLabExercisePage> createState() => _SubmitLabExercisePageState();
// }
//
// class _SubmitLabExercisePageState extends State<SubmitLabExercisePage> {
//
//   TextEditingController descriptionController = TextEditingController();
//
//   File? selectedFile;
//   String? selectedFileName;
//   bool isSubmitting = false;
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
//   Future<void> submitExercise() async {
//
//     if (descriptionController.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please enter description");
//       return;
//     }
//
//     if (selectedFile == null) {
//       Fluttertoast.showToast(msg: "Please select a file");
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
//         Uri.parse('$url/flutter_submit_lab_exercise/'),
//       );
//
//       request.fields['lid'] = lid;
//       request.fields['instruction_id'] = widget.instructionId;
//       request.fields['description'] = descriptionController.text;
//
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'file',
//           selectedFile!.path,
//         ),
//       );
//
//       var response = await request.send();
//       var responseData = await response.stream.bytesToString();
//       var data = jsonDecode(responseData);
//
//       if (data['status'] == 'ok') {
//         Fluttertoast.showToast(
//           msg: "Lab exercise submitted successfully",
//         );
//
//         descriptionController.clear();
//
//         setState(() {
//           selectedFile = null;
//           selectedFileName = null;
//         });
//
//         if (mounted) {
//           Navigator.pop(context);
//         }
//       } else {
//         Fluttertoast.showToast(
//           msg: data['message'] ?? "Submission failed",
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
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
//         title: const Text("Submit Lab Exercise"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Text(
//               widget.exerciseTitle,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             const Text("Description"),
//
//             TextField(
//               controller: descriptionController,
//               maxLength: 200,
//               maxLines: 4,
//               decoration: const InputDecoration(
//                 hintText: "Enter your description",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//
//             const SizedBox(height: 15),
//
//             ElevatedButton.icon(
//               onPressed: chooseFile,
//               icon: const Icon(Icons.attach_file),
//               label: const Text("Choose File"),
//             ),
//
//             const SizedBox(height: 10),
//
//             Text(
//               selectedFileName ?? "No file selected",
//             ),
//
//             const SizedBox(height: 25),
//
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: isSubmitting ? null : submitExercise,
//                 child: Text(
//                   isSubmitting ? "Submitting..." : "Submit Exercise",
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

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

// ═════════════════════════ SUBMIT LAB EXERCISE PAGE ═════════════════════════
class SubmitLabExercisePage extends StatefulWidget {
  final String instructionId;
  final String exerciseTitle;

  const SubmitLabExercisePage({
    super.key,
    required this.instructionId,
    required this.exerciseTitle,
  });

  @override
  State<SubmitLabExercisePage> createState() => _SubmitLabExercisePageState();
}

class _SubmitLabExercisePageState extends State<SubmitLabExercisePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  File? selectedFile;
  String? selectedFileName;
  int? selectedFileSize;
  String? _fileError;
  bool isSubmitting = false;

  static const int _minLen = 10;
  static const int _maxLen = 200;
  static const int _maxFileBytes = 10 * 1024 * 1024; // 10 MB
  static const List<String> _allowedExt = [
    'pdf', 'doc', 'docx', 'txt', 'zip', 'rar',
    'png', 'jpg', 'jpeg', 'ppt', 'pptx', 'xls', 'xlsx',
    'py', 'java', 'c', 'cpp', 'dart', 'js', 'html', 'css', 'sql',
  ];

  // ───────── Helpers ─────────
  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _extOf(String name) {
    final i = name.lastIndexOf('.');
    return (i == -1 || i == name.length - 1)
        ? ''
        : name.substring(i + 1).toLowerCase();
  }

  // ───────── File picking (with validation) ─────────
  Future<void> chooseFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result == null || result.files.isEmpty) return; // user cancelled

      final picked = result.files.single;

      if (picked.path == null) {
        setState(() => _fileError = 'Could not read the selected file');
        return;
      }

      final ext = _extOf(picked.name);
      if (ext.isEmpty || !_allowedExt.contains(ext)) {
        setState(() {
          selectedFile = null;
          selectedFileName = null;
          selectedFileSize = null;
          _fileError = ext.isEmpty
              ? 'File must have an extension'
              : '.$ext files are not allowed. Allowed: ${_allowedExt.join(', ')}';
        });
        return;
      }

      final file = File(picked.path!);
      if (!await file.exists()) {
        setState(() => _fileError = 'Selected file no longer exists');
        return;
      }

      final size = await file.length();
      if (size == 0) {
        setState(() {
          selectedFile = null;
          selectedFileName = null;
          selectedFileSize = null;
          _fileError = 'The selected file is empty';
        });
        return;
      }
      if (size > _maxFileBytes) {
        setState(() {
          selectedFile = null;
          selectedFileName = null;
          selectedFileSize = null;
          _fileError =
          'File is too large (${_formatSize(size)}). Max ${_formatSize(_maxFileBytes)}';
        });
        return;
      }

      setState(() {
        selectedFile = file;
        selectedFileName = picked.name;
        selectedFileSize = size;
        _fileError = null;
      });
    } catch (e) {
      setState(() => _fileError = 'Unable to pick file. Please try again');
    }
  }

  void _removeFile() {
    setState(() {
      selectedFile = null;
      selectedFileName = null;
      selectedFileSize = null;
      _fileError = null;
    });
  }

  // ───────── Validation ─────────
  String? _validateDescription(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return 'Please enter a description';
    if (t.length < _minLen) {
      return 'Please write at least $_minLen characters (${t.length}/$_minLen)';
    }
    if (t.length > _maxLen) return 'Description is too long (max $_maxLen)';
    if (!RegExp(r'[A-Za-z]').hasMatch(t)) {
      return 'Description must contain meaningful text';
    }
    if (RegExp(r'^(.)\1+$').hasMatch(t.replaceAll(' ', ''))) {
      return 'Please write your description properly';
    }
    return null;
  }

  bool _validateFile() {
    if (selectedFile == null) {
      setState(() => _fileError = 'Please select a file to upload');
      return false;
    }
    if (!selectedFile!.existsSync()) {
      setState(() {
        selectedFile = null;
        selectedFileName = null;
        selectedFileSize = null;
        _fileError = 'Selected file no longer exists. Choose it again';
      });
      return false;
    }
    return true;
  }

  void _onSubmit() {
    if (isSubmitting) return;
    FocusScope.of(context).unfocus();

    if (widget.instructionId.trim().isEmpty) {
      _snack('Invalid exercise. Please go back and try again');
      return;
    }

    final formOk = _formKey.currentState!.validate();
    final fileOk = _validateFile();

    if (!formOk || !fileOk) {
      _snack('Please fix the highlighted fields');
      return;
    }

    submitExercise();
  }

  // ───────── Submit ─────────
  Future<void> submitExercise() async {
    setState(() {
      isSubmitting = true;
    });

    try {
      final SharedPreferences sh = await SharedPreferences.getInstance();

      String url = (sh.getString('url') ?? '').trim();
      final String lid = (sh.getString('lid') ?? '').trim();

      if (url.isEmpty || lid.isEmpty) {
        _snack('Session expired. Please log in again');
        return;
      }

      while (url.endsWith('/')) {
        url = url.substring(0, url.length - 1);
      }

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/flutter_submit_lab_exercise/'),
      );

      request.fields['lid'] = lid;
      request.fields['instruction_id'] = widget.instructionId;
      request.fields['description'] = descriptionController.text.trim();

      request.files.add(
        await http.MultipartFile.fromPath('file', selectedFile!.path),
      );

      final streamed =
      await request.send().timeout(const Duration(seconds: 60));
      final responseData = await streamed.stream.bytesToString();

      if (streamed.statusCode < 200 || streamed.statusCode >= 300) {
        _snack('Server error (${streamed.statusCode}). Please try again');
        return;
      }

      final data = jsonDecode(responseData);

      if (data is Map && data['status'] == 'ok') {
        _snack('Lab exercise submitted successfully');

        descriptionController.clear();

        if (!mounted) return;
        setState(() {
          selectedFile = null;
          selectedFileName = null;
          selectedFileSize = null;
          _fileError = null;
        });

        Navigator.pop(context, true);
      } else {
        _snack((data is Map ? data['message'] : null)?.toString() ??
            'Submission failed');
      }
    } on TimeoutException {
      _snack('Request timed out. Check your connection and try again');
    } on SocketException {
      _snack('No internet connection or server unreachable');
    } on FormatException {
      _snack('Unexpected response from server');
    } catch (e) {
      _snack('Unable to submit exercise. Please try again');
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

  // ───────── UI ─────────
  Widget _fileTile() {
    final hasFile = selectedFile != null;
    final hasError = _fileError != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: isSubmitting ? null : chooseFile,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kCanvas,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: hasError
                    ? _kDanger
                    : (hasFile ? _kSuccess : _kBorder),
                width: hasError || hasFile ? 1.6 : 1.2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: hasFile ? const Color(0x1A1C7C54) : _kTile,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    hasFile
                        ? Icons.insert_drive_file_rounded
                        : Icons.cloud_upload_rounded,
                    color: hasFile ? _kSuccess : _kTeal,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedFileName ?? 'Tap to choose a file',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: hasFile ? _kHeading : _kMuted,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        hasFile
                            ? _formatSize(selectedFileSize ?? 0)
                            : 'Max ${_formatSize(_maxFileBytes)}',
                        style: const TextStyle(
                          color: _kMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasFile)
                  IconButton(
                    onPressed: isSubmitting ? null : _removeFile,
                    icon: const Icon(Icons.close_rounded, color: _kDanger),
                    tooltip: 'Remove file',
                  )
                else
                  const Icon(Icons.attach_file_rounded,
                      color: _kTeal, size: 22),
              ],
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 0),
            child: Text(
              _fileError!,
              style: const TextStyle(
                color: _kDanger,
                fontWeight: FontWeight.w600,
                fontSize: 12,
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
      appBar: _appBar('Lab Exercise'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(
              title: 'Submit your work',
              subtitle: widget.exerciseTitle.trim().isEmpty
                  ? 'Add a short description and upload your file.'
                  : widget.exerciseTitle.trim(),
              icon: Icons.assignment_turned_in_rounded,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 28),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Description ──
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionLabel(
                              'Description', Icons.edit_note_rounded),
                          const SizedBox(height: 18),
                          TextFormField(
                            controller: descriptionController,
                            validator: _validateDescription,
                            enabled: !isSubmitting,
                            maxLines: 4,
                            maxLength: _maxLen,
                            textCapitalization: TextCapitalization.sentences,
                            style:
                            const TextStyle(color: _kHeading, height: 1.4),
                            decoration: _input(
                              'Enter your description',
                              hint: 'Briefly describe what you are submitting',
                              alignTop: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── File + submit ──
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionLabel(
                              'Attachment', Icons.attach_file_rounded),
                          const SizedBox(height: 18),
                          _fileTile(),
                          const SizedBox(height: 18),
                          _GradButton(
                            label: isSubmitting
                                ? 'Submitting...'
                                : 'Submit Exercise',
                            icon: Icons.send_rounded,
                            loading: isSubmitting,
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
