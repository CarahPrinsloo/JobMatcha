package domain;

public class WorkExperience {
    private String businessName;
    private String graduationYear;

    public WorkExperience(String businessName, String graduationYear) {
        this.businessName = businessName;
        this.graduationYear = graduationYear;
    }

    public String getBusinessName() {
        return businessName;
    }

    public String getGraduationYear() {
        return graduationYear;
    }
}
