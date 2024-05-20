public class SalarySlipController {
    public String empNo { get; set; }
    public String name{get;set;}
    public Integer workingDays { get; set; }
    public Decimal LeaveTaken { get; set; }
    public String desgination{get;set;}
    public Decimal lwp { get; set; }
    public String location{get;set;}
    public Decimal lb { get; set; }
    public String bankname{get;set;}
    public Integer dayspresent { get; set; }
    public Integer bankaccnum { get; set; }
    public Integer effectivedays { get; set; }
     public Integer panNum { get; set; }
     public Integer pfNum { get; set; }
    public Integer esiNum { get; set; }
    public Decimal basicAmount { get; set; }
    public String basicSal {get;set;}
    public SalarySlipController(ApexPages.StandardController controller) {
   
        empNo = '17';
        workingDays = 21;
        name='Puneet';
        LeaveTaken=2.0;
        desgination='Senior Developer';
        lwp=0.0;
        location='Jaipur';
        lb=6.5;
        bankname='';
        dayspresent=19;
        bankaccnum=null;
        effectivedays=31;
        panNum=null;
        pfNum=null;
         esiNum=null;
        basicAmount=null;
        
       
    }
}