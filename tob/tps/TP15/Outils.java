import java.util.Collection;
import java.util.Collections;
import java.util.List;

/** Quelques outils (méthodes) sur les listes.  */
public class Outils {

	/** Retourne vrai ssi tous les éléments de la collection respectent le critère. */
	public static <E, F> boolean tous(
			List<E> elements,
			Critere<F> critere)
	{
		for (E e:
			 elements) {
			if (!critere.satisfaitSur(((F) e))) return false;
		}
		return true;
	}


	/** Ajouter dans resultat tous les éléments de la source
	 * qui satisfont le critère aGarder.
	 */
	public static <E> void filtrer(
			List<? extends E> source,
			Critere<E> aGarder,
			List<? super E> resultat)
	{
		for (E e:
				source) {
			if (aGarder.satisfaitSur((e))) {
				resultat.add(e);
			}
		}
	}


}
