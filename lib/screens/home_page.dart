import 'package:flutter/material.dart';
import 'package:github_top_repos/components/github_card.dart';
import 'package:github_top_repos/components/my_error_widget.dart';
import 'package:github_top_repos/provider/github_repos_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GithubReposProvider reposProvider = Provider.of(context);
    return Scaffold(
        backgroundColor: const Color(0xff1c2127),
        appBar: AppBar(
          backgroundColor: const Color(0xff1c2127),
          toolbarHeight: 100,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                " Github top stared repos",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xff2c333b),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xff434b55))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "From ${reposProvider.selectedDate}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          reposProvider.changeDate(context);
                        },
                        child: const Text(
                          "Change",
                          style: TextStyle(color: Color(0xff4e6da3)),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
        body: reposProvider.isError
            ? const MyErrorWidget()
            : ListView.builder(
                itemCount: reposProvider.githubRepos.length + 1,
                controller: reposProvider.scrollController,
                itemBuilder: (context, index) {
                  return index < reposProvider.githubRepos.length
                      ? GithubCard(
                          githubRepoModel: reposProvider.githubRepos[index],
                        )
                      : reposProvider.stopLoader
                          ? const SizedBox()
                          : Center(
                              child: Container(
                                margin: const EdgeInsets.all(18),
                                width: 25,
                                height: 25,
                                child: const CircularProgressIndicator(
                                  color: Color(0xff4e6da3),
                                  strokeWidth: 3,
                                ),
                              ),
                            );
                },
              ));
  }
}
