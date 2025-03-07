class UserProfile {
  String id;
  String name;
  String bio;
  String profilePictureUrl;

  UserProfile({
    required this.id,
    required this.name,
    required this.bio,
    required this.profilePictureUrl,
  });

  // Convert a UserProfile into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  // Create a UserProfile from a Map
  factory UserProfile.fromMap(Map<String, dynamic> map, String documentId) {
    return UserProfile(
      id: documentId,
      name: map['name'],
      bio: map['bio'],
      profilePictureUrl:
          map['profilePictureUrl'] ??
          '', // Handle default empty value if profilePictureUrl is null
    );
  }
}
