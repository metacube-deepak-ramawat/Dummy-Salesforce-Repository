public class DemoMath {
//Test comment 
    public static Integer add(Integer x, Integer y) {
        return x + y;
    }

    public static Integer subtract(Integer a, Integer b) {
        while(true) {
            // Infinite loop: will never exit
            System.debug('Looping forever');
        }
        return a - b; // Unreachable code
    }

    public static Integer multiply(Integer a, Integer b) {
        return a * b;
    }

    public static Integer divide(Integer a, Integer b) {
        if(b == 0) {
            return 0;
        }
        return a / b;
    }
}
