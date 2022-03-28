import databaseInteraction.EducationDbConnect;
import databaseInteraction.UserDbConnect;
import databaseInteraction.WorkExperienceDbConnect;
import domain.Education;
import domain.User;
import domain.WorkExperience;
import kong.unirest.HttpResponse;
import kong.unirest.JsonNode;
import kong.unirest.Unirest;
import kong.unirest.UnirestException;
import org.junit.jupiter.api.*;
import orm.education.EducationDO;
import orm.user.UserDO;
import orm.workExperience.WorkExperienceDO;
import webService.WebApiServer;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class WebApiTests {
    private static WebApiServer server;

    private final String PATH = "http://localhost:5000";
    private final String DATABASE_FILENAME = "/database/test_db.sqlite";
    private final User USER = new User(
            "Dummy One",
            24,
            "dummy@gmail.com",
            "password",
            "Backend Software Developer",
            "Something interesting about me.",
            UUID.randomUUID().toString()
    );
    private final WorkExperience WORK_EXPERIENCE = new WorkExperience(
            "Food Hyper",
            "2019",
            "2022"
    );
    private final Education EDUCATION = new Education(
            "Fly High School",
            "2017"
    );

    @BeforeAll
    public static void startServer() {
        server = new WebApiServer("/database/test_db.sqlite");
        server.start(5000);
    }

    @AfterAll
    public static void stopServer() {
        server.stop();
    }

    @Test
    @DisplayName("POST /user")
    public void addUserWithExperienceAndEducation() throws UnirestException, ClassNotFoundException, SQLException {
        Map<String, Object> jsonRequest = createCreateUserRequest(USER, WORK_EXPERIENCE, EDUCATION);
        HttpResponse<JsonNode> response = Unirest.post(PATH + "/user")
                .body(jsonRequest)
                .asJson();

        Assertions.assertEquals(201, response.getStatus());
        assertUser(USER, getUserFromDb(USER.getEmail()));
        assertWorkExperience(WORK_EXPERIENCE, getWorkExperienceFromDb(USER.getEmail()).get(0));
        assertEducation(EDUCATION, getEducationFromDb(USER.getEmail()).get(0));

        clearAllDbTables();
    }

    @Test
    @DisplayName("POST /user")
    public void addUserWithNoExperienceNorEducation() throws UnirestException, ClassNotFoundException, SQLException {
        Map<String, Object> jsonRequest = createCreateUserRequest(USER, null, null);
        HttpResponse<JsonNode> response = Unirest.post(PATH + "/user")
                .body(jsonRequest)
                .asJson();

        Assertions.assertEquals(201, response.getStatus());
        assertUser(USER, getUserFromDb(USER.getEmail()));

        clearAllDbTables();
    }

    @Test
    @DisplayName("GET /user/{email}")
    public void getExistingUser() throws UnirestException, ClassNotFoundException, SQLException {
        Map<String, Object> jsonRequest = createCreateUserRequest(USER, WORK_EXPERIENCE, EDUCATION);
        HttpResponse<JsonNode> createUserResponse = Unirest.post(PATH + "/user")
                .body(jsonRequest)
                .asJson();

        Assertions.assertEquals(201, createUserResponse.getStatus());
        assertUser(USER, getUserFromDb(USER.getEmail()));
        assertWorkExperience(WORK_EXPERIENCE, getWorkExperienceFromDb(USER.getEmail()).get(0));
        assertEducation(EDUCATION, getEducationFromDb(USER.getEmail()).get(0));

        HttpResponse<JsonNode> getUserResponse = Unirest.get(PATH + "/user/" + USER.getEmail())
                .asJson();

        Assertions.assertEquals(200, getUserResponse.getStatus());

        clearAllDbTables();
    }

    @Test
    @DisplayName("GET /user/{email}")
    public void getNonExistingUser() throws UnirestException {
        HttpResponse<JsonNode> getUserResponse = Unirest.get(PATH + "/user/" + USER.getEmail())
                .asJson();

        Assertions.assertEquals(400, getUserResponse.getStatus());
    }

    @Test
    @DisplayName("GET /users")
    public void getAllUsers() throws UnirestException, ClassNotFoundException, SQLException {
        Map<String, Object> jsonRequest = createCreateUserRequest(USER, WORK_EXPERIENCE, EDUCATION);
        HttpResponse<JsonNode> createUserResponse = Unirest.post(PATH + "/user")
                .body(jsonRequest)
                .asJson();

        Assertions.assertEquals(201, createUserResponse.getStatus());
        assertUser(USER, getUserFromDb(USER.getEmail()));
        assertWorkExperience(WORK_EXPERIENCE, getWorkExperienceFromDb(USER.getEmail()).get(0));
        assertEducation(EDUCATION, getEducationFromDb(USER.getEmail()).get(0));

        HttpResponse<JsonNode> getUsersResponse = Unirest.get(PATH + "/users/")
                .asJson();

        Assertions.assertEquals(200, getUsersResponse.getStatus());

        clearAllDbTables();
    }

    private UserDO getUserFromDb(String email) throws ClassNotFoundException, SQLException {
        UserDbConnect userDb = new UserDbConnect(DATABASE_FILENAME);
        UserDO user = userDb.get(email);
        userDb.disconnect();
        return user;
    }

    private List<WorkExperienceDO> getWorkExperienceFromDb(String email) throws ClassNotFoundException, SQLException {
        WorkExperienceDbConnect workExperienceDb = new WorkExperienceDbConnect(DATABASE_FILENAME);
        List<WorkExperienceDO> workExperience = workExperienceDb.get(email);
        workExperienceDb.disconnect();
        return workExperience;
    }

    private List<EducationDO> getEducationFromDb(String email) throws ClassNotFoundException, SQLException {
        EducationDbConnect educationDb = new EducationDbConnect(DATABASE_FILENAME);
        List<EducationDO> education = educationDb.get(email);
        educationDb.disconnect();
        return education;
    }

    private void clearAllDbTables() throws ClassNotFoundException, SQLException {
        UserDbConnect userDb = new UserDbConnect(DATABASE_FILENAME);
        userDb.deleteAll();
        userDb.disconnect();

        WorkExperienceDbConnect workExperienceDb = new WorkExperienceDbConnect(DATABASE_FILENAME);
        workExperienceDb.deleteAll();
        workExperienceDb.disconnect();

        EducationDbConnect educationDb = new EducationDbConnect(DATABASE_FILENAME);
        educationDb.deleteAll();
        workExperienceDb.disconnect();
    }

    private void assertUser(User expected, UserDO user) {
        if (expected == null) return;

        Assertions.assertNotNull(user);
        Assertions.assertEquals(expected.getFullName(), user.getFullName());
        Assertions.assertEquals(expected.getEmail(), user.getEmail());
        Assertions.assertEquals(expected.getAge(), user.getAge());
        Assertions.assertEquals(expected.getPassword(), user.getPassword());
        Assertions.assertEquals(expected.getJobTitle(), user.getJobTitle());
        Assertions.assertEquals(expected.getBiography(), user.getBiography());
        Assertions.assertEquals(expected.getImage(), user.getImage());
    }

    private void assertWorkExperience(WorkExperience expected, WorkExperienceDO workExperience) {
        if (expected == null) return;

        Assertions.assertNotNull(workExperience);
        Assertions.assertEquals(expected.getBusinessName(), workExperience.getBusinessName());
        Assertions.assertEquals(expected.getStartYear(), workExperience.getStartYear());
        Assertions.assertEquals(expected.getEndYear(), workExperience.getEndYear());
    }

    private void assertEducation(Education expected, EducationDO education) {
        if (expected == null) return;

        Assertions.assertNotNull(education);
        Assertions.assertEquals(expected.getGraduationYear(), education.getGraduationYear());
        Assertions.assertEquals(expected.getInstitution(), education.getInstitution());
    }

    private Map<String, Object> createCreateUserRequest(User user, WorkExperience workExperience, Education education) {
        List<Map<String, Object>> jsonWorkExperience = (workExperience == null)
                ? new ArrayList<>()
                : List.of(Map.of(
                "businessName", workExperience.getBusinessName(),
                "startYear", workExperience.getStartYear(),
                "endYear", workExperience.getEndYear()
        ));
        List<Map<String, Object>> jsonEducation = (education == null)
                ? new ArrayList<>()
                : List.of(Map.of(
                "institution", education.getInstitution(),
                "graduationYear", education.getGraduationYear()
        ));

        return Map.of(
                "fullName", user.getFullName(),
                "age", user.getAge(),
                "email", user.getEmail(),
                "password", user.getPassword(),
                "jobTitle", user.getJobTitle(),
                "bio", user.getBiography(),
                "image", user.getImage(),
                "workExperience", jsonWorkExperience,
                "education", jsonEducation
        );
    }

}
