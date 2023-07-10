import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws RuntimeException {
        Scanner in = new Scanner(System.in);
        String inputExpression = in.next();
        try {
            ExpressionParser parser = new ExpressionParser();
            var result = parser.parse(inputExpression);
            while (!result.isEmpty()) {
                System.out.print(result.getFirst().value().toString() + " ");
                result.removeFirst();
            }
        } catch (RuntimeException e) {
            System.out.println(e.getMessage());
        }
    }
}
