package orm.education;

import net.lemnik.eodsql.BaseQuery;
import net.lemnik.eodsql.Select;
import net.lemnik.eodsql.Update;

import java.util.List;

public interface EducationDAI extends BaseQuery {
    @Select(
            "SELECT * FROM user_education"
    )
    List<EducationDO> getAllUserEducation();

    @Select(
            "SELECT * FROM user_education e "
                    + "WHERE e.user_email = ?{1}"
    )
    List<EducationDO> getEducation(String email);

    @Update(
            "INSERT INTO "+
                    "user_education (institution, graduation_year, user_email) "
                    + "VALUES (?{1.institution}, ?{1.graduationYear}, ?{1.userEmail})"
    )
    void addEducation(EducationDO user);

    @Update(
            "UPDATE user_education "
                    + "SET institution = ?{1.institution}, "+
                    "graduation_year = ?{1.graduationYear}, "+
                    "user_email = ?{1.userEmail} "+
                    "WHERE user_email = ?{2} "+
                    "AND graduation_year = ?{3}"
    )
    void updateEducation(EducationDO user, String currentEmail, String graduationYear);

    @Update("DELETE FROM user_education")
    void deleteAll();
}
