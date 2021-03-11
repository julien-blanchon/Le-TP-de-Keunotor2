/**
 * Classe Cellule
 */
class Cellule {
    private int valeur; //Valeur
    private Cellule suivant; //Cellule suivante

    /** Construire la cellule a partir de valeur et de suivant.
     * @param valeur valeur de la cellule
     * @param suivant cellule suivante
     */
    public Cellule(int valeur, Cellule suivant) {
        this.valeur = valeur;
        this.suivant = suivant;
    }

    /** Construire la cellule a partir de valeur.
     * @param valeur valeur de la cellule
     */
    public Cellule(int valeur) {
        this.valeur = valeur;
        this.suivant = null;
    }

    /** Changer la valeur de la cellule.
     * @param x nouvelle valeur
     */
    public void setValeur(int x) {
        this.valeur = x;
    }

    /** Changer la cellule suivante de la cellule.
     * @param suivant cellule suivante
     */
    public void setSuivant(Cellule suivant) {
        //try {
        //	this.suivant.finalize();
        //} catch (Throwable throwable) {
        //	throwable.printStackTrace();
        //}
        this.suivant = suivant;
    }

    /** Obtenir la valeur de la cellule.
     * @return valeur de la cellule
     */
    public int getValeur() {
        return this.valeur;
    }

    /** Obtenir la poignée de la cellule suivante.
     * @return cellule suivante
     */
    public Cellule getSuivant() {
        return this.suivant;
    }

    @Override
    public String toString() {
        return "[" + this.valeur +"]--" + (this.suivant == null ? 'E' : ">" + this.suivant);
    }

    /** Afficher la cellule. */
    public void afficher() {
        System.out.print(this);
    }





}
