package allumettes;

/** JeuProcuration est une procuration de JeuReel
 * La méthode retirer (@see JeuProcuration#retirer) leve une exception
 * CoupInvalideException lorsque il y a de la triche.
 * @author Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 2.0
 */
public class JeuProcuration implements Jeu {

    /** JeuReel sous jacent.*/
    private JeuReel jeu;

    /** Construire le JeuProcuration.
     * @see JeuReel
     * @param jeu JeuReel sous jacent
     */
    public JeuProcuration(JeuReel jeu) {
        this.jeu = jeu;
    }

    /** Obtenir le nombre d'allumettes encore en jeu.
     * @return nombre d'allumettes encore en jeu
     * @see JeuReel#getNombreAllumettes
     */
    @Override
    public int getNombreAllumettes() {
        return jeu.getNombreAllumettes();
    }

    /** Obtenir la représentation textuelle du Jeu.
     * @return représentation textuelle du jeu
     * @see JeuReel#toString()
     */
    @Override
    public String toString() {
        return jeu.toString();
    }

    /** Afficher la représentation textuelle du Jeu.
     * @see JeuReel#afficher()
     */
    public void afficher() {
        jeu.afficher();
    }

    /** Retirer (ou ajoute) des allumettes du jeu (triche).
     * Aucune vérification sur la possibilités de faire le coup.
     * @param nbPrises Nombre d'allumettes à retirer du jeu.
     * @throws OperationInterditeException si le coup est interdit.
     //* @throws CoupInvalideException si le coup n'est pas valide.
     * @see JeuReel#NOMBRE_ALLUMETTES_PAR_DEFAUT
     */
    @Override
    public void retirer(int nbPrises) throws CoupInvalideException {
        this.jeu.setNombreAllumettes(this.jeu.getNombreAllumettes() - nbPrises);
        throw new OperationInterditeException(nbPrises, "Triche !");
    }
}
