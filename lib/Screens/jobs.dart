import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_recruitment/Screens/data.dart';
import 'package:online_recruitment/Screens/job_detail.dart';
import 'package:online_recruitment/constants.dart';
import 'package:online_recruitment/controller/auth_controller.dart';
import 'package:online_recruitment/controller/main_controller.dart';
import 'package:online_recruitment/model/job_model.dart';
import 'package:online_recruitment/widgets/bottom_nav_bar.dart';
import 'package:search_page/search_page.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<JobsPage> {
  late List<Jobs> jobs;
  AuthController auth = AuthController();
  MainController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('Home Page'),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchPage<Jobs>(
                      searchStyle: const TextStyle(
                          color: Colors.green, backgroundColor: Colors.black),
                      items: controller.jobs,
                      searchLabel: 'Search jobs',
                      suggestion: const Center(
                        child: Text('Filter jobs by name, price '),
                      ),
                      failure: const Center(
                        child: Text('No jobs found :('),
                      ),
                      filter: (person) => [
                        person.title,
                        person.price.toString(),
                      ],
                      builder: (person) => ListTile(
                        onTap: () {
                          Get.to(() => JobDetail(job: person));
                        },
                        title: Text('job: ' + person.title!),
                        trailing: Text('price: ' + person.price.toString()),
                        subtitle:
                            Text('company:  ' + person.company!.toString()),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  auth.signOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        // bottomNavigationBar: BottomNavigation(),
        body: GetX<MainController>(
            init: MainController(),
            builder: (_) {
              return _.jobs.isEmpty
                  ? const Center(
                      child: Text('no available jobs'),
                    )
                  : SizedBox(
                      height: height,
                      width: width,
                      child: Column(
                        children: [
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(right: 32, left: 32, top: 48, bottom: 20),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Icon(
                          //         Icons.sort,
                          //         size: 28,
                          //       ),
                          //       Icon(
                          //         Icons.search,
                          //         size: 28,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        right: 0, left: 32, top: 8),
                                    child: Text(
                                      "Find Your Dream \n Job",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                  ),
                                  Container(
                                    height: 300,
                                    width: 200,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32),
                                    child: Column(
                                      children: buildLastJobs(_.jobs),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            }));
  }

  Widget buildFilterOption(String text) {
    return Container(
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRecommendations() {
    List<Widget> list = [];
    list.add(const SizedBox(
      width: 32,
    ));
    for (var i = 0; i < jobs.length; i++) {
      list.add(buildRecommendation(jobs[i]));
    }
    list.add(const SizedBox(
      width: 16,
    ));
    return list;
  }

  Widget buildRecommendation(Jobs job) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => JobDetail(job: job)),
        // );
      },
      child: Container(
        width: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   height: 50,
                //   width: 50,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage(job.logo),
                //       fit: BoxFit.fitWidth,
                //     ),
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(10),
                //     ),
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      job.company.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    job.title.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    r"$" + job.price.toString() + "/h",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildLastJobs(dynamic jobs) {
    List<Widget> list = [];
    for (var i = jobs.length - 1; i > -1; i--) {
      list.add(buildLastJob(jobs[i]));
    }
    return list;
  }

  Widget buildLastJob(Jobs job) {
    return GestureDetector(
      onTap: () {
        Get.to(() => JobDetail(job: job));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 130,
          width: 250,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(16),
          // margin: const EdgeInsets.only(right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   height: 50,
                  //   width: 50,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(job.logo),
                  //       fit: BoxFit.fitWidth,
                  //     ),
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Text(
                        job.company.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      job.title.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      r"$" + job.price.toString() + "/h",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
