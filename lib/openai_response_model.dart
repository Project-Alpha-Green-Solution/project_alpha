class ResponseModel {
  late String id;
  late String object;
  late int created;
  late String model;
  late List<ChoiceModel> choices;

  ResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    model = json['model'];
    choices = List<ChoiceModel>.from(
      (json['choices'] as List<dynamic>).map(
        (choice) => ChoiceModel.fromJson(choice),
      ),
    );
  }
}

class UsageModel {
  late int promptTokens;
  late int completionTokens;
  late int totalTokens;

  UsageModel.fromJson(Map<String, dynamic> json) {
    promptTokens = json['prompt_tokens'] ?? 0;
    completionTokens = json['completion_tokens'] ?? 0;
    totalTokens = json['total_tokens'] ?? 0;
  }
}


class ChoiceModel {
  late String text;

  ChoiceModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
}

class MessageModel {
  late String role;
  late String content;

  MessageModel.fromJson(Map<String, dynamic> json) {
  if (json != null) {
    role = json['role'] ?? '';
    content = json['content'] ?? '';
  } else {
    role = '';
    content = '';
  }
}

}
