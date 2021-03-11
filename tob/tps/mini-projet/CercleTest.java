import org.junit.Before;
import org.junit.Test;

import java.awt.Color;

import static org.junit.Assert.*;

/** Classe de test pour E12, E13 et E14.
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class CercleTest {

    /** Précision pour la comparaison entre réels.
     */
    public static final double EPSILON = 1e-6;

    private Point A;
    private Point B;
    private Point C;
    private Point D;
    private Point E;
    private Cercle C1;
    private Cercle C2;
    private Cercle C3;

    @Before
    public void setUp()  {
        A = new Point(1, 2);
        B = new Point(2, 1);
        C = new Point(4, 1);
        D = new Point(8, 1);
        E = new Point(8, 4);
        C1 = new Cercle(A, B, Color.yellow);
        C2 = new Cercle(C, D);
        C3 = Cercle.creerCercle(D, E);
    }

    @Test
    public void testInitialisation() {
        assertNotNull(C1);
        assertNotNull(C2);
        assertNotNull(C3);
    }

    @Test
    public void testE12() {
        assertEquals(6.0, C2.getCentre().getX(), EPSILON);
        assertEquals(1.0, C2.getCentre().getY(), EPSILON);
        assertEquals(2.0, C2.getRayon(), EPSILON);
        assertEquals(4.0, C2.getDiametre(), EPSILON);
        assertEquals(Color.blue, C2.getCouleur());
    }

    @Test
    public void testE13() {
        assertEquals(1.5, C1.getCentre().getX(), EPSILON);
        assertEquals(1.5, C1.getCentre().getY(), EPSILON);
        assertEquals(Math.sqrt(0.5), C1.getRayon(), EPSILON);
        assertEquals(2*Math.sqrt(0.5), C1.getDiametre(), EPSILON);
        assertEquals(Color.yellow, C1.getCouleur());
    }

    @Test
    public void testE14() {
        assertNotSame(C3.getCentre(), D);
        assertEquals(8.0, C3.getCentre().getX(), EPSILON);
        assertEquals(1.0, C3.getCentre().getY(), EPSILON);
        assertEquals(3.0, C3.getRayon(), EPSILON);
        assertEquals(6.0, C3.getDiametre(), EPSILON);
        assertEquals(Color.blue, C3.getCouleur());
    }

    /*
     * public static void main(String[] args) {
     * org.junit.runner.JUnitCore.main("test.PointTest"); }
     */

}
