package allumettes;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ExpertTest {

    private String nom = "Xavier";
    private JeuReel j1;
    private JeuReel j2;
    private Expert s1;
    private Expert s2;

    @Before
    public void setUp() throws Exception {
        j1 = new JeuReel();
        j2 = new JeuReel(13);
        s1 = new Expert();
        s2 = new Expert();
    }

    @Test
    public void getNom() {
        assertEquals("expert", s1.getNom());
        assertEquals("expert", s2.getNom());
    }

    @Test
    public void getPrise1() throws CoupInvalideException {
        assertEquals(1, s1.getPrise(j1, this.nom)); //13
        j1.retirer(1);
        assertEquals(3, s1.getPrise(j1, this.nom)); //12
        j1.retirer(3);
        assertEquals(1, s1.getPrise(j1, this.nom)); //9
        j1.retirer(1);
        assertEquals(3, s1.getPrise(j1, this.nom)); //8
        j1.retirer(3);
        assertEquals(1, s1.getPrise(j1, this.nom)); //5
        j1.retirer(1);
        assertEquals(3, s1.getPrise(j1, this.nom)); //4
        j1.retirer(3);
        assertEquals(1, s1.getPrise(j1, this.nom)); //1
        j1.retirer(1);
    }

    @Test
    public void getPrise2() throws CoupInvalideException {
        assertEquals(1, s2.getPrise(j2, this.nom)); //13
        j2.retirer(2);
        assertEquals(2, s2.getPrise(j2, this.nom)); //11
        j2.retirer(1);
        assertEquals(1, s2.getPrise(j2, this.nom)); //10
        j2.retirer(1);
    }
}
