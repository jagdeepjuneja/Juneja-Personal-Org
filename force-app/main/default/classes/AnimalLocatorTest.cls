@isTest
private class AnimalLocatorTest {
    
    @isTest static void testCalloutMethod() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        String animalName = AnimalLocator.getAnimalNameById(1);
        
        System.assertEquals('chicken', animalName); 
    }
    
}