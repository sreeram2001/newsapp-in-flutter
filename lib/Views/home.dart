import 'package:flutter/material.dart';
import 'package:trending_newsapp/models/categorymodel.dart';
import 'package:trending_newsapp/help/data.dart';
import 'package:trending_newsapp/models/articlemodel.dart';
import 'package:trending_newsapp/help/news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(

              child: Text('Trending', style: TextStyle(
                color: Colors.black
              ),),
            ),
            Container(
              child: Text('News', style: TextStyle(
                color: Colors.amber,
              ),),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(150.0, 5.0, 5.0, 5.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: loading? Center(
        child: Container(

            child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
          child: Container(
            child: Column(
              children: [

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),

                  height: 80,
                  child: ListView.builder(
                      itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                        return Categorycard(
                          imageUrl: categories[index].imageUrl,
                          categoryName : categories[index].categoryName,
                        );
                      }),
              ),

              Container(
                 child: ListView.builder(
                   itemCount: articles.length,
                     shrinkWrap: true,
                     itemBuilder: (context, index){
                     return Blogcard(
                       imageUrl: articles[index].urlToImage,
                       title:  articles[index].title,
                       desp: articles[index].description,

                     );
    }),
        )

            ],
          ),
        ),
    ),
      ));
  }
}


class Categorycard extends StatelessWidget {

  final imageUrl, categoryName;
  Categorycard({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl, width: 120,height: 60,fit: BoxFit.cover,)),
          Container(
            alignment: Alignment.center,
            width: 120,height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,


            ),

            child: Text(categoryName, style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),),
          )
        ],
      ),
    );
  }
}


class Blogcard extends StatelessWidget {

  final String imageUrl, title, desp;
  Blogcard({@required this.imageUrl, @required this.title, @required this.desp});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          Image.network(imageUrl),
          Text(title),
          Text(desp)
        ],
      )
    );
  }
}
