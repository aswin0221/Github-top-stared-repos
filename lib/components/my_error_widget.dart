import 'package:flutter/material.dart';
import 'package:github_top_repos/provider/github_repos_provider.dart';
import 'package:provider/provider.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    GithubReposProvider reposProvider = Provider.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Oops! Something went wrong ˙◠˙",
            style: TextStyle(color: Colors.grey),
          ),
          TextButton(
              onPressed: () {
                reposProvider.pageNumber = 1;
                reposProvider.githubRepos = [];
                reposProvider.getGithubRepos();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Refresh",
                    style: TextStyle(color: Color(0xff4e6da3)),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.refresh,
                    size: 16,
                    color: Color(0xff4e6da3),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
