package databaseInteraction;

import net.lemnik.eodsql.QueryTool;
import orm.workExperience.WorkExperienceDAI;
import orm.workExperience.WorkExperienceDO;

import java.util.List;

public class WorkExperienceDbConnect extends DbConnect {
    private final WorkExperienceDAI workExperienceQuery;

    public WorkExperienceDbConnect() throws ClassNotFoundException {
        workExperienceQuery = QueryTool.getQuery(this.getConnection(), WorkExperienceDAI.class);
    }

    /**
     * Gets a list of the user's work experience.
     * @param email the email of the user
     * @return a List of UserDO
     */
    public List<WorkExperienceDO> get(String email) {
        return workExperienceQuery.getWorkExperience(email);
    }

    /**
     * Add a single user to the database.
     * @param workExperience the user to add
     */
    public void add(WorkExperienceDO workExperience) {
        workExperienceQuery.addWorkExperience(workExperience);
    }

    /**
     * Update a single work experience entry in the database.
     * @param workExperience the work experience to add
     * @param currentUserEmail the email of the user whose work experience entry needs to be updated
     * @param startYear the work experience start year
     */
    public void update(WorkExperienceDO workExperience, String currentUserEmail, String startYear) {
        workExperienceQuery.updateWorkExperience(workExperience, currentUserEmail, startYear);
    }
}
