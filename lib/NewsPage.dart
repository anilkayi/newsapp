import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsapp/NewsDetail.dart';
import 'package:newsapp/data/newsdata.dart';
import 'package:newsapp/models/newsmodels.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsData getData = NewsData();
  NewsModels getApi = NewsModels();

  Future<void> getTrNews() async {
    getApi = await getData.getNews();
  }

  @override
  void initState() {
    getTrNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Haberler Uygulamasi'),
      ),
      body: FutureBuilder(
        future: getTrNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: getApi.articles!.length,
                itemBuilder: (context, index) {
                  return SafeArea(
                    child: Container(
                      height: 500,
                      width: 500,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/a.jpg'),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                              "${getApi.articles![index].urlToImage}"),
                          ExpansionTile(
                            title: Text('${getApi.articles![index].title}'),
                            children: [
                              ListTile(
                                title: Text(
                                    '${getApi.articles![index].description}'),
                              ),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsDetail(getApi
                                            .articles![index].url
                                            .toString())));
                              },
                              child: Text('İşte Detaylar',
                                  style: TextStyle(color: Colors.black)))
                        ],
                      ),
                    ),
                  );
                });
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
