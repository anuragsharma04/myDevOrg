public class CaseTriggerHandler {
    public static void beforeInsert(List<Case> caseList){
        List<Case> updateCase = new List<Case>();
        for(Case c: caseList){
            if(c.Origin == 'Email'){
                c.Status = 'New';
                c.Priority = 'Meduim';
            }
        }
        
    }

}