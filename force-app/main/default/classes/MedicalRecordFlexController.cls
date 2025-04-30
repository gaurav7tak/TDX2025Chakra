public without sharing class MedicalRecordFlexController{
    @InvocableMethod
    public static List<Response> getMedicalRecords(List<Request> requests) {
        system.debug('request**********'+requests);
        Request input = requests[0];
        List<Response> responses = new List<Response>();
        Response output = new Response();
        responses.add(output);
        List<Medical_Record__c> medicalRecordList = [Select Id, Procedure_Date__c, Procedure_Name__c, Patient__r.Registration_Number__c,Is_Ongoing_Treatment__c, Notes__c FROM Medical_Record__c WHERE Patient__r.Registration_Number__c =: input.registrationNumber];
        output.Prompt = 'Following are the medical records of the patient that should be considered during FAQs';
        for(Medical_Record__c medRecord: medicalRecordList){
            output.Prompt += '\nProcedure Date: '+medRecord.Procedure_Date__c;
            output.Prompt += '\nProcedure Name: '+medRecord.Procedure_Name__c;
            output.Prompt += '\nIs the condition ongoing?: '+medRecord.Is_Ongoing_Treatment__c;
            output.Prompt += '\nNotes: '+medRecord.Notes__c;
            output.Prompt += '**********************************';
        }
        

        return responses;
    }
 
    // Type and API Name of all variables must match the template
    public class Request {
        @InvocableVariable(required=true)
        public String registrationNumber;
    }

    public class Response {
        @InvocableVariable
        public String Prompt;
    }
}