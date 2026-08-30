class ActivityModel {
  final String? exerciseType;
  final String? duration;
  final String? caloriesBurned;
  final String? steps;
  final String? date;
  final String? time;
  final String? intensity;
  final String? notes;

  ActivityModel({
    this.exerciseType,
    this.duration,
    this.caloriesBurned,
    this.steps,
    this.date,
    this.time,
    this.intensity,
    this.notes,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      exerciseType: json['exerciseType'] as String?,
      duration: json['duration'] as String?,
      caloriesBurned: json['caloriesBurned'] as String?,
      steps: json['steps'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      intensity: json['intensity'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (exerciseType != null) 'exerciseType': exerciseType,
      if (duration != null) 'duration': duration,
      if (caloriesBurned != null) 'caloriesBurned': caloriesBurned,
      if (steps != null) 'steps': steps,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (intensity != null) 'intensity': intensity,
      if (notes != null) 'notes': notes,
    };
  }
}
