import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_test/app/core/boot_up/injection_container.dart';

import 'package:kgk_test/app/features/ProductList/presentation/bloc/bloc.dart';
import 'package:kgk_test/app/features/ProductList/presentation/bloc/evnts.dart';
import 'package:kgk_test/app/features/ProductList/presentation/bloc/states.dart';

import 'package:kgk_test/app/features/ProductList/data/models/product_list_model.dart';


class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.title});

  final String title;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

late List<ProductListModel> dataList ;
bool isDataLoaded = false;
List<ProductListModel> selectedProduct = [];
List<ProductListModel> oldDataList = [];
int currentDataLength = 0;
 final ScrollController _controller = ScrollController();



@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
 double _height = 1000.0;


  @override
  Widget build(BuildContext context) {

    return  BlocProvider(create: (context)=> ProductBloc(productsLoadUseCase: serviceLocator())..add(ApiCallForProduct()),
    child:    BlocConsumer<ProductBloc,ProductState>(
      listener: (context,state){
        if(state is LoadedStateForProducts){
          dataList = state.data;
          _height = dataList.length * 120;
          currentDataLength = dataList.length;
          isDataLoaded = true;
        }
        if(state is ProductSelectedState){
          if(!selectedProduct.contains(state.selectedProduct)){
            selectedProduct.add(state.selectedProduct);
            if (state.intValue >= 0 && state.intValue < dataList.length) {


              _controller.animateTo(
                state.intValue * 120.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );


            }
            _height = dataList.length * 100;
          }
        }
        if(state is ShowOnlySelectedStateForProducts){
          oldDataList = dataList;
          dataList = state.data;
          _height = dataList.length * 100;
          isDataLoaded = true;
        }


      },
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                if(state is ShowOnlySelectedStateForProducts){
                  context.read<ProductBloc>().add(ShowOnlySelectedProduct(selectedProductList: oldDataList));
                }else{
                  context.read<ProductBloc>().add(ShowOnlySelectedProduct(selectedProductList: selectedProduct));
                }

              }, icon: const Icon(Icons.shopping_cart))
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
                    itemCount: dataList.length,
                      itemBuilder: (context,index){
                      return Card(

                        color: selectedProduct.isEmpty ? Colors.white : selectedProduct.last == dataList[index] && state is! ShowOnlySelectedStateForProducts ? Colors.red : selectedProduct.contains(dataList[index]) &&  state is ShowOnlySelectedStateForProducts ? Colors.blue : Colors.white ,
                        elevation: 2,
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              height: 100,
                              width: 100,
                              imageUrl: dataList[index].image.toString(),
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                      colorFilter:
                                      const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                                ),
                              ),
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
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

              var intValue = Random().nextInt(dataList.length);
              if(selectedProduct.isNotEmpty){
                dataList.removeWhere((element) => selectedProduct.last == element);

              }

              context.read<ProductBloc>().add(ProductSelectionEvents(selectedProduct: dataList[intValue],intValue : intValue,currentDataLength : currentDataLength ));
              // _animateToIndex(intValue);
              // _scrollToIndex(intValue);



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
