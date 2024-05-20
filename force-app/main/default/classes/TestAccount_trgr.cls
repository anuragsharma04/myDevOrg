@isTest
public class TestAccount_trgr {
    @isTest static void TestAccountOpp(){
      /* Account testAcc=new Account(Name='Testt1', Account_Type__c='Health_Fund');
        insert testAcc;
        Test.startTest();
        testAcc.Account_Type__c='Health_Welfare_Fund';
        update testAcc;
        Test.stopTest();*/
       List <Account> acctst= new List<Account>();
        for(Integer i=0;i<10;i++){
            if(i<5){
                Account ac1 =new Account(Name='Tessssst'+i,Account_Type__c='Health_Fund');
                acctst.add(ac1);
            } else{
            Account ac2 =new Account(Name='Tessssst'+i,Account_Type__c='Health_Welfare_Fund');
                acctst.add(ac2);
            }
} insert acctst;
        
    }

}