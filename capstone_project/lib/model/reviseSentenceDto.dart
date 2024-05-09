class ReviseSentenceDto{
  String text;

  ReviseSentenceDto(this.text);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['text'] = text;

    return data;
  }
}
