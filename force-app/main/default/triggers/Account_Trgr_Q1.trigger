trigger Account_Trgr_Q1 on Account (after insert,after update) {
    AccountTrgrQ1Handler.OnInsertAccount(Trigger.new);
}