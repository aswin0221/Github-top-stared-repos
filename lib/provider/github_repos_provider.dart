import 'package:flutter/material.dart';
import 'package:github_top_repos/helpers/toast_message.dart';
import 'package:github_top_repos/models/github_repo_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class GithubReposProvider extends ChangeNotifier {
  //constructor.
  GithubReposProvider() {
    scrollController.addListener(onScroll);
    getGithubRepos();
    notifyListeners();
  }

  //Initializations.
  ScrollController scrollController = ScrollController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String selectedDate = DateFormat("yyyy-MM-dd")
      .format(DateTime.now().subtract(const Duration(days: 30)));
  List<GithubRepoModel> githubRepos = [];
  int pageNumber = 1;
  bool isError = false;
  bool stopLoader =
      false; //used to stop the loader in listview if any error / no data occurs.

  ///onScroll method is used to track the scroll position for Pagination purpose.
  ///if the user reached end of list. it will again fetch the data using getGithubRepos() method , with the pageNumber [pageNumber].
  onScroll() {
    if (scrollController.position.atEdge) {
      bool isTop = scrollController.position.pixels == 0;
      if (!isTop) {
        getGithubRepos();
      }
    }
  }

  ///getGithubRepos method is used for get the top stared repository in the github
  ///It will get the repository that are created after the date [selectedDate]
  ///we used [pageNumber] for the purpose of pagination it will get incremented for each successful fetch.

  getGithubRepos() async {
    isError = false;
    stopLoader = false;
    notifyListeners();
    try {
      final result = await http.get(Uri.parse(
          "https://api.github.com/search/repositories?q=created:>$selectedDate&sort=stars&order=desc&page=$pageNumber"));
      if (result.statusCode == 200) {
        final repoList = json.decode(result.body);

        if (repoList["items"].isEmpty) {
          stopLoader = true;
          showToast("No data found", false);
          notifyListeners();
        }

        for (var i in repoList["items"]) {
          githubRepos.add(GithubRepoModel.fromMap(i));
        }
        pageNumber++;
        notifyListeners();
      } else {
        debugPrint("Something went wrong!");
      }
    } catch (e) {
      //checking githubRepos has data , if it has we just making the stopLoader=true to stop loading.
      //If the length is Empty it will set isError = true to show error message.
      if (githubRepos.isEmpty) {
        isError = true;
        notifyListeners();
      } else {
        stopLoader = true;
        notifyListeners();
      }
      showToast("Error Loading the github repositories", true);
    }
  }

  ///changeDate method is used for get date from the user, and that
  ///will be set to [selectedDate] by formatting the text in yyyy-MM-dd format.
  ///once changeDate method called it will reset the [githubRepos] and [pageNumber].

  changeDate(BuildContext context) {
    showDatePicker(
            context: context,
            barrierDismissible: false,
            firstDate: DateTime.now().subtract(const Duration(days: 120)),
            lastDate: DateTime.now().subtract(const Duration(days: 1)))
        .then(
      (value) {
        githubRepos = [];
        pageNumber = 1;
        selectedDate = dateFormat.format(value!);
        notifyListeners();
        getGithubRepos();
      },
    );
  }

  ///This method is used to open the github repository.
  openRepository(String repoUrl) async {
    try {
      await launchUrl(Uri.parse(repoUrl), mode: LaunchMode.inAppWebView);
    } catch (e) {
      showToast("Error opening the github repository", true);
    }
  }
}
