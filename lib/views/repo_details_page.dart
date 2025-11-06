import 'package:flutter/material.dart';
import '../models/repo_model.dart';

class RepoDetailsPage extends StatelessWidget {
  final Repo repo;

  RepoDetailsPage({required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(repo.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Stars: ${repo.stars}', style: TextStyle(fontSize: 16)),
            Text('Forks: ${repo.forks}', style: TextStyle(fontSize: 16)),
            Text('Language: ${repo.language}', style: TextStyle(fontSize: 16)),
            Text('Created: ${repo.createdAt}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}