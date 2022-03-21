package orm.education;

import net.lemnik.eodsql.ResultColumn;

public class EducationDO {
    @ResultColumn(value = "user_education_id")
    public int id;

    @ResultColumn( value = "institution" )
    public String institution;

    @ResultColumn( value = "graduation_year" )
    public String graduationYear;

    @ResultColumn( value = "user_email" )
    public String userEmail;

    public EducationDO() {}

    public EducationDO(String institution, String graduationYear, String email) {
        this.institution = institution;
        this.graduationYear = graduationYear;
        this.userEmail = email;
    }

    public int getId() {
        return id;
    }

    public String getInstitution() {
        return institution;
    }

    public String getGraduationYear() {
        return graduationYear;
    }

    public String getUserEmail() {
        return userEmail;
    }

    @ResultColumn(value = "user_education_id")
    public void setId(int id) {
        this.id = id;
    }

    @ResultColumn( value = "institution" )
    public void setInstitution(String institution) {
        this.institution = institution;
    }

    @ResultColumn( value = "graduation_year" )
    public void setGraduationYear(String graduationYear) {
        this.graduationYear = graduationYear;
    }

    @ResultColumn( value = "user_email" )
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
}
