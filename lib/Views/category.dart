import 'package:flutter/material.dart';
import 'package:trending_newsapp/models/articlemodel.dart';
import 'package:trending_newsapp/help/news.dart';
import 'package:trending_newsapp/Views/article.dart';



class CategoryNews extends StatefulWidget {

  final String category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategoryNews();
  }


  getCategoryNews() async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
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
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)),
          )
        ],
        elevation: 0.0,
      ),
      body: loading ? Center(
    child: Container(
    child: CircularProgressIndicator(),
    ),
      ):
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
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