import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/repo_model.dart';

class RepoController extends GetxController {
  RxList<Repo> repos = <Repo>[].obs;
  RxBool isGridView = false.obs;
  RxString sortBy = 'name'.obs;
  RxBool isLoading = false.obs;

  void fetchRepos(String username) async {
    isLoading.value = true;
    try {
      var response = await Dio().get('https://api.github.com/users/$username/repos');
      if (response.statusCode == 200) {
        repos.value = (response.data as List).map((e) {
          return Repo.fromJson(e);
        }).toList();
        sortRepos();
      } else {
        Get.snackbar('Error', 'Failed to fetch repos');
      }
    } catch (e) {
      Get.snackbar('Error', 'User not found or network issue');
    } finally {
      isLoading.value = false;
    }
  }

  void sortRepos() {
    if (sortBy.value == 'name') {
      repos.sort((a, b) {
        return a.name.compareTo(b.name);
      });
    } else if (sortBy.value == 'date') {
      repos.sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });
    } else if (sortBy.value == 'stars') {
      repos.sort((a, b) {
        return b.stars.compareTo(a.stars);
      });
    }
    repos.refresh();
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
  }
}