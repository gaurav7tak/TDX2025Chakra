/**
 * @author Salesforce AI
 * @date 2024-02-29
 * @description This class provides an invocable method to create Medical_Event__c records from a Flow.
 */
public class MedicalEventsHelper {

    /**
     * Creates Medical_Event__c records.
     * @param eventDetails A list of strings, where each string represents the details for a Medical_Event__c record.
     * The string should contain comma-separated values in the order:
     * Event_Date__c (YYYY-MM-DD), Patient_Name__c, Description__c
     * @return A list of IDs of the created Medical_Event__c records.  Returns an empty list if no records are created.
     * @throws DmlException if any errors occur during the DML operation.
     */
    @InvocableMethod(label='Create Medical Events'
                      description='Creates Medical Event records.'
                      category='Medical Events')
    public static void createMedicalEvents(List<String> eventDetails) {
        //System.debug('create Medical Events called with: '+eventDetails);
        List<Medical_Event__c> eventsToInsert = new List<Medical_Event__c>();
        List<MedicalEventResult> createdEventIds = new List<MedicalEventResult>();

        for (String eventDetail : eventDetails) {
            try {
                eventDetail = cleanJsonResponse(eventDetail);
                System.debug('eventDetail= '+eventDetail);
				List<Medical_Event__c> medicalEvents = (List<Medical_Event__c>) System.JSON.deserialize(eventDetail, List<Medical_Event__c>.class);
                // Create the Medical_Event__c record
                System.debug('medicalEvents '+medicalEvents);
                eventsToInsert.addAll(medicalEvents);
            } catch (Exception ex) {
                System.debug('Exception'+ ex.getMessage());
            }
        }

        // Insert the records, if any
        if (!eventsToInsert.isEmpty()) {
            
            try {
                insert eventsToInsert;
                for (Medical_Event__c insertedEvent : eventsToInsert) {
                    createdEventIds.add(new MedicalEventResult(insertedEvent.Id));
                }
                
            } catch (DmlException dmlEx) {
                // Catch the DML exception.  Important for error handling.
                System.debug('A DML exception occurred: ' + dmlEx.getMessage());
                //  Optionally, rethrow the exception if you want the Flow to fail.
                throw dmlEx; // Added rethrow
            }
        }
        System.debug('createdEventIds : '+createdEventIds);
    }

public static String cleanJsonResponse(String rawResponse) {
    System.debug('cleanJsonResponse called');
        if (String.isBlank(rawResponse)) return '';
        
        // Remove leading and trailing backticks with optional "json" label
        Pattern pattern = Pattern.compile('(?s)^```(?:json)?\\s*(.*?)\\s*```$');
        Matcher matcher = pattern.matcher(rawResponse.trim());

        if (matcher.matches()) {
            return matcher.group(1);
        }

        return rawResponse;
    }   
    
    public class MedicalEventResult {
        
        MedicalEventResult(Id recordId){
            this.recordId = recordId;
        }
    
    @InvocableVariable(label='Created Record Id' description='The ID of the created Medical_Event__c record')
    public Id recordId;
    
    @InvocableVariable(label='Success' description='Indicates whether the creation was successful')
    public Boolean isSuccess;

    @InvocableVariable(label='Error Message' description='Error message if creation failed')
    public String errorMessage;
}
}