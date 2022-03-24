package databaseInteraction;

import net.lemnik.eodsql.EoDException;
import net.lemnik.eodsql.QueryTool;
import orm.education.EducationDAI;
import orm.education.EducationDO;
import orm.user.UserDO;

import java.util.List;

public class EducationDbConnect extends DbConnect {
    private final EducationDAI educationQuery;

    public EducationDbConnect() throws ClassNotFoundException {
        educationQuery = QueryTool.getQuery(this.getConnection(), EducationDAI.class);
    }

    /**
     * Gets a list of the user's education entries.
     * @param email the email of the user
     * @return a List of EducationDO
     */
    public List<EducationDO> get(String email) {
        try {
            return educationQuery.getEducation(email);
        } catch (EoDException e) {
            return null;
        }
    }

    /**
     * Add a single education entry to the database.
     * @param education the education entry to add
     */
    public void add(EducationDO education) {
        educationQuery.addEducation(education);
    }

    /**
     * Update a single education entry in the database.
     * @param education the education to add
     * @param currentUserEmail the email of the user whose education entry needs to be updated
     * @param graduationYear the education graduation year
     */
    public void update(EducationDO education, String currentUserEmail, String graduationYear) {
        educationQuery.updateEducation(education, currentUserEmail, graduationYear);
    }

    public List<EducationDO> getAll() {
        try {
            return educationQuery.getAllUserEducation();
        } catch (EoDException e) {
            e.printStackTrace();
            return null;
        }
    }
}
