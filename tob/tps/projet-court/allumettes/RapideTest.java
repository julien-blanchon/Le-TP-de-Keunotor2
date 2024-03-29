package allumettes;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

/** Classe de test pour Rapide
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class RapideTest {

    private String nom = "Xavier";
    private JeuReel j1;
    private JeuProcuration j2;
    private Rapide r1;
    private Rapide r2;

    @Before
    public void setUp() throws Exception {
        j1 = new JeuReel();
        j2 = new JeuProcuration(j1);
        r1 = new Rapide();
        r2 = new Rapide();
    }

    @Test
    public void getNom() {
        assertEquals("rapide", r1.getNom());
        assertEquals("rapide", r2.getNom());
    }

    @Test
    public void getPrise1() throws CoupInvalideException {
        assertEquals(3, r1.getPrise(j1, this.nom)); //13
        j1.retirer(3);
        assertEquals(3, r1.getPrise(j1, this.nom)); //10
        j1.retirer(3);
        assertEquals(3, r1.getPrise(j1, this.nom)); //7
        j1.retirer(3);
        assertEquals(3, r1.getPrise(j1, this.nom)); //4
        j1.retirer(3);
        assertEquals(1, r1.getPrise(j1, this.nom)); //1
    }

    @Test
    public void getPrise2() throws CoupInvalideException {
        assertEquals(3, r2.getPrise(j2, this.nom)); //13
        j1.retirer(3);
        assertEquals(3, r2.getPrise(j2, this.nom)); //10
        j1.retirer(3);
        assertEquals(3, r2.getPrise(j2, this.nom)); //7
        j1.retirer(3);
        assertEquals(3, r2.getPrise(j2, this.nom)); //4
        j1.retirer(2);
        assertEquals(2, r2.getPrise(j2, this.nom)); //2
    }

    @Test
    public void getPrise3() throws CoupInvalideException {
        assertEquals(3, r2.getPrise(j2, this.nom)); //13
        j1.retirer(3);
        assertEquals(3, r2.getPrise(j2, this.nom)); //10
        j1.retirer(3);
        assertEquals(3, r2.getPrise(j2, this.nom)); //7
        j1.retirer(3);
        assertEquals(3, r2.getPrise(j2, this.nom)); //4
        j1.retirer(1);
        assertEquals(3, r2.getPrise(j2, this.nom)); //3
    }
}
