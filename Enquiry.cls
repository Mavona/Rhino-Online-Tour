public class Enquiry {
@AuraEnabled
    public static String createEnquiry(Date arrivalDate, String comments, String country, Date departure,
    String email, String enquiryType, String firstName, String holidayType, String lastName, Decimal numberofadults,
    Decimal numberofchildren, String phone )
     {

        try {
           lead newlead = new lead();
           newlead.firstName = firstName;
           newlead.lastName = lastName;
           newlead.company = 'company';
           insert newlead; 
           Salesforce_Enquiry__c record = new Salesforce_Enquiry__c();
           record.Arrival_Date__c = arrivalDate;
           record.Comments__c = comments;
           record.Country__c = country;
           record.Departure_Date__c = departure;
           record.Email__c = email;
           record.Enquiry_Type__c = enquiryType;
           record.First_Name__c = firstName;
           record.Holiday_Type__c = holidayType;
           record.Last_Name__c = lastName;
           record.Number_of_Adults__c = numberofadults;
           record.Number_of_Children__c = numberofchildren;
           record.Phone__c = phone;
           record.Lead__c = newlead.Id;
 
            Database.insert(record);
            return 'Enquiry created successfully';
        } catch(Exception e) {
            return 'Error occurred while creating case: ' + e.getMessage();// + e.getStackTraceString();
        }
    }
}