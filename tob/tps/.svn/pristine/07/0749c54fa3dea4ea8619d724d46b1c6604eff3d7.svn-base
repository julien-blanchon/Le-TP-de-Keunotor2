package allumettes;
/** Défini les propriétés de base de la stratégie "Lente"
 * d'un joueur du jeu des allumettes.
 * @author  Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class Lente implements Strategie {

    /**Nom de la stratégie.*/
    public static final String NOM_STRATEGIE = "lente";

    /** Obtenir le nom de la stratégie : lente.
     * @return nom de la stratégie
     */
    @Override
    public String getNom() {
        return NOM_STRATEGIE;
    }

    /** Obtenir le choix de la stratégie lente.
     * Toujours prendre 1 allumette.
     * @return nombre d'allumettes à prendre.
     */
    @Override
    public int getPrise(Jeu jeu, String prenom) {
        return 1;
    }
}

