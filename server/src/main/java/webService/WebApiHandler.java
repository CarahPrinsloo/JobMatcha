package webService;

import com.fasterxml.jackson.databind.JsonNode;
import databaseInteraction.EducationDbConnect;
import databaseInteraction.UserDbConnect;
import databaseInteraction.WorkExperienceDbConnect;
import domain.Education;
import domain.User;
import domain.WorkExperience;
import io.javalin.http.Context;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

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
            addUserToDb(user);
            addWorkExperienceToDb(user, workExperience);
            addEducationToDb(user, education);

            context.status(201);
            return ;
        }
        context.status(400);
    }

    private void addEducationToDb(User user, List<Education> education) throws ClassNotFoundException, SQLException {
        educationDb = new EducationDbConnect();
        for(Education item : education) {
            educationDb.add(item.educationToDO(user.getEmail()));
        }
        educationDb.disconnect();
    }

    private void addWorkExperienceToDb(User user, List<WorkExperience> workExperience) throws ClassNotFoundException, SQLException {
        workExperienceDb = new WorkExperienceDbConnect();
        for(WorkExperience item : workExperience) {
            workExperienceDb.add(item.workExperienceToDO(user.getEmail()));
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
