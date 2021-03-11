package allumettes;

import org.junit.Before;
import org.junit.Test;

/** Classe de test pour JeuProcuration.
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class JeuProcurationTest {

    private JeuReel jeu1;
    private JeuReel jeu2;

    private JeuProcuration pjeu1;
    private JeuProcuration pjeu2;

    @Before
    public void setUp() throws Exception {
        jeu1 = new JeuReel();
        jeu2 = new JeuReel(10);
        pjeu1 = (JeuProcuration) new JeuProcuration(jeu1);
        pjeu2 = (JeuProcuration) new JeuProcuration(jeu2);
    }

    @Test(expected = CoupInvalideException.class)
    public void testRetirer1() throws CoupInvalideException {
        pjeu1.retirer(100);
    }

    @Test(expected = OperationInterditeException.class)
    public void testRetirer2() throws CoupInvalideException {
        pjeu1.retirer(11);
    }

    @Test(expected = CoupInvalideException.class)
    public void testRetirer3() throws CoupInvalideException {
        pjeu1.retirer(0);
    }

    @Test(expected = OperationInterditeException.class)
    public void testRetirer4() throws CoupInvalideException {
        pjeu1.retirer(4);
    }

    @Test(expected = CoupInvalideException.class)
    public void testRetirer5() throws CoupInvalideException {
        pjeu1.retirer(-10);
    }
}
