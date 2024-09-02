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
public class TestVerifyDate {

    @IsTest
    static void testCheckDatesWithin30Days() {
        // Test case where date2 is within 30 days of date1
        Date date1 = Date.today();
        Date date2 = date1.addDays(15); // Date within 30 days
        Date resultDate = VerifyDate.CheckDates(date1, date2);

        // Assert that date2 is returned since it's within 30 days
        System.assertEquals(date2, resultDate, 'Date2 should be returned as it is within 30 days of date1');
    }

    @IsTest
    static void testCheckDatesBeyond30Days() {
        // Test case where date2 is beyond 30 days from date1
        Date date1 = Date.today();
        Date date2 = date1.addDays(35); // Date beyond 30 days
        Date resultDate = VerifyDate.CheckDates(date1, date2);

        // Assert that the end of the month date is returned
        Date expectedEndOfMonth = Date.newInstance(date1.year(), date1.month(), Date.daysInMonth(date1.year(), date1.month()));
        System.assertEquals(expectedEndOfMonth, resultDate, 'End of month date should be returned as date2 is beyond 30 days of date1');
    }

    @IsTest
    static void testCheckDatesInThePast() {
        // Test case where date2 is in the past
        Date date1 = Date.today();
        Date date2 = date1.addDays(-5); // Date in the past
        Date resultDate = VerifyDate.CheckDates(date1, date2);

        // Assert that the end of the month date is returned
        Date expectedEndOfMonth = Date.newInstance(date1.year(), date1.month(), Date.daysInMonth(date1.year(), date1.month()));
        System.assertEquals(expectedEndOfMonth, resultDate, 'End of month date should be returned as date2 is in the past');
    }
}
