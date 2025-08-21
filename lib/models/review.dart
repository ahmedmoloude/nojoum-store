/// Model representing a user review for an app in the marketplace
class Review {
  final String id;
  final String appId;
  final String userName;
  final String userEmail;
  final double rating; // 1-5 stars
  final String title;
  final String comment;
  final DateTime dateCreated;
  final bool isVerified; // Verified purchase/trial
  final List<String> helpfulVotes; // User IDs who found this helpful

  const Review({
    required this.id,
    required this.appId,
    required this.userName,
    required this.userEmail,
    required this.rating,
    required this.title,
    required this.comment,
    required this.dateCreated,
    this.isVerified = false,
    this.helpfulVotes = const [],
  });

  /// Create a copy with updated fields
  Review copyWith({
    String? id,
    String? appId,
    String? userName,
    String? userEmail,
    double? rating,
    String? title,
    String? comment,
    DateTime? dateCreated,
    bool? isVerified,
    List<String>? helpfulVotes,
  }) {
    return Review(
      id: id ?? this.id,
      appId: appId ?? this.appId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      dateCreated: dateCreated ?? this.dateCreated,
      isVerified: isVerified ?? this.isVerified,
      helpfulVotes: helpfulVotes ?? this.helpfulVotes,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appId': appId,
      'userName': userName,
      'userEmail': userEmail,
      'rating': rating,
      'title': title,
      'comment': comment,
      'dateCreated': dateCreated.toIso8601String(),
      'isVerified': isVerified,
      'helpfulVotes': helpfulVotes,
    };
  }

  /// Create from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      appId: json['appId'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      rating: json['rating']?.toDouble() ?? 0.0,
      title: json['title'] ?? '',
      comment: json['comment'] ?? '',
      dateCreated: DateTime.parse(json['dateCreated']),
      isVerified: json['isVerified'] ?? false,
      helpfulVotes: List<String>.from(json['helpfulVotes'] ?? []),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Review && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Review(id: $id, appId: $appId, rating: $rating, userName: $userName)';
  }
}
