/** ExemplePoint2
 * @author  Julien Blanchon
 * @version 1.0
 */
public class ExemplePoint2 {
    public static void main(String[] args) {
        Point p2 = new Point(1, 0);
        p2.setX(10);
        System.out.println("Module de p2 : " + p2.getModule());
        p2.afficher();
    }
}
