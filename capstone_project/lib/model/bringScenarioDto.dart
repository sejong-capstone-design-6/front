

class BringScenarioDto{
  int id;
  String title;
  List<Sentences> sentences;

  BringScenarioDto({required this.id, required this.title, required this.sentences});
  

  BringScenarioDto.fromJson(Map<String, dynamic> json):
    id=json['id'],
    title=json['title'],
    sentences=(json['sentences']as List)
      .map((sentence)=> Sentences.fromJson(sentence))
      .toList();
  
}

class Sentences{
  int id;
  String sentence;
  bool? isSuccess;
  String emotion;

  Sentences({required this.id, required this.sentence, required this.isSuccess, required this.emotion});

  Sentences.fromJson(Map<String, dynamic> json):
  id=json['id'],
  sentence=json['sentence'],
  isSuccess=json['isSuccess'],
  emotion=json['emotion'];

}
