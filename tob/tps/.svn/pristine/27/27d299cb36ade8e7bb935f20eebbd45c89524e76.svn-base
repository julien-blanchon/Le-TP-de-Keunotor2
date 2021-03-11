package allumettes;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/** Classe de test pour JeuReel
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class JeuReelTest {

    private JeuReel jeu1;
    private JeuReel jeu2;
    private JeuReel jeu3;

    @Before
    public void setUp() throws Exception {
        jeu1 = new JeuReel();
        jeu2 = new JeuReel(10);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testJeuReelInvalide1() throws IllegalArgumentException {
        jeu3 = new JeuReel(-100);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testJeuReelInvalide2() throws IllegalArgumentException {
        jeu3 = new JeuReel(0);
    }

    @Test
    public void testJeuReel() {
        assertNotNull(jeu1);
        assertNotNull(jeu2);
    }
    @Test
    public void testGetNombreAllumettes() {
        assertEquals(13 , jeu1.getNombreAllumettes());
        assertEquals(10 , jeu2.getNombreAllumettes());
    }

    @Test
    public void testToString() {
        assertEquals("Nombre d'allumettes restantes : 13", jeu1.toString());
        assertEquals("Nombre d'allumettes restantes : 10", jeu2.toString());
    }

    @Test
    public void testRetirerValide() {
        try {
            jeu1.retirer(3);
            jeu2.retirer(3);
        } catch (CoupInvalideException e) {
            e.printStackTrace();
        }
        assertEquals(10 , jeu1.getNombreAllumettes());
        assertEquals(7 , jeu2.getNombreAllumettes());
    }

    @Test(expected = CoupInvalideException.class)
    public void testRetirerInvalide() throws CoupInvalideException {
        jeu1.retirer(100);
    }
}
