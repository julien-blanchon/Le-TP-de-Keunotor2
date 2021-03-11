package allumettes;
/** Défini les propriétés de base de la stratégie "Expert"
 * d'un joueur du jeu des allumettes.
 * @author  Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version 1.0
 */
public class Expert implements Strategie {

    /**Nom de la stratégie.*/
    public static final String NOM_STRATEGIE = "expert";

    /** Obtenir le nom de la stratégie : expert.
     * @return nom de la stratégie
     */
    @Override
    public String getNom() {
        return NOM_STRATEGIE;
    }

    /** Obtenir le choix de la stratégie expert.
     * Toujours faire en sorte de laisser NombreAllumettes = 1[PRISE_MAX+1].
     * Soit NombreAllumettes=k*(PRISE_MAX+1)+1
     * @see Jeu#PRISE_MAX
     * @return nombre d'allumettes à prendre.
     */
    @Override
    public int getPrise(Jeu jeu, String prenom) {
        int nombreAllumettes = jeu.getNombreAllumettes();
        int reste = nombreAllumettes % (jeu.PRISE_MAX + 1); // 0<=reste<=PRISE_MAX
        if (reste == 0) {
            return jeu.PRISE_MAX;
        } else if (reste == 1) {
            return 1;
        } else {
            return reste - 1;
        }
    }
}

