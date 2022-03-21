package orm.workExperience;

import net.lemnik.eodsql.ResultColumn;

public class WorkExperienceDO {
    @ResultColumn(value = "user_experience_id")
    public int id;

    @ResultColumn( value = "business_name" )
    public String businessName;

    @ResultColumn( value = "start_year" )
    public String startYear;

    @ResultColumn( value = "end_year" )
    public String endYear;

    @ResultColumn( value = "user_email" )
    public String userEmail;

    public WorkExperienceDO() {}

    public WorkExperienceDO(String businessName, String startYear, String endYear, String userEmail) {
        this.businessName = businessName;
        this.startYear = startYear;
        this.endYear = endYear;
        this.userEmail = userEmail;
    }

    public int getId() {
        return id;
    }

    public String getBusinessName() {
        return businessName;
    }

    public String getStartYear() {
        return startYear;
    }

    public String getEndYear() {
        return endYear;
    }

    public String getUserEmail() {
        return userEmail;
    }

    @ResultColumn(value = "user_experience_id")
    public void setId(int id) {
        this.id = id;
    }

    @ResultColumn( value = "business_name" )
    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    @ResultColumn( value = "start_year" )
    public void setStartYear(String startYear) {
        this.startYear = startYear;
    }

    @ResultColumn( value = "end_year" )
    public void setEndYear(String endYear) {
        this.endYear = endYear;
    }

    @ResultColumn( value = "user_email" )
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
}
