package editeur.commande;

import editeur.Ligne;

/** Supprime le caractère sous le curseur. La position du curseur reste
 * inchangée.
 * @author	Julien Blanchon
 * @version	1.0
 */
public class CommandeSupprimerSousCurseur
        extends CommandeLigne
{

    /** Initialiser la ligne sur laquelle travaille
     * cette commande.
     * @param l la ligne
     */
    //@ requires l != null;	// la ligne doit être définie
    public CommandeSupprimerSousCurseur(Ligne l) {
        super(l);
    }

    public void executer() {
        ligne.supprimer();
    }

    public boolean estExecutable() {
        return ligne.getLongueur() > 0;
    }

}
