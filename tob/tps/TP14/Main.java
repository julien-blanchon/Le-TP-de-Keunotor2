import java.util.*;
import java.util.stream.Collectors;
import java.io.*;
import java.util.zip.*;
import java.time.LocalDateTime;


/**
 * La classe principale.
 *
 * Tous les traitements demandés sont faits dans la mêthode
 * {@code repondreQuestions}.
 * Il serait plus logique d'écrire des méthodes qui pemettraient d'améliorer
 * la structuration et la réutilisation.  Cependant l'objectif est ici la
 * manipulation de l'API des collections, pas la structuration du code
 * en sous-programmes.
 */

public class Main {

	private static void repondreQuestions(Reader in) {
		Iterable<PointDeVente> iterable = PointDeVenteUtils.fromXML(in);

		// Construire un tableau associatif (pdvs) des points de vente avec un
		// accès par identifiant
		Map<Long, PointDeVente> pdvs = new HashMap<>();
		int i = 0;
		for (PointDeVente p:
			 iterable) {
			pdvs.put(p.getIdentifiant(), p);
			i += 1;
			if (i==50) {
				//break;
				continue;
			}
		}

		// Nombre de point de vente
		System.out.println( "Nombre de point de vente : " + pdvs.size() );

		// Afficher le nombre de services existants
		int nService = 0;
		for (PointDeVente p :
				pdvs.values()) {
			nService += p.getServices().size();
			//nService += p.getServices();
		}
		System.out.println( "Nombre de services existants : " + nService );

		// Afficher les services fournis
		Set<String> setService = new TreeSet<String>();
		for (PointDeVente p :
				pdvs.values()) {
			setService.addAll(p.getServices());
		}
		System.out.println( "Liste de services existants : " + setService );

		// Afficher la ville correspondant au point de vente d'identifiant
		// 31075001 et le prix du gazole le 25 janvier 2017 à 10h.
		System.out.println( "Prix : " + pdvs.get(31075001L).getPrix(Carburant.GAZOLE, LocalDateTime.parse("2017-01-25T10:00:00")));

		// Afficher le nombre de villes offrant au moins un point de vente
		Map<String, TreeSet<PointDeVente>> pdvv = new HashMap<>();
		for (PointDeVente p:
				pdvs.values()) {
			if (!pdvv.containsKey(p.getVille())) {
				pdvv.put(p.getVille(), new TreeSet<PointDeVente>());
			}
			pdvv.get(p.getVille()).add(p);
		}

		for (String ville :
				pdvv.keySet()) {
			if (pdvv.get(ville).size() != 0 ) {
				System.out.println(ville);
			}

		}

		// Afficher le nombre moyen de points de vente par ville


		// le nombre de villes offrants un certain nombre de carburants


		// Afficher le nombre et les points de vente dont le code postal est 31200


		// Nombre de PDV de la ville de Toulouse qui proposent et du Gazole
		// et du GPLc.


		// Afficher le nom et le nombre de points de vente des villes qui ont au
		// moins 20 points de vente
	}


	private static Reader ouvrir(String nomFichier)
			throws FileNotFoundException, IOException
	{
		if (nomFichier.endsWith(".zip")) {
			// On suppose que l'archive est bien formée :
			// elle contient fichier XML !
			ZipFile zfile = new ZipFile(nomFichier);
			ZipEntry premiere = zfile.entries().nextElement();
			return new InputStreamReader(zfile.getInputStream(premiere));
		} else {
			return new FileReader(nomFichier);
		}
	}


	public static void main(String[] args) {
		if (args.length != 1) {
			System.out.println("usage : java Main <fichier.xml ou fichier.zip>");
		} else {
			try (Reader in = ouvrir(args[0])) {
				repondreQuestions(in);
			} catch (FileNotFoundException e) {
				System.out.println("Fichier non trouvé : " + args[0]);
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
			System.out.println("OK");
		}
	}

}
