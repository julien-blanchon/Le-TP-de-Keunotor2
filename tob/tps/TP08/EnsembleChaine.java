/**
 * Classe EnsembleChaine
 */
class EnsembleChaine implements Ensemble {
    private Cellule premiere_cellule; //Premiere cellule

    /** Construire la chaine a partir de valeur et de suivant.
     * @param premiere_cellule la premiere_cellule de la chaine
     */
    public EnsembleChaine(Cellule premiere_cellule) {
        this.premiere_cellule = premiere_cellule;
    }

    /** Construire la chaine vide.
     */
    public EnsembleChaine() {
        this(null);
    }

    //@ public invariant estVide() <==> cardinal() == 0;
    //@ public invariant 0 <= cardinal();

    /** Obtenir le nombre d'éléments dans l'ensemble.
     * @return nombre d'éléments dans l'ensemble.  */
    @Override public int cardinal(){
        int card = 0;
        Cellule curseur = this.premiere_cellule;
        while (curseur!=null){
            card += 1;
            curseur = curseur.getSuivant();
        }
        return card;
    }

    /** Savoir si l'ensemble est vide.
     * @return Est-ce que l'ensemble est vide ? */
    @Override
    public boolean estVide() {
        return (this.cardinal() == 0);
    }

    /** Savoir si un élément est présent dans l'ensemble.
     * @param x l'élément cherché
     * @return x est dans l'ensemble */
    @Override
    public boolean contient(int x) {
        boolean cont = false;
        Cellule curseur = this.premiere_cellule;
        while (cont==false && curseur!=null){
            cont = (curseur.getValeur() == x);
            curseur = curseur.getSuivant();
        }
        return cont;
    }

    /** Ajouter un élément dans l'ensemble.
     * @param x l'élément à ajouter */
    //@ ensures contient(x);        // élément ajouté
    public void ajouter(int x) {
        if (!this.contient(x)) {
            this.premiere_cellule = new Cellule(x, this.premiere_cellule);
        }
    }

    /** Enlever un élément de l'ensemble.
     * @param x l'élément à supprimer */
    //@ ensures ! contient(x);      // élément supprimé
    public void supprimer(int x) {
        if (this.premiere_cellule != null) {
            if (this.premiere_cellule.getValeur() == x) {
                // Supprimer la première cellule
                this.premiere_cellule = this.premiere_cellule.getSuivant();
            } else {
                // Chercher la cellule avant l'élément à supprimer
                Cellule curseur = this.premiere_cellule;
                while (curseur.getSuivant() != null && curseur.getSuivant().getValeur() != x) {
                    curseur = curseur.getSuivant();
                }
                if (curseur.getSuivant() != null) {
                    curseur.setSuivant(curseur.getSuivant().getSuivant());
                }
            }
        }
    }

    @Override public String toString() {
        String resultat = "{";
        if (this.premiere_cellule != null) {
            // traiter la première cellule
            resultat += " " + this.premiere_cellule.getValeur();

            // traiter les autres cellules
            Cellule curseur = this.premiere_cellule.getSuivant();
            while (curseur != null) {
                resultat += " " + curseur.getValeur();
                curseur = curseur.getSuivant();
            }
        }
        resultat += " }";
        return resultat;
    }

    /** Afficher la chaine. */
    public void afficher() {
        System.out.print(this);
    }

    public static void main(String[] args) {
        EnsembleChaine monEnsemble = new EnsembleChaine();
        monEnsemble.ajouter(3);
        monEnsemble.ajouter(9);
        monEnsemble.ajouter(18);
        monEnsemble.ajouter(20);
        System.out.println(monEnsemble.contient(9));
        monEnsemble.contient(9);
        monEnsemble.contient(10);
        monEnsemble.contient(3);
        monEnsemble.afficher();

    }





}
