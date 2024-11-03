import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';

class Article {
  String code;
  String description;
  String imageUrl;

  Article({
    required this.code,
    required this.description,
    required this.imageUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      code: json['code'],
      description: json['Description'],
      imageUrl: json['artimage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'Description': description,
      'artimage': imageUrl,
    };
  }
}

class ListArticle {
  static List<Article> articles = [];

  static Future<void> loadArticles() async {
    String jsonString = await rootBundle.loadString('assets/article.json');
    List<dynamic> jsonData = json.decode(jsonString);
    articles = jsonData.map((item) => Article.fromJson(item)).toList();
  }

  static void addArticle(Article newArticle) {
    articles.add(newArticle);
  }

  static List<Article> getArticles() {
    return articles;
  }

  static void updateArticle(int index, Article updatedArticle) {
    articles[index] = updatedArticle;
  }

  static void deleteArticle(int index) {
    articles.removeAt(index);
  }
}

class GestionArticle extends StatefulWidget {
  @override
  _GestionArticleState createState() => _GestionArticleState();
}

class _GestionArticleState extends State<GestionArticle> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    await ListArticle.loadArticles();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filteredArticles = ListArticle.getArticles()
        .where((article) => article.description.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double width = screenWidth;
    double height = screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Row(
          children: [
            Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green.shade800,
              ),
              child: Center(
                child: Text(
                  "Responsable Général",
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Container(
              height: screenHeight * 0.045,
              width: screenWidth * 0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  SizedBox(width: screenWidth * 0.02),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey.shade100,
                    child: Icon(Icons.person, size: 25, color: Colors.grey),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    "CRM",
                    style: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawerAdmin(),
      body: Column(
        children: [
          Container(
            height: height * 0.1,
            width: width * 0.88,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/img.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Article',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          Container(
            height: 50,
            child: ListTile(
              title: Row(
                children: [
                  Container(
                      width: width*0.15,
                      child: Text("code",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800,fontSize: width*0.03),)),
                  SizedBox(width: 12,),
                  Container(
                      width:width*0.2,
                    child: Text("description",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800,fontSize: width*0.03),)),
                ],
              ),
              leading: Container(
                width: 60,
                height: 60,
                child:Row(
                  children: [
                    Text("Article",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800),),
                    SizedBox(width: 12,),

                  ],
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text("Action",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800),),
                  SizedBox()
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                final article = filteredArticles[index];
                return ListTile(
                  title: Row(
                    children: [
                      Container(
                        width:width*0.12,


                          child: Text(article.code,style: TextStyle(fontSize: width*0.03) )),
                      SizedBox(width: 8,),
                      Container(
                          width:width*0.2,

                          child: Text(article.description, style: TextStyle(fontSize: width*0.04),)),
                    ],
                  ),
                  leading: Container(
                    width: 60,
                    height: 60,
                    child: Image.network(article.imageUrl, width: 50, height: 50),
                  ),
                  trailing: Container
                    (
                    width: width*0.27,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _showArticleDialog(context, index, article);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              ListArticle.deleteArticle(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          _showArticleDialog(context, null, null); // Add new article
        },
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  void _showArticleDialog(BuildContext context, int? index, Article? article) {
    final _codeController = TextEditingController(text: article != null ? article.code : '');
    final _descriptionController = TextEditingController(text: article != null ? article.description : '');
    final _imageUrlController = TextEditingController(text: article != null ? article.imageUrl : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Add New Article' : 'Edit Article'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                hintText: "Code*",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 18),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "Description*",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 18),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(
                hintText: 'Image URL',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_codeController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty &&
                  _imageUrlController.text.isNotEmpty) {
                if (index == null) {
                  // Add new article
                  setState(() {
                    ListArticle.addArticle(Article(
                      code: _codeController.text,
                      description: _descriptionController.text,
                      imageUrl: _imageUrlController.text,
                    ));
                  });
                } else {
                  // Update existing article
                  setState(() {
                    ListArticle.updateArticle(
                      index,
                      Article(
                        code: _codeController.text,
                        description: _descriptionController.text,
                        imageUrl: _imageUrlController.text,
                      ),
                    );
                  });
                }
                Navigator.of(context).pop();
              }
            },

            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Color(0xFF0B3D91),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
              child: Text('SAVE', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
