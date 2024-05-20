public class AccountOrderTriggerHandler {
    public static void checkDuplicateOrder(List<Order> orderList){
        set<Id> accIds = new Set<Id>();
        Set<Date> startDate = new Set<Date>();
        Map<Id,Set<Date>> mapOfIdDate= new  Map<Id,Set<Date>> ();
        for(Order o: orderList){
            if(!mapOfIdDate.containsKey(o.AccountId)){
                mapOfIdDate.put(o.AccountId,new Set<Date>{o.EffectiveDate});
            } else{
                mapOfIdDate.get(o.AccountId).add(o.EffectiveDate);
            }
            accIds.add(o.AccountId);
        }
        List<Date> relatedDateIdList= new List<Date>();
        for(Set<Date> d :mapOfIdDate.values()){
            relatedDateIdList.addAll(d);
        }
 List<Order> orderRelatedToAcc=[SELECT Id,EffectiveDate,Order.AccountId FROM Order WHERE EffectiveDate IN:relatedDateIdList AND Order.AccountId IN: accIds];
        Map<Date,Set<Id>> startingDateMap= new Map<Date,Set<Id>>();
        for(Order relatedToAcc : orderRelatedToAcc){
            if(!startingDateMap.containsKey(relatedToAcc.EffectiveDate)){
                startingDateMap.put(relatedToAcc.EffectiveDate, new Set<Id>{relatedToAcc.AccountId});
            } else{
                startingDateMap.get(relatedToAcc.EffectiveDate).add(relatedToAcc.AccountId);
            }
            }
         for(Order newwOrder : orderList){
                if(startingDateMap.containsKey(newwOrder.EffectiveDate)&& startingDateMap.get(newwOrder.EffectiveDate).contains(newwOrder.AccountId)){
                    newwOrder.addError('Duplicate order, order exists with the same start date');
                     }
           }
        }
}