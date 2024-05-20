@isTest
public class TestAccountOrderTrigger {
    @isTest static void TestDuplicateOrder(){
        Account acc= new Account(Name='TestingOne');
       // Account acc1= new Account(Name='TestingTwo');
    insert acc;
        Contract con1=new Contract(Name='TestingOne',StartDate=Date.today(),ContractTerm=6,Status='Draft');
        Date startDate= Date.newInstance(2024,1,04);
        Date startDate1= Date.newInstance(2024,1,05);
        Date startDate2= Date.newInstance(2024,1,05);

        Order orderOne= new Order(AccountId=acc.Id,EffectiveDate=startDate,ContractId=con1.Id);
        Order orderTwo= new Order(AccountId=acc.Id,EffectiveDate=startDate1,ContractId=con1.Id);
        Order orderThree= new Order(AccountId=acc.Id,EffectiveDate=startDate2,ContractId=con1.Id);

        Test.startTest();
        try{
        //insert acc;
        // insert acc1;
        insert new List<Order>{orderOne,orderTwo,orderThree};}
        catch(Exception ee){}
         Test.stopTest();

        
        
    }

}