import 'package:flowkit/controller/my_controller.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

/// Controller for managing submitted questions
class QuestionController extends MyController {
  /// Rich text editor controller for the question input
  late QuillEditorController quillHtmlEditor;
  /// List of submitted questions
  List<String> questions = [];
  /// Loading state for question submission
  bool isLoading = false;

  @override
  void onInit() {
    quillHtmlEditor = QuillEditorController();
    super.onInit();
  }

  /// Posts the current question from the editor and clears it
  Future<void> postQuestion() async {
    try {
      isLoading = true;
      update();
      
      final text = (await quillHtmlEditor.getText()).trim();
      if (text.isNotEmpty) {
        questions.add(text);
        quillHtmlEditor.clear();
      }
    } finally {
      isLoading = false;
      update();
    }
  }
}