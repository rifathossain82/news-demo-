import 'package:flutter/material.dart';
import 'package:news_demo/models/news_info.dart';
import 'package:news_demo/services/api_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<NewsModel> _newsModel;

@override
void initState() {
    _newsModel=Api_Manager().getNews();
    print(_newsModel);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (contex,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.articles!.length,
            itemBuilder: (context,index){
              var article=snapshot.data?.articles![index];
              return Container(
                margin: EdgeInsets.all(8),
                height: 100,
                child: Row(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: AspectRatio(
                        aspectRatio: 1,
                      child: Image.network("${article?.urlToImage}",fit: BoxFit.cover,),),
                    ),
                    SizedBox(width: 16,),
                    Flexible(
                      child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${article?.title}",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                         SizedBox(height: 8,),
                          Expanded(child: Text("${article?.description}",overflow: TextOverflow.ellipsis,maxLines: 3,)),
                        ],
                      ),
                    )
                  ],
                  ),
                );
            }
            );
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
            
          },
        ),
      ),
    );
  }
}