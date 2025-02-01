global class BatchScheduleEx1  implements Schedulable{

    global void execute(SchedulableContext sc){
        Set<Id> acIds = new Set<Id>{'001dL00000YzbwrQAB','001dL00000aA1GQQA0','001dL00000SAuk0QAD'};
        Database.executeBatch(new BatchApexExample1(acIds));
    }

}