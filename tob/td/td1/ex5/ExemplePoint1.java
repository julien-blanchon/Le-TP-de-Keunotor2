/** ExemplePoint1
 * @author  Julien Blanchon
 * @version 1.0
 */
public class ExemplePoint1 {
    public static void main(String[] args) {
        Point p1 = new Point(1, 0);
        System.out.println("Module de p1 : " + p1.getModule());
        System.out.println("Abscisse de p1 : " + p1.getX());
        p1.translater(-1.0, 1.0);
        p1.afficher();
    }
}
