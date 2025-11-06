import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/repo_controller.dart';
import '../models/repo_model.dart';
import 'repo_details_page.dart';

class HomePage extends StatelessWidget {
  final String username;
  final RepoController controller = Get.put(RepoController());

  HomePage({required this.username}) {
    controller.fetchRepos(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$username\'s Repositories'),
        actions: [
          IconButton(
            icon: Obx(() {
              return Icon(controller.isGridView.value ? Icons.list : Icons.grid_view);
            }),
            onPressed: () {
              controller.toggleView();
            },
          ),
          Obx(() {
            return DropdownButton<String>(
              value: controller.sortBy.value,
              items: [
                DropdownMenuItem(value: 'name', child: Text('Name')),
                DropdownMenuItem(value: 'date', child: Text('Date')),
                DropdownMenuItem(value: 'stars', child: Text('Stars')),
              ],
              onChanged: (value) {
                controller.sortBy.value = value!;
                controller.sortRepos();
              },
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.repos.isEmpty) {
          return Center(child: Text('No repositories found'));
        }
        return controller.isGridView.value
            ? GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
          ),
          itemCount: controller.repos.length,
          itemBuilder: (context, index) {
            return RepoCard(repo: controller.repos[index]);
          },
        )
            : ListView.builder(
          itemCount: controller.repos.length,
          itemBuilder: (context, index) {
            return RepoCard(repo: controller.repos[index]);
          },
        );
      }),
    );
  }
}

class RepoCard extends StatelessWidget {
  final Repo repo;

  RepoCard({required this.repo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(repo.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(repo.description),
        trailing: Text('${repo.stars} ⭐'),
        onTap: () {
          Get.to(() {
            return RepoDetailsPage(repo: repo);
          });
        },
      ),
    );
  }
}