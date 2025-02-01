public class TestEmail {

    public static void sendTestEmail() {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { 'jyothigarapati55@gmail.com' });
        email.setSubject('Test Email');
        email.setPlainTextBody('This is a test email.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        System.debug('Test email sent');
    }
}