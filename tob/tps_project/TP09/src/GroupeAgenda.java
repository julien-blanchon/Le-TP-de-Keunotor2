import java.util.ArrayList;
import java.util.List;

public class GroupeAgenda extends AgendaAbstrait {

    /** La liste des agendas. */
    private List<Agenda> tabAgendas;

    /**
     * Initialiser le nom du groupe d'agenda.
     *
     * @param nom le nom du groupe d'agenda
     * @throws IllegalArgumentException si nom n'a pas au moins un caractère
     */
    public GroupeAgenda(String nom) {
        super(nom);
        tabAgendas = new ArrayList<>();
    }

    @Override
    public void enregistrer(int creneau, String rdv) throws OccupeException {
        verifierCreneauValide(creneau);
        if (rdv == null || rdv.length() <= 1) {
            throw new IllegalArgumentException();
        }
        for (Agenda agenda : tabAgendas) {
            try {
                agenda.getRendezVous(creneau);
                throw new OccupeException(); // Le creneau n'est pas libre !
            } catch (LibreException e) {
                continue; // Le creneau est libre !
            }
        }
        for (Agenda agenda : tabAgendas) {
            agenda.enregistrer(creneau, rdv);
        }

    }

    @Override
    public boolean annuler(int creneau) {
        return false;
    }

    @Override
    public String getRendezVous(int creneau) throws LibreException {
        verifierCreneauValide(creneau);
        boolean isFirst = true;
        boolean isNull = false;
        String rdv = null;
        for (Agenda agenda : tabAgendas) {
            try {
                if (isFirst) {
                    rdv = agenda.getRendezVous(creneau);
                    isFirst = false;
                } else {
                    if (rdv==agenda.getRendezVous(creneau)) {
                        continue;
                    } else{
                        return null;
                    }
                }
            } catch (LibreException e) {
                isNull = true;
                if (rdv!=null) {
                    return null;
                }
            }
        }
        if (rdv==null) {
            throw new LibreException();
        }
        if (isNull) {
            return null;
        }
        return rdv;
    }

    public void ajouter(Agenda agenda) {
        if (agenda==null) {
            throw new NullPointerException();
        }
        this.tabAgendas.add(agenda);
    }
}
