package allumettes;

/** Défini les propriétés de base d'une stratégie pour
 * le jeu des allumettes.
 * @author  Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public interface Strategie {

    /** Obtenir le nom de la stratégie.
     * @return nom de la stratégie
     */
    String getNom();

    /** Obtenir le choix de la stratégie pour une configuration donnée (jeu).
     * @param jeu jeu des allumettes.
     * @param prenom le prenom du joueur
     * @return nombre d'allumettes à prendre.
     * @throws CoupInvalideException si le coup n'est pas valide.
     */
    int getPrise(Jeu jeu, String prenom) throws CoupInvalideException;

}
