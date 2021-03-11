package allumettes;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertTrue;

/** Classe de test pour Joueur.
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class JoueurTest {

    private Strategie strategie1;
    private Joueur joueur1;
    private Strategie strategie2;
    private Joueur joueur2;
    private Strategie strategie3;

    @Before
    public void setUp() throws Exception {
        strategie1 = new Naif();
        joueur1 = new Joueur("Julien", strategie1);
        strategie2 = new Naif();
        joueur2 = new Joueur("Xavier", strategie2);
        strategie3 = new Rapide();
    }

    @Test
    public void getNom() {
        assertEquals("Julien", joueur1.getNom());
        assertEquals("Xavier", joueur2.getNom());
    }

    @Test
    public void getStrategie() {
        assertSame(strategie1, joueur1.getStrategie());
        assertSame(strategie2, joueur2.getStrategie());
    }

    @Test
    public void setStrategie() {
        joueur1.setStrategie(strategie3);
        assertSame(strategie3, joueur1.getStrategie());
        joueur2.setStrategie(strategie1);
        assertSame(strategie1, joueur2.getStrategie());
    }

    @Test
    public void getPrise() {
        //Voir les getPrise des stratégie
        assertTrue(true);
    }
}