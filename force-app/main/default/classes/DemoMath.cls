public class DemoMath {

    public static Integer add(Integer x, Integer y) {
        return x + y;
    }

    public static Integer subtract(Integer a, Integer b) {
        return a - b;
    }

    public static Integer multiply(Integer a, Integer b) {
        return a * b;
    }

    public static Integer divide(Integer a, Integer b) {
        if(b == 0) {
            throw new IllegalArgumentException('Division by zero is not allowed');
        }
        return a / b;
    }
    
    // Additional utility methods for better functionality
    public static Integer power(Integer base, Integer exponent) {
        if (exponent < 0) {
            throw new IllegalArgumentException('Negative exponents not supported for integer power');
        }
        if (exponent == 0) {
            return 1;
        }
        Integer result = 1;
        for (Integer i = 0; i < exponent; i++) {
            result *= base;
        }
        return result;
    }
    
    public static Integer factorial(Integer n) {
        if (n < 0) {
            throw new IllegalArgumentException('Factorial is not defined for negative numbers');
        }
        if (n == 0 || n == 1) {
            return 1;
        }
        Integer result = 1;
        for (Integer i = 2; i <= n; i++) {
            result *= i;
        }
        return result;
    }
    
    public static Integer absoluteValue(Integer n) {
        return n < 0 ? -n : n;
    }
    
    public static Integer maximum(Integer a, Integer b) {
        return a > b ? a : b;
    }
    
    public static Integer minimum(Integer a, Integer b) {
        return a < b ? a : b;
    }
}
