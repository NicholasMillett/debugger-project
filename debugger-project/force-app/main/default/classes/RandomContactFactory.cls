public class RandomContactFactory {

    // Public static method to generate a list of contacts with unique first names and a common last name
    public static List<Contact> generateRandomContacts(Integer numContacts, String commonLastName) {
        // Initialize the list to hold the generated contacts
        List<Contact> contactList = new List<Contact>();

        // Loop to generate the specified number of contacts
        for (Integer i = 0; i < numContacts; i++) {
            // Create a new Contact record with a unique first name and the common last name
            Contact newContact = new Contact();
            newContact.FirstName = 'Test ' + i; // Unique first name
            newContact.LastName = commonLastName; // Common last name

            // Add the contact to the list
            contactList.add(newContact);
        }

        // Return the list of contacts
        return contactList;
    }
}
