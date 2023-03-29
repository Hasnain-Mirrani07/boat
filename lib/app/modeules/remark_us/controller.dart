import 'package:get/get.dart';

class Get_updated extends GetxController{
  final storeStatus = true.obs;

  int i=1;
  bool i1=false;
  bool i2=false;
  bool i3=false;
  bool i4=false;
  void storeStatusOpen(bool isOpen) {
    storeStatus(isOpen);
  }
  changeStatus() {
    if(i==1){
      i = 2;
    }
    else {
      i = 1;
    }
    update();
  }

  void updatesecond(){
    i1 != i1;
    update();
  } void updatethird(){
    i2 != i2;
    update();
  }void updatefourth(){
    i3 != i3;
    update();
  }void updatefifth(){
    i4 != i4;
    update();
  }
}