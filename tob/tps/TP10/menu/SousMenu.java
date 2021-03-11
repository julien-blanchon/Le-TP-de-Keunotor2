package menu;


/**SOLUTION QU'IL FAUT FAIRE: ON FAIT UNE SOUS CLASSE SOUSMENU QUI IMPLEMENTE AUSSI COMMANDE !!!
 * ET ON L'UTILISE DANS EDITEURLIGNE
 *
 */
public class SousMenu extends Menu implements Commande {
    /**
     * Construire un menu vide (sans entrées).
     *
     * @param sonTitre le titre du menu
     */
    public SousMenu(String sonTitre) {
        super(sonTitre);
    }

    @Override
    public void executer() {

    }

    @Override
    public boolean estExecutable() {
        return false;
    }
}
