public class EnquiryCallout {
@AuraEnabled(cacheable=TRUE)
public static List<String> holidayTypes(){
    List<String> travelList = new List<String>();
    Schema.DescribeFieldResult trips=Salesforce_Enquiry__c.Holiday_Type__c.getDescribe();
    List<Schema.PicklistEntry> holidaytype = trips.getPicklistValues();
    for (Schema.PicklistEntry listValue  : holidaytype) {
        travelList.add(listValue.getLabel());
    }
    return travelList;
}
@AuraEnabled(cacheable=TRUE)
public static List<String> country(){
    List<String> countryList = new List<String>();
    Schema.DescribeFieldResult countries=Salesforce_Enquiry__c.Country__c.getDescribe();
    List<Schema.PicklistEntry> countryName = countries.getPicklistValues();
    for (Schema.PicklistEntry listValue  : countryName) {
        countryList.add(listValue.getLabel());
    }
    return countryList;
}
@AuraEnabled(cacheable=TRUE)
public static List<String> enquiryTypes(){
    List<String> enquiryList = new List<String>();
    Schema.DescribeFieldResult enquiries=Salesforce_Enquiry__c.Enquiry_Type__c.getDescribe();
    List<Schema.PicklistEntry> enquiryName = enquiries.getPicklistValues();
    for (Schema.PicklistEntry listValue  : enquiryName) {
        enquiryList.add(listValue.getLabel());
    }
    return enquiryList;
}
public static String buildEnquiryFormBody(Salesforce_Enquiry__c enquiry)
    {
        EnquiryFormData form = new EnquiryFormData();
        form.website_reference_number = enquiry.name;
        form.first_name = enquiry.First_Name__c ;
        form.last_name = enquiry.Last_Name__c ;
        form.email = enquiry.Email__c ;
        form.contact_number = enquiry.Phone__c ;
        form.country = enquiry.Country__c ;
        form.arrival_date = enquiry.Arrival_Date__c ;
        form.depature_date = enquiry.Departure_Date__c ;
        form.adults = enquiry.Number_of_Adults__c ;
        form.children = enquiry.Number_of_Children__c ;
        form.comments = enquiry.Comments__c ;
        form.ed_website = '72';
        form.ed_passkey = 'devpass' ;

        return (String) JSON.serializePretty(form);
        
    }

@future(callout=true)
    public static void doPost(String body){

        try 
        {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            
            req.setEndpoint('https://eddy.rhinoafrica.com/submit');
            req.setHeader('Content-Type', 'application/json');
            req.setMethod('POST');
            req.setBody(body);
            
            HttpResponse res = http.send(req);
            String responseBody = res.getBody();
            system.debug(responseBody);
            // ResponseEnquiry responseToEnquiry = (ResponseEnquiry) JSON.deserialize(responseBody, ResponseEnquiry.class);

        }
        catch(Exception e)
        {
            system.debug(e.getMessage());
        }
   }

    class EnquiryFormData {
        public  String website_reference_number;
        public  String first_name;
        public  String last_name;
        public  String email;
        public  String contact_number;
        public  String country;
        public  Date arrival_date;
        public  Date depature_date;
        public  Decimal adults;
        public  Decimal children;
        public  String comments;
        public  String ed_website;
        public  String ed_passkey;
    }
}