class ProductValidator {

  String validateImages(List images){
    if(images.isEmpty) return "Adicione imagens";
    return null;
  }

  String validateName(String text){
    if(text.isEmpty) return "Informe o nome";
    return null;
  }

  String validateDescription(String text){
    if(text.isEmpty) return "Informe a descrição";
    return null;
  }

  String validateDate(String text){
    if(text.isEmpty) return "Informe a data";
    return null;
  }

}