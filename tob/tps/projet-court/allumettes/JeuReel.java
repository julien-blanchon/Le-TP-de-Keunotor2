package allumettes;

/** JeuReel modélise le jeux des allumettes avec 13 allumettes
 *
 * Le jeu des 13 allumettes se joue à deux joueurs qui, à tour
 * de rôle, prennent 1, 2, ..., PRISE_MAX allumettes d’un tas qui en
 * contient initialement 13. Le joueur qui prend la dernière
 * allumette perd.
 * @author Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class JeuReel implements Jeu {

    /** Nombre d'allumettes initial par défaut du jeu.*/
    private static final int NOMBRE_ALLUMETTES_PAR_DEFAUT = 13;

    /** Nombre d'allumettes initial du jeu.*/
    private int nombreAllumettes; //Protected pour que l'on puisse tricher !

    /** Construire un JeuReel à partir du nombre d'allumettes initial.
     * @param nombreAllumettes nombre d'allumettes initial
     * @see JeuReel#nombreAllumettes
     */
    //@ requires nombreAllumettes>=1
    //@ ensures this.getNombreAllumettes()==nombreAllumettes
    public JeuReel(int nombreAllumettes) {
        if (1 <= nombreAllumettes) {
            this.nombreAllumettes = nombreAllumettes;
        } else {
            throw new IllegalArgumentException("Nombre d'allumettes initial: "
                    + nombreAllumettes + "doit être positif !");
        }
    }

    /** Construire un JeuReel.
     * @see JeuReel#nombreAllumettes
     * @see JeuReel#NOMBRE_ALLUMETTES_PAR_DEFAUT
     */
    //@ ensures this.getNombreAllumettes()==nombreAllumettesParDefaut
    public JeuReel() {
        this(NOMBRE_ALLUMETTES_PAR_DEFAUT);
    }

    /** Modifie le nombre d'allumettes sans aucune
     * considération de la cohérence.
     * @param nombreAllumettes le nombre d'allumettes.
     */
    public void setNombreAllumettes(int nombreAllumettes) {
        this.nombreAllumettes = nombreAllumettes;
    }

    /** Récupére le nombre d'allumettes encore en jeu.
     * @return le nombre d'allumettes encore en jeu.
     */
    public int setNombreAllumettes() {
        return this.nombreAllumettes;
    }

    /** Obtenir le nombre d'allumettes encore en jeu.
     * @return nombre d'allumettes encore en jeu
     * @see JeuReel#nombreAllumettes
     */
    @Override
    public int getNombreAllumettes() {
        return this.nombreAllumettes;
    }

    /** Obtenir la représentation textuelle du Jeu.
     * @return représentation textuelle du jeu
     * @see JeuReel#getNombreAllumettes()
     */
    @Override
    public String toString() {
        return "Nombre d'allumettes restantes : "
                + this.getNombreAllumettes();
    }

    /** Afficher la représentation textuelle du Jeu.
     * @see JeuReel#toString()
     */
    public void afficher() {
        System.out.println(this);
    }

    /** Retirer des allumettes.  Le nombre d'allumettes doit être compris
     * entre 1 et PRISE_MAX, dans la limite du nombre d'allumettes encore
     * en jeu.
     * @param nbPrises nombre d'allumettes prises.
     * @see JeuReel#nombreAllumettes
     * @throws CoupInvalideException tentative de prendre un nombre
     * invalide.
     */
    //@ requires nbPrises<=this.getNombreAllumettes()
    // & nbPrises<=PRISE_MAX
    //@ ensures this.getNombreAllumettes()>=0
    @Override
    public void retirer(int nbPrises) throws CoupInvalideException {
        if (nbPrises < 1) {
            throw new CoupInvalideException(nbPrises, "< 1");
        } else if (nbPrises > this.getNombreAllumettes()) {
            throw new CoupInvalideException(nbPrises, "> "
                    + this.getNombreAllumettes());
        } else if (nbPrises > PRISE_MAX) {
            throw new CoupInvalideException(nbPrises, "> "
                    + PRISE_MAX);
        } else {
            this.nombreAllumettes -= nbPrises;
        }
    }
}
