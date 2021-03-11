/**
 * AgendaAbstrait factorise la définition du nom et de l'accesseur associé.
 */
public abstract class AgendaAbstrait extends ObjetNomme implements Agenda {

	/**
	 * Initialiser le nom de l'agenda.
	 *
	 * @param nom le nom de l'agenda
	 * @throws IllegalArgumentException si nom n'a pas au moins un caractère
	 */
	public AgendaAbstrait(String nom) {
		super(nom);
	}

	/**
	 * Vérifier si un créneau est Valide.
	 *
	 * @param creneau un créneau de l'agenda
	 * @return vrai si le créneau est valide
	 * faux sinon
	 * @throws CreneauInvalideException Si le creneau n'est psa valide
	 */
	public void verifierCreneauValide(int creneau) throws CreneauInvalideException {
		/*
		if (CRENEAU_MIN<=creneau && creneau<=CRENEAU_MAX) {
			return true;
		} else {
			return false;
		}*/
		if  (!(CRENEAU_MIN<=creneau && creneau<=CRENEAU_MAX)) {
			throw new CreneauInvalideException();
		}
	}
	// ???


}
