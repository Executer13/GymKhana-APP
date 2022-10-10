import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'methods.dart';

class CastVote extends StatefulWidget {
  @override
  _CastVoteState createState() => _CastVoteState();
}



class _CastVoteState extends State<CastVote> {




late List candidates=[];
    final FirebaseAuth _auth = FirebaseAuth.instance;
fetchDatabaselist()  async {
    List resultant = await GetCandidates().getData();
    resultant=resultant.reversed.toList();
    print(resultant);
    if (resultant == null) {
      print('error');
    } else {
      setState(() {
        
        candidates = resultant;
        
      });
    }
  }


  @override
  void initState() {



    super.initState();
    
  fetchDatabaselist();
  }


  @override
  Widget build(BuildContext context) {
    List options = candidates;
    var target;
    return Container(height: 800,
      child: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "CAST YOUR VOTE",
              style: GoogleFonts.yanoneKaffeesatz(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () => print("Display something")),
              IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () => print("Display something")),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Image(
                  image: AssetImage('images/fflogo.png'),
                  height: 80.0,
                  width: 300.0,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                  child: Center(
                child: Text(
                  ('Kindly Vote Your Prefered Candidate'),
                  style: GoogleFonts.yanoneKaffeesatz(
                      fontSize: 28.0,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold),
                ),
              ))),
          SliverToBoxAdapter(
              child: Center(
            child: Text(
              'Note: You can only vote once!! ',
              style: GoogleFonts.yanoneKaffeesatz(
                  fontSize: 20.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          )),
          SliverToBoxAdapter(
            child: SizedBox(height: 40.0),
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          //   sliver: SliverToBoxAdapter(
          //     child: Text(
          //         "You are required to choose only one option and confirm your choice",
          //         style: TextStyle(color: Colors.grey, fontSize: 18.0)),
          //   ),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                        height: 70.0,
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            gradient: LinearGradient(
                              end: Alignment.bottomRight,
                              colors: [Color.fromARGB(255, 139, 152, 223), Color.fromARGB(255, 114, 192, 255)],
                            )),
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  NetworkImage(options[index]["imageurl"])),
                          trailing: Text(
                            "${options[index]["vote"].toString()} Votes",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                              options[index]["CandidateName"].toString().toUpperCase()),
                          subtitle: Text(options[index]["Candidatecategory"]),
                          onTap: () {
                            
                              var shows=AlertDialog(
                                title: ListTile(
                                  leading: Icon(
                                    Icons.warning,
                                    size: 36.0,
                                    color: Colors.yellow,
                                  ),
                                  title: Text("CONFIRM YOUR CHOICE PLEASE"),
                                  subtitle: Text(
                                      "Notice that you cannot change after confirmation"),
                                ),
                                content: Container(
                                  height: 230.0,
                                  // width: 250.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color.fromARGB(255, 111, 133, 240),
                                            Colors.blue
                                          ])),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10.0,
                                            ),
                                            child: CircleAvatar(
                                                radius: 60.0,
                                                backgroundImage: NetworkImage(
                                                    options[index]["imageurl"])),
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                        Text(options[index]["CandidateName"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5.0),
                                        Text(
                                          options[index]["Candidatedescription"],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                       
                                        Text(
                                          "${options[index]["vote"].toString()} VOTES COUNT",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      
                                      ],
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("No"),
                                    onPressed: () {
                                    Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton.icon(
                                      onPressed: () async {
               int voted=0; 
               int vc=0;
    
       await
        FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).get()
      .then((value) {
        
    
        
               String votex= value.data()!['voted'];
               voted=int.parse(votex);
              
        
         print("value is $voted !");
         
    
    
    
         // Access your after your get the data
       });
    
    
       await
        FirebaseFirestore.instance.collection('candidates').doc(options[index]["Candidateid"]).get()
      .then((value) {
        
    
        
               vc= value.data()!['vote'];
               
              
        
         print("value is $vc");
    
    
    
         // Access your after your get the data
       });
    
    
    
    
    
    
       if(voted==0){

            FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).update({
            'voted': 1
          });



                                               FirebaseFirestore.instance.collection('candidates').doc(options[index]["Candidateid"]).update({
            'vote': vc+1
          });
          alertbox(context,'Voting Sucessful','Your Vote has Been Submitted!','images/sucess.gif');
       }
       else
    
       { alertbox(context,'Voting Eror','You Have Already Voted!','images/cancel.gif');}
    
    
                                      },
                                      icon: Icon(Icons.how_to_vote),
                                      label: Text("Confirm"))
                                ],
                              );
    
                             showDialog(context: context, builder: (context){
    
                                          return shows;
    
                                       });
                            
                          },
                        )));
              },
              childCount: options.length,
            ),
          ),
        ],
      )),
    );
  }
}
