@isTest
public class DemoMathTest {
    
    @isTest
    static void testAdd() {
        Integer result1 = DemoMath.add(5, 3);
        System.assertEquals(8, result1, 'Addition of 5 + 3 should equal 8');
        
        // Test negative numbers
        Integer result2 = DemoMath.add(-5, 3);
        System.assertEquals(-2, result2, 'Addition of -5 + 3 should equal -2');
        
        // Test zero
        Integer result3 = DemoMath.add(0, 10);
        System.assertEquals(10, result3, 'Addition of 0 + 10 should equal 10');
        
        // Test large numbers
        Integer result4 = DemoMath.add(1000, 2000);
        System.assertEquals(3000, result4, 'Addition of 1000 + 2000 should equal 3000');
    }
    
    @isTest
    static void testSubtract() {
        // Test positive numbers
        Integer result1 = DemoMath.subtract(10, 5);
        System.assertEquals(5, result1, 'Subtraction of 10 - 5 should equal 5');
        
        // Test negative result
        Integer result2 = DemoMath.subtract(3, 7);
        System.assertEquals(-4, result2, 'Subtraction of 3 - 7 should equal -4');
        
        // Test zero
        Integer result3 = DemoMath.subtract(5, 5);
        System.assertEquals(0, result3, 'Subtraction of 5 - 5 should equal 0');
        
        // Test negative numbers
        Integer result4 = DemoMath.subtract(-5, -3);
        System.assertEquals(-2, result4, 'Subtraction of -5 - (-3) should equal -2');
    }
    
    @isTest
    static void testMultiply() {
        // Test positive numbers
        Integer result1 = DemoMath.multiply(5, 3);
        System.assertEquals(15, result1, 'Multiplication of 5 * 3 should equal 15');
        
        // Test negative numbers
        Integer result2 = DemoMath.multiply(-5, 3);
        System.assertEquals(-15, result2, 'Multiplication of -5 * 3 should equal -15');
        
        // Test zero
        Integer result3 = DemoMath.multiply(0, 10);
        System.assertEquals(0, result3, 'Multiplication of 0 * 10 should equal 0');
        
        // Test by one
        Integer result4 = DemoMath.multiply(7, 1);
        System.assertEquals(7, result4, 'Multiplication of 7 * 1 should equal 7');
    }
    
    @isTest
    static void testDivide() {
        // Test normal division
        Integer result1 = DemoMath.divide(10, 2);
        System.assertEquals(5, result1, 'Division of 10 / 2 should equal 5');
        
        // Test division with remainder (integer division)
        Integer result2 = DemoMath.divide(10, 3);
        System.assertEquals(3, result2, 'Division of 10 / 3 should equal 3 (integer division)');
        
        // Test negative numbers
        Integer result3 = DemoMath.divide(-10, 2);
        System.assertEquals(-5, result3, 'Division of -10 / 2 should equal -5');
        
        // Test division by 1
        Integer result4 = DemoMath.divide(15, 1);
        System.assertEquals(15, result4, 'Division of 15 / 1 should equal 15');
    }
    
    @isTest
    static void testDivideByZero() {
        // Test division by zero - should throw exception
        try {
            DemoMath.divide(10, 0);
            System.assert(false, 'Exception should have been thrown for division by zero');
        } catch (IllegalArgumentException e) {
            System.assert(e.getMessage().contains('Division by zero is not allowed'));
        }
    }
    
    @isTest
    static void testPower() {
        // Test positive exponent
        Integer result1 = DemoMath.power(2, 3);
        System.assertEquals(8, result1, '2^3 should equal 8');
        
        // Test exponent of 0
        Integer result2 = DemoMath.power(5, 0);
        System.assertEquals(1, result2, '5^0 should equal 1');
        
        // Test exponent of 1
        Integer result3 = DemoMath.power(7, 1);
        System.assertEquals(7, result3, '7^1 should equal 7');
        
        // Test base of 0
        Integer result4 = DemoMath.power(0, 3);
        System.assertEquals(0, result4, '0^3 should equal 0');
    }
    
    @isTest
    static void testPowerNegativeExponent() {
        // Test negative exponent - should throw exception
        try {
            DemoMath.power(2, -1);
            System.assert(false, 'Exception should have been thrown for negative exponent');
        } catch (IllegalArgumentException e) {
            System.assert(e.getMessage().contains('Negative exponents not supported'));
        }
    }
    
    @isTest
    static void testFactorial() {
        // Test factorial of 0
        Integer result1 = DemoMath.factorial(0);
        System.assertEquals(1, result1, '0! should equal 1');
        
        // Test factorial of 1
        Integer result2 = DemoMath.factorial(1);
        System.assertEquals(1, result2, '1! should equal 1');
        
        // Test factorial of 5
        Integer result3 = DemoMath.factorial(5);
        System.assertEquals(120, result3, '5! should equal 120');
        
        // Test factorial of 3
        Integer result4 = DemoMath.factorial(3);
        System.assertEquals(6, result4, '3! should equal 6');
    }
    
    @isTest
    static void testFactorialNegative() {
        // Test factorial of negative number - should throw exception
        try {
            DemoMath.factorial(-1);
            System.assert(false, 'Exception should have been thrown for negative factorial');
        } catch (IllegalArgumentException e) {
            System.assert(e.getMessage().contains('Factorial is not defined for negative numbers'));
        }
    }
    
    @isTest
    static void testAbsoluteValue() {
        // Test positive number
        Integer result1 = DemoMath.absoluteValue(5);
        System.assertEquals(5, result1, 'Absolute value of 5 should be 5');
        
        // Test negative number
        Integer result2 = DemoMath.absoluteValue(-5);
        System.assertEquals(5, result2, 'Absolute value of -5 should be 5');
        
        // Test zero
        Integer result3 = DemoMath.absoluteValue(0);
        System.assertEquals(0, result3, 'Absolute value of 0 should be 0');
    }
    
    @isTest
    static void testMaximum() {
        // Test positive numbers
        Integer result1 = DemoMath.maximum(5, 3);
        System.assertEquals(5, result1, 'Maximum of 5 and 3 should be 5');
        
        // Test negative numbers
        Integer result2 = DemoMath.maximum(-5, -3);
        System.assertEquals(-3, result2, 'Maximum of -5 and -3 should be -3');
        
        // Test equal numbers
        Integer result3 = DemoMath.maximum(7, 7);
        System.assertEquals(7, result3, 'Maximum of 7 and 7 should be 7');
    }
    
    @isTest
    static void testMinimum() {
        // Test positive numbers
        Integer result1 = DemoMath.minimum(5, 3);
        System.assertEquals(3, result1, 'Minimum of 5 and 3 should be 3');
        
        // Test negative numbers
        Integer result2 = DemoMath.minimum(-5, -3);
        System.assertEquals(-5, result2, 'Minimum of -5 and -3 should be -5');
        
        // Test equal numbers
        Integer result3 = DemoMath.minimum(7, 7);
        System.assertEquals(7, result3, 'Minimum of 7 and 7 should be 7');
    }
}
