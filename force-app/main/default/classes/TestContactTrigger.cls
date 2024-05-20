@isTest
public class TestContactTrigger {
    @isTest static void TestUniqueContact(){
        List<Contact> conList= new List<Contact>();
        Contact con1= new Contact(FirstName='Liam',LastName='Payne',email='LiamP@yahoo.com');
        Contact con2=new Contact(FirstName='Liam',LastName='Payne',email='LiamP@yahoo.com');
        Contact con3=new Contact(FirstName='Louis',LastName='T',email='Louis1@yahoo.com');
        Contact con4=new Contact(FirstName='Niall',LastName='Horan',email='Louis1@yahoo.com');
        Contact con5=new Contact(FirstName='ABHI',LastName='Sharma',email='abhi12@test.com');
        Contact con6=new Contact(FirstName='ABHI',LastName='Sharma',email='abhi12@test.com');
        Contact con7=new Contact(FirstName='ABHI',LastName='Sharma');

        conList.add(con1);
        conList.add(con2);
        conList.add(con3);
        conList.add(con4);
         conList.add(con5);
         conList.add(con6);
         conList.add(con7);

      Test.startTest();
        try{
            insert conList;

        } catch(Exception e){}
        Test.stopTest();
        
    }

}