import 'package:flutter/material.dart';
import 'package:shopping_api/controller/network_services.dart';
import 'package:shopping_api/model/model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Products'),
      ),
      body: FutureBuilder(
          future: NetworkServices.fetchProductDatas(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data;
              return GridView.count(
                childAspectRatio: (200 / 300),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(data!.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(data[index].rating.rate.toString()),
                                  const Spacer(),
                                  Text(data[index].id.toString())
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.3,
                                height: size.width * 0.3,
                                child: Image.network(data[index].image),
                              ),
                              Text(
                                data[index].title,
                                style: const TextStyle(
                                    fontSize: 20,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data[index].category.name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                                child: Text(
                                  maxLines: 3,
                                  data[index].description,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '\$ ${data[index].price}',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                    ),
                  );
                }),
              );
            }
            return const Center(child: Text('No Data found'));
          }),
    );
  }
}
