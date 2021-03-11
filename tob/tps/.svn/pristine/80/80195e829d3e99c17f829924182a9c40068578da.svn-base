package allumettes;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/** Classe de test pour Tricheur
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class TricheurTest {

    private String nom = "Xavier";
    private JeuReel j1;
    private JeuProcuration j2;
    private Tricheur r1;
    private Tricheur r2;

    @Before
    public void setUp() throws Exception {
        String nom = "Xavier";
        j1 = new JeuReel();
        j2 = new JeuProcuration(j1);
        r1 = new Tricheur();
        r2 = new Tricheur();
    }

    @Test
    public void getNom() {
        assertEquals("tricheur", r1.getNom());
        assertEquals("tricheur", r2.getNom());
    }

    //@Test
    //public void getPriseReel() throws CoupInvalideException {
    //    int prise = r1.getPrise(j1, this.nom);
    //}

    @Test(expected = OperationInterditeException.class)
    public void getPrise1() throws CoupInvalideException {
        int prise = r1.getPrise(j2, this.nom);
    }
}