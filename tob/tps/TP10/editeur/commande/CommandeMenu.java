package editeur.commande;

import editeur.Ligne;
import menu.Commande;
import menu.Menu;

/** Commande de changement de Menu.
 * @author	Julien Blanchon
 * @version	1.0
 */
public class CommandeMenu implements Commande
{
    /** Le menu d'origine. */
    protected Menu menu_origine;
    /** Le menu de destination. */
    protected Menu menu_destination;


    /** Initialiser les menu sur laquelle travaille
     * cette commande.
     * @param menu_origine le menu d'origine
     * @param menu_destination le menu de destination
     */
    //@ requires (menu_parent != null && sous_menu != null);	// les menus doivent être définie
    public CommandeMenu(Menu menu_origine, Menu menu_destination) {
        this.menu_origine = menu_origine;
        this.menu_destination = menu_destination;
    }

    public void executer() {
        this.menu_origine = this.menu_destination;
    }

    public boolean estExecutable() {
        return true;
    }

}
