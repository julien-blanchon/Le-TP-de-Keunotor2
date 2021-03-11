package allumettes;

/** Représente un arbitre du jeu des allumettes.
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version	2.0
 */
public class Arbitre {

    /** L'arbitre est confiant si il fait confiance au joueur.*/
    private final boolean confiant;
    /** Joueur 1.*/
    private Joueur joueur1;
    /** Joueur 2.*/
    private Joueur joueur2;

    /** Construire l'arbitre avec les deux joueur j1 et j2.
     * @param j1 joueur1 (joue en premier)
     * @param j2 joueur2
     * @param confiant ¨'arbitre fait confiance aux joueurs
     */
    public Arbitre(Joueur j1, Joueur j2, boolean confiant) {
        this.joueur1 = j1;
        this.joueur2 = j2;
        this.confiant = confiant;
    }

    /** Construire l'arbitre avec les deux joueur j1 et j2.
     * Non confiant par defaut
     * @param j1 joueur1 (joue en premier)
     * @param j2 joueur2 (joue en second)
     */
    public Arbitre(Joueur j1, Joueur j2) {
        this(j1, j2, false);
    }

    /** Arbitrer une partie de jeu des allumettes.
     * @param jeu un objet jeu des allumettes.
     */
    public void arbitrer(allumettes.Jeu jeu) {
        boolean finPartie = false;
        boolean aTricher = false;
        Joueur jActuelle = this.joueur1;
        do {
            try {
                this.faireJouer(jActuelle, jeu);
            } catch (AbandonException e) {
                finPartie = true;
                aTricher = true;
            }
            if (jeu.getNombreAllumettes() <= 0) {
                finPartie = true;
            } else {
                jActuelle = jActuelle == this.joueur1 ? this.joueur2 : this.joueur1;
            }
        } while (!finPartie);
        if (!aTricher) {
            System.out.println(jActuelle.getNom() + " perd !");
            jActuelle = jActuelle == this.joueur1 ? this.joueur2 : this.joueur1;
            System.out.println(jActuelle.getNom() + " gagne !");
        }
    }

    private void faireJouer(Joueur j, Jeu jeu) throws AbandonException {
        JeuProcuration jeuProc = new JeuProcuration((JeuReel) jeu);
        System.out.println("Nombre d'allumettes restantes : "
                + jeu.getNombreAllumettes());
        boolean aJouer = false;
        while (!aJouer) {
            int prise;
            try {
                prise = j.getPrise(jeuProc);
                System.out.println(j.getNom()
                        + " prend "
                        + prise
                        + " allumette"
                        + ((prise == 1 || prise == 0 || prise == -1)  ? "." : "s."));
                jeu.retirer(prise);
                System.out.println("");
                aJouer = true;
            } catch (OperationInterditeException e) {
                if (this.confiant) {
                    switch (j.getStrategie().getNom()) {
                        case Humain.NOM_STRATEGIE:
                            System.out.println("[Une allumette en moins, plus que "
                                    + jeu.getNombreAllumettes()
                                    + ". Chut !]");
                                        break;
                        case Tricheur.NOM_STRATEGIE:
                            System.out.println("[Allumettes restantes : "
                                    + jeu.getNombreAllumettes()
                                    + "]");
                                        break;
                        default:
                            System.out.println("?[Allumettes restantes : "
                                    + jeu.getNombreAllumettes()
                                    + "]");
                                        break;
                    }
                } else {
                    //System.out.println("[Je triche...]");
                    System.out.println("Abandon de la partie car "
                            + j.getNom()
                            + " triche !");
                    throw new AbandonException(j.getNom()
                            + "a volée: "
                            + e.getNombreAllumettes()
                            + "allumettes !");
                }
            } catch (CoupInvalideException e) {
                System.out.println("Impossible ! "
                        + e.getMessage());
                System.out.println("");
                System.out.println("Nombre d'allumettes restantes : "
                        + jeu.getNombreAllumettes());
                aJouer = false;
            }
        }
    }
}