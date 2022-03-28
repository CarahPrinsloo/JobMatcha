package orm.workExperience;

import net.lemnik.eodsql.BaseQuery;
import net.lemnik.eodsql.Select;
import net.lemnik.eodsql.Update;

import java.util.List;

public interface WorkExperienceDAI extends BaseQuery {
    @Select(
            "SELECT * FROM user_experience"
    )
    List<WorkExperienceDO> getAllUserWorkExperience();

    @Select(
            "SELECT * FROM user_experience w "
                    + "WHERE w.user_email = ?{1}"
    )
    List<WorkExperienceDO> getWorkExperience(String email);

    @Update(
            "INSERT INTO "+
                    "user_experience (business_name, start_year, end_year, user_email) "
                    + "VALUES (?{1.businessName}, ?{1.startYear}, ?{1.endYear}, ?{1.userEmail})"
    )
    void addWorkExperience(WorkExperienceDO user);

    @Update(
            "UPDATE user_experience "
                    + "SET business_name = ?{1.businessName}, "+
                    "start_year = ?{1.startYear}, "+
                    "end_year = ?{1.endYear}, "+
                    "user_email = ?{1.userEmail} "+
                    "WHERE user_email = ?{2} "+
                    "AND start_year = ?{3}"
    )
    void updateWorkExperience(WorkExperienceDO user, String currentEmail, String startYear);

    @Update("DELETE FROM user_experience")
    void deleteAll();
}
