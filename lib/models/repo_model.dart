class Repo {
  final String name;
  final String description;
  final int stars;
  final String createdAt;
  final String language;
  final int forks;

  Repo({
    required this.name,
    required this.description,
    required this.stars,
    required this.createdAt,
    required this.language,
    required this.forks,
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      name: json['name'] ?? '',
      description: json['description'] ?? 'No description',
      stars: json['stargazers_count'] ?? 0,
      createdAt: json['created_at'] ?? '',
      language: json['language'] ?? 'Unknown',
      forks: json['forks_count'] ?? 0,
    );
  }
}