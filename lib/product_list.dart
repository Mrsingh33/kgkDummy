import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_test/bloc/states.dart';
import 'package:kgk_test/product_list_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/bloc.dart';
import 'bloc/evnts.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

late List<ProductListModel> dataList ;
bool isDataLoaded = false;
List<ProductListModel> selectedProduct = [];
int currentDataLength = 0;
final ScrollController _controller = ScrollController();

void _scrollToIndex(int index) {
  if (index >= 0 && index < currentDataLength) { // Replace 20 with your actual list length
    _controller.animateTo(
      index * 100.0, // Adjust this value according to your item height
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
final double _height = 900.0;


  @override
  Widget build(BuildContext context) {

    return  BlocProvider(create: (context)=> ProductBloc()..add(ApiCallForProduct()),
    child:    BlocConsumer<ProductBloc,ProductState>(
      listener: (context,state){
        if(state is LoadingStateForProducts){
          dataList = state.data;
          currentDataLength = dataList.length;
          isDataLoaded = true;
        }
        if(state is ProductSelectedState){
          if(!selectedProduct.contains(state.selectedProduct)){
            selectedProduct.add(state.selectedProduct);
          }
        }
        if(state is ShowOnlySelectedStateForProducts){
          dataList = state.data;
          isDataLoaded = true;
        }

      },
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                context.read<ProductBloc>().add(ShowOnlySelectedProduct(selectedProductList: selectedProduct));
              }, icon: Icon(Icons.shopping_cart))
            ],
            // TRY THIS: Try changing the color here to a specific color (to
            // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            // change color while the other colors stay the same.
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("Choose Product"),
          ),
          body:


          Center(

              child: isDataLoaded ?Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: _height,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: _controller,
                    itemCount: currentDataLength,
                      itemBuilder: (context,index){
                      return Card(
                        color: selectedProduct.isEmpty ? Colors.white : selectedProduct.last == dataList[index] ? Colors.red : selectedProduct.contains(dataList[index]) &&  selectedProduct.last != dataList[index]  ? Colors.blue : Colors.white ,
                        elevation: 2,
                        child: Column(
                          children: [
                            Image.network(dataList[index].image.toString(),
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                      Text(dataList[index].title,style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold

                      ),),
                            Text(dataList[index].title,style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                            ),),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                
                
                
                      }
                  ),
                ),
              ) : const CircularProgressIndicator()
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){

              var intValue = Random().nextInt(currentDataLength);
              if(selectedProduct.isNotEmpty){
                dataList.removeWhere((element) => selectedProduct.last == element);
                currentDataLength--;
              }

              context.read<ProductBloc>().add(ProductSelectionEvents(selectedProduct: dataList[intValue] ));
              // _animateToIndex(intValue);
              _scrollToIndex(intValue);

            },
            tooltip: 'Select',
            child: const Icon(Icons.check_box),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      }
    ),
    );




  }
}
