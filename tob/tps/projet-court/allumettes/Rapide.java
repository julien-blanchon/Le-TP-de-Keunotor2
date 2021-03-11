package allumettes;

/** Défini les propriétés de base de la stratégie "rapide"
 * d'un joueur du jeu des allumettes.
 * @author  Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class Rapide implements Strategie {

    /**Nom de la stratégie.*/
    public static final String NOM_STRATEGIE = "rapide";

    /** Obtenir le nom de la stratégie : rapide.
     * @return nom de la stratégie
     */
    @Override
    public String getNom() {
        return NOM_STRATEGIE;
    }

    /** Obtenir le choix de la stratégie rapide: le plus grand nombre possible.
     * @see Jeu#getNombreAllumettes()
     * @see Jeu#PRISE_MAX
     * @return nombre d'allumettes à prendre.
     * @Range(from = 1, to = bound)
     */
    @Override
    public int getPrise(Jeu jeu, String prenom) {
        //int bound = Math.min(jeu.PRISE_MAX, jeu.getNombreAllumettes());
        if (jeu.getNombreAllumettes() >= jeu.PRISE_MAX) {
            return jeu.PRISE_MAX;
        } else {
            return jeu.getNombreAllumettes();
        }

    }
}