import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:online_recruitment/Screens/data.dart';
import 'package:online_recruitment/controller/main_controller.dart';
import 'package:online_recruitment/model/applications_model.dart';
import 'package:online_recruitment/widgets/bottom_nav_bar.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({Key? key}) : super(key: key);

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<ApplicationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const BottomNavigation(),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetX<MainController>(
              initState: (_) {},
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 32, left: 32, top: 48, bottom: 32),
                      child: Text(
                        "Your \napplications (" +
                            _.applications.length.toString() +
                            ")",
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.2),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 32, left: 32, bottom: 8),
                      child: Column(
                        children: buildApplications(_.applications),
                      ),
                    ),
                  ],
                );
              })),
    );
  }

  List<Widget> buildApplications(List app) {
    List<Widget> list = [];
    for (var i = 0; i < app.length; i++) {
      list.add(buildApplication(app[i]));
    }
    return list;
  }

  Widget buildApplication(Applications application) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Container(
              //   height: 60,
              //   width: 60,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage(application.logo),
              //       fit: BoxFit.fitWidth,
              //     ),
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(10),
              //     ),
              //   ),
              // ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application.title.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      application.company.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )),
              // const Icon(
              //   Icons.more_vert,
              // ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: application.approve == 1
                        ? Text(
                            'approved',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green[500]),
                          )
                        : application.approve == 0
                            ? Text('watiting',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.red[500]))
                            : Text(
                                'rejected',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.red[500]),
                              ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(
              //     child: const Center(
              //       child: Text(
              //         r"$" + 'application.price.toString()' + "/h",
              //         style: TextStyle(
              //           fontSize: 24,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
