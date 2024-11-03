
import 'package:flutter/material.dart';
import 'package:myparaconnect/view/Client/Contact.dart';

import 'package:myparaconnect/view/Client/Produits.dart';
import 'package:myparaconnect/view/Client/accueil.dart';
import 'package:myparaconnect/view/Client/achats.dart';
import 'package:myparaconnect/view/Client/avoirs.dart';
import 'package:myparaconnect/view/Client/commandes.dart';
import 'package:myparaconnect/view/Client/demandAvoir.dart';
import 'package:myparaconnect/view/Client/factures.dart';
import 'package:myparaconnect/view/Client/promotion.dart';
import 'package:myparaconnect/view/Client/r%C3%A9clamation.dart';
import 'package:myparaconnect/view/login.dart';


class MyDrawerClient extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width = screenWidth;
    double height = screenHeight;

    return Scaffold(
      body:ListView  (
        children: [
          SizedBox(
            height:10,
          ),
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(10),


            child: Row(
                children:[

                  SizedBox(
                    width: width*0.22,
                  ),
                  Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: AssetImage("images/profile.png"),
                        ),
                      ),
                      SizedBox(height: height*0.01,),

                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:Colors.green,
                            radius: 5,
                          ),
                          SizedBox(width: width*0.02,),

                          Text("Online",style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize:18
                          ),),
                        ],
                      ),


                    ],
                  )

                ]),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Accueil', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.file_copy_rounded,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Accueil()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Produits', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.group,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Produits()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Mes Commandes', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.production_quantity_limits,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Commande()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),



          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Mes Achats', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.production_quantity_limits,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Achats()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Mes Factures', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.production_quantity_limits,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Factures()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Mes Avoirs', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.campaign,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Avoirs()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Demande Avoirs ', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.storefront,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DemandAvoir()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Promotions', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.storefront,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Promotion()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Réclamations ', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.storefront,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Reclamation()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),


          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text(' Contact ', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.storefront,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Contact()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text("Déconnection", style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.login,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),





        ],
      ),


    );
  }

}