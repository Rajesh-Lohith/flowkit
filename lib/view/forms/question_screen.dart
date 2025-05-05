import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flowkit/controller/forms/question_controller.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/view/layouts/layout.dart';

/// Screen where users can submit questions and view the list
class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with UIMixin {
  final QuestionController controller = QuestionController();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<QuestionController>(
        init: controller,
        tag: 'question_controller',
        builder: (_) {
          return Padding(
            padding: MySpacing.x(flexSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyText.titleMedium(
                  'Ask a Question',
                  fontSize: 18,
                  fontWeight: 600,
                ),
                MySpacing.height(flexSpacing),
                MyContainer(
                  paddingAll: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Rich text editor for questions
                      ToolBar(
                        toolBarColor: contentTheme.background,
                        iconColor: contentTheme.onBackground,
                        padding: EdgeInsets.all(8),
                        iconSize: 20,
                        controller: controller.quillHtmlEditor,
                      ),
                      QuillHtmlEditor(
                        controller: controller.quillHtmlEditor,
                        hintText: 'Type your question here',
                        isEnabled: true,
                        minHeight: 150,
                        backgroundColor: contentTheme.background,
                        textStyle: MyTextStyle.bodyMedium(),
                        hintTextStyle: MyTextStyle.bodyMedium(),
                        padding: EdgeInsets.all(8),
                        hintTextPadding: EdgeInsets.zero,
                      ),
                      MySpacing.height(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyButton.medium(
                            onPressed: controller.isLoading ? null : controller.postQuestion,
                            child: controller.isLoading
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        contentTheme.onPrimary,
                                      ),
                                    ),
                                  )
                                : MyText.bodyMedium('Submit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                MySpacing.height(flexSpacing),
                // Display submitted questions (HTML format)
                ...controller.questions.map(
                  (q) => Padding(
                    padding: MySpacing.y(8),
                    child: MyContainer(
                      paddingAll: 12,
                      child: MyText.bodyMedium(q),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}