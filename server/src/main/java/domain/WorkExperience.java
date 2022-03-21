package domain;

import orm.workExperience.WorkExperienceDO;

public class WorkExperience {
    private String businessName;
    private String startYear;
    private String endYear;

    public WorkExperience(String businessName, String startYear, String endYear) {
        this.businessName = businessName;
        this.startYear = startYear;
        this.endYear = endYear;
    }

    public WorkExperienceDO workExperienceToDO(String userEmail) {
        return new WorkExperienceDO(
                businessName,
                startYear,
                endYear,
                userEmail
        );
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
}
