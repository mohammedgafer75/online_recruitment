import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_recruitment/add_job.dart';
import 'package:online_recruitment/constants.dart';
import 'package:online_recruitment/widgets/loading.dart';

import 'controller/auth_controller.dart';

class RegistrarPage extends StatefulWidget {
  const RegistrarPage({Key? key}) : super(key: key);

  @override
  State<RegistrarPage> createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  @override
  Widget build(BuildContext context) {
    AuthController auth = AuthController();

    return Scaffold(
        // backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('Employee Page'),
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            Get.to(() => Reservtion());
          },
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('jobs')
                  // .where('aprrov', isEqualTo: 0)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No A vailable requset',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    );
                  } else {
                    return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Admin(snapshot.data!.docs[index]);
                        },
                        itemCount: snapshot.data!.docs.length);
                  }
                }
              }),
        ));
  }

  Widget Admin(dynamic data) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Text(
                ' ${data['title']}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
              IconButton(
                  onPressed: () {
                    change(data.id, "title");
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          Row(
            children: [
              Text(
                '  ${data['description']}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
              IconButton(
                  onPressed: () {
                    change(data.id, "description");
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          Row(
            children: [
              Text(
                '  ${data['price']}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
              IconButton(
                  onPressed: () {
                    change(data.id, "price");
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8.0),
                  child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15, right: 15)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  side: const BorderSide(color: Colors.red)))),
                      onPressed: () {
                        reject(data.id);
                      },
                      child: const Text(
                        'delete',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void change(String id, String field) async {
    TextEditingController change = TextEditingController();
    Get.defaultDialog(
        title: 'Edit',
        content: SingleChildScrollView(
          child: TextFormField(
            // keyboardType: TextInputType.number,
            controller: change,
            decoration: const InputDecoration(
              icon: Icon(Icons.account_circle),
              // labelText: 'Username',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "This field can be empty";
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              showdilog();
              try {
                var fielde = field == 'price' ? int.tryParse(field) : field;
                await FirebaseFirestore.instance
                    .collection('jobs')
                    .doc(id)
                    .update({fielde.toString(): change.text});

                change.clear();
                Get.back();
                Get.back();
                Get.snackbar('done', 'done',
                    backgroundColor: Colors.greenAccent);
              } catch (e) {
                Get.back();
                Get.back();
                Get.snackbar('Done', e.toString(), backgroundColor: Colors.red);
              }
            },
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.back();
                change.clear();
              },
              child: const Text(
                "Exit",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
        ]);
    // var res = await collectionReference.doc(id).update(attribute);
  }

  Future accept(String id) async {
    setState(() {
      showLoadingDialog(context);
    });
    try {
      var res = await FirebaseFirestore.instance
          .collection('request')
          .doc(id)
          .update({
        "approve": 1,
      });
      setState(() {
        Navigator.of(context).pop();
        showBar(context, 'Admin Accepted', 1);
      });
    } catch (e) {
      setState(() {
        Navigator.of(context).pop();
        showBar(context, e.toString(), 0);
      });
    }
  }

  Future reject(String id) async {
    setState(() {
      showLoadingDialog(context);
    });
    try {
      var res =
          await FirebaseFirestore.instance.collection('jobs').doc(id).delete();
      setState(() {
        Navigator.of(context).pop();
        showBar(context, 'deleted', 1);
      });
    } catch (e) {
      setState(() {
        Navigator.of(context).pop();
        showBar(context, e.toString(), 0);
      });
    }
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        content: Center(
          child: SpinKitPouringHourGlassRefined(
            color: kPrimaryColor,
            size: 50,
          ),
        ),
      ),
    );
  }

  void showBar(BuildContext context, String msg, int ch) {
    var bar = SnackBar(
      backgroundColor: ch == 0 ? Colors.red : Colors.green,
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }
}
