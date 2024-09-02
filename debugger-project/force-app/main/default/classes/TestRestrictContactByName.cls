/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@IsTest
public class TestRestrictContactByName {

    @IsTest
    static void testInsertInvalidContact() {
        // Test inserting a Contact with an invalid last name
        Contact invalidContact = new Contact(LastName = 'INVALIDNAME', FirstName = 'Test');

        Test.startTest();
        Boolean dmlExceptionThrown = false;
        try {
            insert invalidContact;
        } catch (DmlException e) {
            dmlExceptionThrown = true;
            // Assert that the correct error message is returned
            System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'), 
                          'Unexpected error message: ' + e.getMessage());
        }
        Test.stopTest();

        // Assert that the DML exception was thrown
        System.assert(dmlExceptionThrown, 'Expected DML exception was not thrown.');
    }

    @IsTest
    static void testInsertValidContact() {
        // Test inserting a Contact with a valid last name
        Contact validContact = new Contact(LastName = 'ValidName', FirstName = 'Test');
        
        Test.startTest();
        insert validContact;
        Test.stopTest();

        // Assert that the contact was inserted successfully
        System.assertNotEquals(null, validContact.Id, 'Valid contact should have been inserted successfully.');
    }

    @IsTest
    static void testUpdateContactToInvalidName() {
        // Insert a valid Contact
        Contact validContact = new Contact(LastName = 'ValidName', FirstName = 'Test');
        insert validContact;
        
        // Update the Contact with an invalid last name
        validContact.LastName = 'INVALIDNAME';

        Test.startTest();
        Boolean dmlExceptionThrown = false;
        try {
            update validContact;
        } catch (DmlException e) {
            dmlExceptionThrown = true;
            // Assert that the correct error message is returned
            System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'), 
                          'Unexpected error message: ' + e.getMessage());
        }
        Test.stopTest();

        // Assert that the DML exception was thrown
        System.assert(dmlExceptionThrown, 'Expected DML exception was not thrown.');
    }

    @IsTest
    static void testUpdateContactWithValidName() {
        // Insert a valid Contact
        Contact validContact = new Contact(LastName = 'ValidName', FirstName = 'Test');
        insert validContact;

        // Update the Contact with another valid last name
        validContact.LastName = 'AnotherValidName';
        
        Test.startTest();
        update validContact;
        Test.stopTest();

        // Assert that the contact was updated successfully
        Contact updatedContact = [SELECT LastName FROM Contact WHERE Id = :validContact.Id];
        System.assertEquals('AnotherValidName', updatedContact.LastName, 
                            'Contact should have been updated successfully.');
    }
}
