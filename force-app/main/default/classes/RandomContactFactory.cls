public class RandomContactFactory {
  
  public static List<Contact> generateRandomContacts(Integer count, String lastName){
    List<Contact> conList = new List<Contact>();
    for(Integer i =0; i< count; i++){
      conList.add(new Contact(FirstName = 'first'+i, lastName = lastName));
    }
    return conList;
  }

}