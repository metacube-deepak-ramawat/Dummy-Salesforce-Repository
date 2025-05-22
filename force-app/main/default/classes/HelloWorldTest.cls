@isTest
private class HelloWorldTest {
    @isTest static void testSayHello() {
        System.assertEquals('Hello, World!', HelloWorld.sayHello());
    }
}
