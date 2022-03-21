package domain;

public class Education {
    private String institution;
    private String startYear;
    private String endYear;

    public Education(String institution, String startYear, String endYear) {
        this.institution = institution;
        this.startYear = startYear;
        this.endYear = endYear;
    }

    public String getInstitution() {
        return institution;
    }

    public String getStartYear() {
        return startYear;
    }

    public String getEndYear() {
        return endYear;
    }
}
