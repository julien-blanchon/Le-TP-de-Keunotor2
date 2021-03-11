package allumettes;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

/** Classe de test pour Naif
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class NaifTest {

    private String nom = "Xavier";
    private JeuReel j1;
    private JeuProcuration j2;
    private Naif s1;
    private Naif s2;

    @Before
    public void setUp() throws Exception {
        j1 = new JeuReel();
        j2 = new JeuProcuration(j1);
        s1 = new Naif();
        s2 = new Naif();
    }

    @Test
    public void getNom() {
        assertEquals("naif", s1.getNom());
        assertEquals("naif", s2.getNom());
    }

    @Test
    public void getPrise() {
        //Impossible de vraiment tester getPrise, sauf a prendre une seed particulière pour random
        int s1_prise = s1.getPrise(j1, this.nom);
        assertTrue(1<=s1_prise && s1_prise<=j1.PRISE_MAX);
        int s2_prise = s1.getPrise(j2, this.nom);
        assertTrue(1<=s2_prise && s2_prise<=j2.PRISE_MAX);
    }

    @Test
    public void getPriseBrute() {
        for (int i=0; i<100; i++) {
            int s1_prise = s1.getPrise(j1, this.nom);
            assertTrue(1<=s1_prise && s1_prise<=j1.PRISE_MAX);
        }
    }
}
