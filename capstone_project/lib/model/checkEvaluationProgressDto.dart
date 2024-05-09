class CheckEvaluationProgressDto {
  bool? status;
  int? transcriptId;

  CheckEvaluationProgressDto(
      {required this.transcriptId, required this.status});

  CheckEvaluationProgressDto.fromJson(Map<String, dynamic> json)
      : transcriptId = json['transcriptId'],
        status = json['status'];
}
