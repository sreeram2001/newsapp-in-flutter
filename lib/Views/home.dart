import 'package:flutter/material.dart';
import 'package:trending_newsapp/models/categorymodel.dart';
import 'package:trending_newsapp/help/data.dart';
import 'package:trending_newsapp/models/articlemodel.dart';
import 'package:trending_newsapp/help/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trending_newsapp/Views/article.dart';
import 'package:trending_newsapp/Views/category.dart';


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
          mainAxisAlignment: MainAxisAlignment.center,
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

          ],
        ),
        elevation: 0.0,
      ),
      body: loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
               ///Category
              Container(
                height: 80,
                child: ListView.builder(
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    return Categorycard(
                      imageUrl: categories[index].imageUrl,
                      categoryName : categories[index].categoryName,
                    );
                    }),
              ),

              ///Blog

              Container(
                padding: EdgeInsets.only(top: 14),
                child: ListView.builder(
                  itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                    return Blogcard(
                      imageUrl: articles[index].urlToImage,
                      title:  articles[index].title,
                      desp: articles[index].description,
                      url: articles[index].url,
                    );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Categorycard extends StatelessWidget {

  final imageUrl, categoryName;
  Categorycard({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: categoryName.toString().toLowerCase(),
            )));

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl, width: 120,height: 70,fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: 120,height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),),
            )
          ],
        ),
      ),
    );
  }
}


class Blogcard extends StatelessWidget {

  final String imageUrl, title, desp, url;
  Blogcard({@required this.imageUrl, @required this.title, @required this.desp, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Article(
              blogUrl: url,

            )
        ));
      },

      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child:Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
                child: Image.network(imageUrl),
            ),
            SizedBox(height: 8,),
            Text(title, style: TextStyle(
              fontSize: 17,
              color: Colors.black87,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 8,),
            Text(desp, style: TextStyle(
                color: Colors.black54
            ),)
          ],
        )
      ),
    );
  }
}




