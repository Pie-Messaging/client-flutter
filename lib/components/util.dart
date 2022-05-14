import 'package:flutter/material.dart';

String? requiredValidator(value) {
  if (value == null || value.isEmpty) {
    return '输入不能为空';
  }
  return null;
}

tapFeedback(BuildContext context, [Object? _]) {
  Feedback.forTap(context);
}
