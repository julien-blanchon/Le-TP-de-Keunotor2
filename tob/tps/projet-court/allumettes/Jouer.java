package allumettes;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Julien Blanchon {@literal (julien.blanchon@enseeiht.fr)}
 * @version	2.0
 */
public class Jouer {

	/**Nombre maximum de joueur du jeu des allumettes := 2.*/
	private static final int NOMBRE_MAX_JOUEUR = 2;

	/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		try {
			//Joueur joueursTab[] = new Joueur[NOMBRE_MAX_JOUEUR];
			Joueur[] joueursTab = new Joueur[NOMBRE_MAX_JOUEUR];
			int i = 0;
			verifierNombreArguments(args);
			boolean etreConfiant = false;
			for (String arg: args) {
				if (arg.equalsIgnoreCase("-confiant")) {
					etreConfiant = true;
				} else if (arg.matches("[a-zA-Z0-9]+\\@[A-z]+")) {
					if (i >= NOMBRE_MAX_JOUEUR) {
						throw new ConfigurationException("Trop de joueur: "
								+ "(" + (i + 1) + " > " + NOMBRE_MAX_JOUEUR + ")");
					}
					Strategie strategie;
					String[] parts = arg.split("@");
					switch (parts[1].toLowerCase()) {
						case Humain.NOM_STRATEGIE : strategie = new Humain();
							break;
						case Naif.NOM_STRATEGIE: strategie = new Naif();
							break;
						case Rapide.NOM_STRATEGIE: strategie = new Rapide();
							break;
						case Tricheur.NOM_STRATEGIE: strategie = new Tricheur();
							break;
						case Expert.NOM_STRATEGIE: strategie = new Expert();
							break;
						//case Lente.nom: strategie = new Lente();
						//	break;
						default:
							throw new ConfigurationException(
									"Strategie non prise en charge: "
									+ parts[1].toLowerCase());
					}
					joueursTab[i] = new Joueur(parts[0], strategie);
					i++;
				} else {
					throw new ConfigurationException("Argument inconnus : " + arg);
				}
			}
			if (joueursTab[0] == null || joueursTab[1] == null) {
				throw new ConfigurationException(
						"Erreur les strategies ne sont pas bien définis :"
						+ "\n\t\tj1-> "
						+ joueursTab[0]
						+ "\n\t\tj2-> "
						+ joueursTab[1]);
			}
			Arbitre arbitre = new Arbitre(joueursTab[0], joueursTab[1], etreConfiant);
			JeuReel jeu = new JeuReel();
			arbitre.arbitrer(jeu);
		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
	}

	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Jouer joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				//+ " | lente"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Jouer Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

}
