class BringScenarioSentenceDto {
  List<Sentence> sentences;

  BringScenarioSentenceDto({required this.sentences});

  BringScenarioSentenceDto.fromJson(Map<String, dynamic> json)
      : sentences = (json['sentences'] as List)
            .map((sentence) => Sentence.fromJson(sentence))
            .toList();
}

class Sentence {
  int id;
  String text;
  String emotion;
  String speaker;

  Sentence(
      {required this.id,
      required this.text,
      required this.emotion,
      required this.speaker});

  Sentence.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        emotion = json['emotion'],
        speaker = json['speaker'];
}
