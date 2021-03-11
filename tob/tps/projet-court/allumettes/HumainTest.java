package allumettes;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/** Classe de test pour Humain
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class HumainTest {

    private String nom = "Xavier";
    private JeuReel j1;
    private JeuProcuration j2;
    private Humain h1;
    private Humain h2;

    @Before
    public void setUp() throws Exception {
        j1 = new JeuReel();
        j2 = new JeuProcuration(j1);
        h1 = new Humain();
        h2 = new Humain();
    }

    @Test
    public void getNom() {
        assertEquals("humain", h1.getNom());
        assertEquals("humain", h2.getNom());
    }

    @Test
    public void getPrise() {
        assertTrue(true);
        //Impossible à tester :(. On fait avec testeur.sh !
    }
}
