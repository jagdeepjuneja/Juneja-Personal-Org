global class CustomerService {
  
  webservice static String createCustomer(String name, String phone, String city){
    Account acc = new Account();
    acc.Name = name;
    acc.Phone = phone;
    acc.BillingCity = city;
    
    insert acc;
    
    if(acc.Id <> null){
      return 'Success';
    }
    else{
      return 'failure';
    }
  }
}