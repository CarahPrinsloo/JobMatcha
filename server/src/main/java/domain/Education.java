package domain;

import orm.education.EducationDO;

public class Education {
    private String institution;
    private String graduationYear;

    public Education(String institution, String graduationYear) {
        this.institution = institution;
        this.graduationYear = graduationYear;
    }

    public EducationDO educationToDO(String userEmail) {
        return new EducationDO(
                institution,
                graduationYear,
                userEmail
        );
    }

    public String getInstitution() {
        return institution;
    }

    public String getGraduationYear() {
        return graduationYear;
    }
}
