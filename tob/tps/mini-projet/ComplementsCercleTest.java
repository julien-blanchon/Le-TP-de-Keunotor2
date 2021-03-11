import org.junit.Before;
import org.junit.Test;

import java.awt.Color;

import static org.junit.Assert.*;

/** Classe de test pour Cercle.
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class ComplementsCercleTest {

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
    public void setUp() {
        A = new Point(1, 2);
        B = new Point(2, 1);
        C = new Point(4, 1);
        D = new Point(8, 1);
        E = new Point(8, 4);
        C1 = new Cercle(A, 2.5);
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
    public void testGetCentre() {
        assertEquals(1.0, C1.getCentre().getX(), EPSILON);
        assertEquals(2.0, C1.getCentre().getY(), EPSILON);
        assertEquals(6.0, C2.getCentre().getX(), EPSILON);
        assertEquals(1.0, C2.getCentre().getY(), EPSILON);
        assertEquals(8.0, C3.getCentre().getX(), EPSILON);
        assertEquals(1.0, C3.getCentre().getY(), EPSILON);
    }

    @Test
    public void testGetCouleur() {
        assertEquals(C1.getCouleur(), Color.blue);
        assertEquals(C2.getCouleur(), Color.blue);
        assertEquals(C3.getCouleur(), Color.blue);
    }

    @Test
    public void testGetRayon() {
        assertEquals(2.5, C1.getRayon(), EPSILON);
        assertEquals(2.0, C2.getRayon(), EPSILON);
        assertEquals(3.0, C3.getRayon(), EPSILON);
    }

    @Test
    public void testGetDiametre() {
        assertEquals(5.0, C1.getDiametre(), EPSILON);
        assertEquals(4.0, C2.getDiametre(), EPSILON);
        assertEquals(6.0, C3.getDiametre(), EPSILON);
    }

    @Test
    public void testToString() {
        assertEquals("C2.5@(1.0, 2.0)", C1.toString());
        assertEquals("C2.0@(6.0, 1.0)", C2.toString());
        assertEquals("C3.0@(8.0, 1.0)", C3.toString());
    }

    @Test
    public void testSetCentre1() {
        C1.setCentre(new Point(0.0, 0.0));
        assertEquals(0.0, C1.getCentre().getX(), EPSILON);
        assertEquals(0.0, C1.getCentre().getY(), EPSILON);
    }

    @Test
    public void testSetCentre2() {
        C1.setCentre(new Point(9.0, 2.0));
        assertEquals(9.0, C1.getCentre().getX(), EPSILON);
        assertEquals(2.0, C1.getCentre().getY(), EPSILON);
    }

    @Test
    public void testSetCentre3() {
        C1.setCentre(new Point(-10.0, 2.0));
        assertEquals(-10.0, C1.getCentre().getX(), EPSILON);
        assertEquals(2.0, C1.getCentre().getY(), EPSILON);
    }

    @Test
    public void testSetRayon1() {
        C1.setRayon(9.0);
        assertEquals(9.0, C1.getRayon(), EPSILON);
    }

    @Test
    public void testSetRayon2() {
        C2.setRayon(2.5);
        assertEquals(2.5, C2.getRayon(), EPSILON);
    }

    @Test
    public void testSetRayon3() {
        C3.setRayon(0.1);
        assertEquals(0.1, C3.getRayon(), EPSILON);
    }

    @Test
    public void testSetCouleur1() {
        C1.setCouleur(Color.cyan);
        assertSame(Color.cyan, C1.getCouleur());
    }

    @Test
    public void testSetCouleur2() {
        C2.setCouleur(Color.red);
        assertSame(Color.red, C2.getCouleur());
    }

    @Test
    public void testSetCouleur3() {
        C3.setCouleur(Color.yellow);
        assertSame(Color.yellow, C3.getCouleur());
    }

    @Test
    public void testSetDiametre1() {
        C1.setDiametre(8.0);
        assertEquals(8.0, C1.getDiametre(), EPSILON);
    }

    @Test
    public void testSetDiametre2() {
        C2.setDiametre(2.5);
        assertEquals(2.5, C2.getDiametre(), EPSILON);
    }

    @Test
    public void testSetDiametre3() {
        C3.setDiametre(0.1);
        assertEquals(0.1, C3.getDiametre(), EPSILON);
    }

    @Test
    public void testContient1() {
        assertTrue(C1.contient(A));
        assertTrue(C1.contient(B));
        assertFalse(C1.contient(C));
        assertFalse(C1.contient(D));
        assertFalse(C1.contient(E));
    }

    @Test
    public void testContient2() {
        assertFalse(C2.contient(A));
        assertFalse(C2.contient(B));
        assertTrue(C2.contient(C));
        assertTrue(C2.contient(D));
        assertFalse(C2.contient(E));
    }

    @Test
    public void testContient3() {
        assertFalse(C3.contient(A));
        assertFalse(C3.contient(B));
        assertFalse(C3.contient(C));
        assertTrue(C3.contient(D));
        assertTrue(C3.contient(E));
    }

    @Test
    public void testPerimetre1() {
        assertEquals(2.0 * Math.PI * 2.5, C1.perimetre(), EPSILON);
    }

    @Test
    public void testPerimetre2() {
        assertEquals(2.0 * Math.PI * 2.0, C2.perimetre(), EPSILON);
    }

    @Test
    public void testPerimetre3() {
        assertEquals(2.0 * Math.PI * 3.0, C3.perimetre(), EPSILON);
    }

    @Test
    public void testAire1() {
        assertEquals(Math.PI * 2.5 * 2.5, C1.aire(), EPSILON);
    }

    @Test
    public void testAire2() {
        assertEquals(Math.PI * 2.0 * 2.0, C2.aire(), EPSILON);
    }

    @Test
    public void testAire3() {
        assertEquals(Math.PI * 3.0 * 3.0, C3.aire(), EPSILON);
    }

    @Test
    public void testTranslater1() {
        C1.translater(1.0, 1.0);
        assertEquals(2.0, C1.getCentre().getX(), EPSILON);
        assertEquals(3.0, C1.getCentre().getY(), EPSILON);
    }

    @Test
    public void testTranslater2() {
        C2.translater(-1.0, -1.0);
        assertEquals(5.0, C2.getCentre().getX(), EPSILON);
        assertEquals(0.0, C2.getCentre().getY(), EPSILON);
    }

    @Test
    public void testTranslater3() {
        C3.translater(0.0, 0.0);
        assertEquals(8.0, C3.getCentre().getX(), EPSILON);
        assertEquals(1.0, C3.getCentre().getY(), EPSILON);
    }

    /*
     * public static void main(String[] args) {
     * org.junit.runner.JUnitCore.main("test.PointTest"); }
     */

}
