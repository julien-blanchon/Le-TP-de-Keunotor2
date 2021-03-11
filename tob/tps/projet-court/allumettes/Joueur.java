package allumettes;

/** Défini les propriétés de base d'un joueur du
 * jeu des allumettes.
 * @author  Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 2.0
 */
public class Joueur {

    /** Nom du joueur.*/
    private String nom;
    /** Stratégie actuelle du joueur.*/
    private Strategie strategie;

    /** Construire un joueur à partir de son nom et de ça stratégie.
     * @param nom nom du joueur
     * @param strategie stratégie du joueur
     */
    public Joueur(String nom, Strategie strategie) {
        this.nom = nom;
        this.strategie = strategie;
    }


    /** Obtenir le nom du joueur.
     * @return nom du joueur
     */
    public String getNom() {
        return this.nom;
    }

    /** Obtenir la stratégie actuelle du joueur.
     * @return stratégie du joueur
     */
    public Strategie getStrategie() {
        return this.strategie;
    }

    /** Définir le nom du joueur.
     * @param nom le nouveau nom du joueur
     */
    private void setNom(String nom) {
        this.nom = nom;
    }

    /** Définir la stratégie actuelle du joueur.
     * @param strategie la nouvelle stratégie du joueur
     */
    protected void setStrategie(Strategie strategie) {
        this.strategie = strategie;
    }

    /** Obtenir le choix du joueur.
     * @param jeu jeu des allumettes.
     * @return nombre d'allumettes à prendre.
     * @Range(from = 1, to = bound)
     * @throws CoupInvalideException si le coup n'est pas valide.
     */
    public int getPrise(Jeu jeu) throws CoupInvalideException {
        return strategie.getPrise(jeu, this.getNom());
    }
}