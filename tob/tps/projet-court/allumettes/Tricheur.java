package allumettes;

import static allumettes.Jeu.PRISE_MAX;

/** Défini les propriétés de base de la stratégie "tricheur".
 * d'un joueur du jeu des allumettes
 * @author  Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 2.0
 */
public class Tricheur implements Strategie {

    /**Nom de la stratégie.*/
    public static final String NOM_STRATEGIE = "tricheur";

    /** Obtenir le nom de la stratégie : tricheur.
     * @return nom de la stratégie
     */
    @Override
    public String getNom() {
        return NOM_STRATEGIE;
    }

    /** Obtenir le choix de la stratégie tricheur: triche puis prend
     * l'avant dernière allumettes.
     * @return nombre d'allumettes à prendre.
     * @throws CoupInvalideException si le coup est interdit.
     */
    @Override
    public int getPrise(Jeu jeu, String prenom) throws CoupInvalideException {
        int nombreAllumettes = jeu.getNombreAllumettes();
        if (nombreAllumettes == 1 || nombreAllumettes == 2) {
            return 1;
        } else if (nombreAllumettes - 1 <= PRISE_MAX) {
            return (nombreAllumettes - 1);
        } else {
            System.out.println("[Je triche...]");
            jeu.retirer(nombreAllumettes - 2);
            return 1;
        }
    }
}
