package webService;

import com.fasterxml.jackson.databind.JsonNode;
import databaseInteraction.EducationDbConnect;
import databaseInteraction.UserDbConnect;
import databaseInteraction.WorkExperienceDbConnect;
import domain.Education;
import domain.User;
import domain.WorkExperience;
import io.javalin.http.Context;
import net.lemnik.eodsql.EoDException;
import orm.education.EducationDO;
import orm.user.UserDO;
import orm.workExperience.WorkExperienceDO;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.function.Predicate;

public class WebApiHandler {
    private static UserDbConnect userDb;
    private static WorkExperienceDbConnect workExperienceDb;
    private static EducationDbConnect educationDb;

    public void addUser(Context context) throws ClassNotFoundException, SQLException {
        JsonNode requestBody = context.bodyAsClass(JsonNode.class);

        User user = new User(
                requestBody.get("fullName").textValue(),
                requestBody.get("age").intValue(),
                requestBody.get("email").textValue(),
                requestBody.get("password").textValue(),
                requestBody.get("jobTitle").textValue(),
                requestBody.get("bio").textValue(),
                requestBody.get("image").textValue()
        );
        List<WorkExperience> workExperience = getWorkExperienceFromRequest(requestBody);
        List<Education> education = getEducationFromRequest(requestBody);

        if (workExperience != null && education != null) {
            try {
                addUserToDb(user);
                addWorkExperienceToDb(user.getEmail(), workExperience);
                addEducationToDb(user.getEmail(), education);

                context.status(201);
                return;
            } catch (EoDException ignore) {}
        }
        context.status(400);
    }

    public void getUser(Context context) throws ClassNotFoundException, SQLException {
        String emailAddress = context.pathParam("email");

        try {
            userDb = new UserDbConnect();
            UserDO userDO = userDb.get(emailAddress);
            userDb.disconnect();

            if (userDO != null) {
                workExperienceDb = new WorkExperienceDbConnect();
                List<WorkExperienceDO> workExperience = workExperienceDb.get(emailAddress);
                workExperienceDb.disconnect();

                educationDb = new EducationDbConnect();
                List<EducationDO> education = educationDb.get(emailAddress);
                educationDb.disconnect();

                context.json(
                        Map.of(
                                "fullName", userDO.getFullName(),
                                "age", userDO.getAge(),
                                "email", userDO.getEmail(),
                                "password", userDO.getPassword(),
                                "jobTitle", userDO.getJobTitle(),
                                "biography", userDO.getBiography(),
                                "image", userDO.getImage(),
                                "education", (education == null) ? new ArrayList<>() : education,
                                "workExperience", (workExperience == null) ? new ArrayList<>() : workExperience
                        )
                );
                context.status(200);
                return ;
            }
        } catch (EoDException ignore) {
            ignore.printStackTrace();
        }
        context.status(400);
    }

    public void getAllUsers(Context context) throws ClassNotFoundException, SQLException {
        userDb = new UserDbConnect();
        List<UserDO> users = userDb.getAll();
        userDb.disconnect();

        if (users == null) {
            context.status(500);
            return ;
        }

        List<Map<String, Object>> allUsers = new ArrayList<>();
        for (UserDO user: users) {
            educationDb = new EducationDbConnect();
            List<EducationDO> education = educationDb.get(user.getEmail());
            educationDb.disconnect();

            workExperienceDb = new WorkExperienceDbConnect();
            List<WorkExperienceDO> workExperience = workExperienceDb.get(user.getEmail());
            workExperienceDb.disconnect();

            allUsers.add(
                    Map.of(
                            "fullName", user.getFullName(),
                            "age", user.getAge(),
                            "email", user.getEmail(),
                            "password", user.getPassword(),
                            "jobTitle", user.getJobTitle(),
                            "biography", user.getBiography(),
                            "image", user.getImage(),
                            "education", (education == null) ? new ArrayList<>() : education,
                            "workExperience", (workExperience == null) ? new ArrayList<>() : workExperience
                    )
            );
        }
        context.json(allUsers);
        context.status(200);
    }

    private void addEducationToDb(String userEmail, List<Education> education) throws ClassNotFoundException, SQLException {
        educationDb = new EducationDbConnect();
        for (Education item : education) {
            educationDb.add(item.educationToDO(userEmail));
        }
        educationDb.disconnect();
    }

    private void addWorkExperienceToDb(String userEmail, List<WorkExperience> workExperience) throws ClassNotFoundException, SQLException {
        workExperienceDb = new WorkExperienceDbConnect();
        for (WorkExperience item : workExperience) {
            workExperienceDb.add(item.workExperienceToDO(userEmail));
        }
        workExperienceDb.disconnect();
    }

    private void addUserToDb(User user) throws ClassNotFoundException, SQLException {
        userDb = new UserDbConnect();
        userDb.add(user.userToDO());
        userDb.disconnect();
    }

    private List<WorkExperience> getWorkExperienceFromRequest(JsonNode requestBody) {
        List<WorkExperience> workExperience = new ArrayList<>();
        JsonNode userWorkExperienceJson = requestBody.get("workExperience");

        if (userWorkExperienceJson != null && userWorkExperienceJson.isArray()) {
            Iterator<JsonNode> itr = userWorkExperienceJson.iterator();
            while (itr.hasNext()) {
                JsonNode item = itr.next();
                workExperience.add(new WorkExperience(
                        item.get("businessName").textValue(),
                        item.get("startYear").textValue(),
                        item.get("endYear").textValue()
                ));
            }
        } else {
            //Not correct request format
            return null;
        }

        return workExperience;
    }

    private List<Education> getEducationFromRequest(JsonNode requestBody) {
        List<Education> education = new ArrayList<>();
        JsonNode userEducationJson = requestBody.get("education");

        if (userEducationJson != null && userEducationJson.isArray()) {
            Iterator<JsonNode> itr = userEducationJson.iterator();
            while (itr.hasNext()) {
                JsonNode item = itr.next();
                education.add(new Education(
                        item.get("institution").textValue(),
                        item.get("graduationYear").textValue()
                ));
            }
        } else {
            //Not correct request format
            return null;
        }

        return education;
    }
}
