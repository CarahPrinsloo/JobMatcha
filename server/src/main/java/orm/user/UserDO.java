package orm.user;

import net.lemnik.eodsql.ResultColumn;

import java.sql.Blob;

public class UserDO {
    @ResultColumn(value = "user_id")
    public int id;

    @ResultColumn( value = "user_fullname" )
    public String fullName;

    @ResultColumn( value = "user_age" )
    public int age;

    @ResultColumn( value = "user_email" )
    public String email;

    @ResultColumn( value = "user_password" )
    public String password;

    @ResultColumn( value = "user_job_title" )
    public String jobTitle;

    @ResultColumn( value = "user_biography" )
    public String biography;

    @ResultColumn( value = "user_image" )
    public String image;

    public UserDO() {}

    public UserDO(String fullName, int age, String email, String password, String jobTitle, String biography, String image) {
        this.fullName = fullName;
        this.age = age;
        this.email = email;
        this.password = password;
        this.jobTitle = jobTitle;
        this.biography = biography;
        this.image = image;
    }

    public String getFullName() {
        return fullName;
    }

    public int getAge() {
        return age;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public String getBiography() {
        return biography;
    }

    public String getImage() {
        return image;
    }

    @ResultColumn(value = "user_fullname")
    public void setFirstName(String fullName) {
        this.fullName = fullName;
    }

    @ResultColumn(value = "user_age")
    public void setAge(int age) {
        this.age = age;
    }

    @ResultColumn(value = "user_email")
    public void setEmail(String email) {
        this.email = email;
    }

    @ResultColumn(value = "user_password")
    public void setPassword(String password) {
        this.password = password;
    }

    @ResultColumn(value = "user_job_title")
    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    @ResultColumn(value = "user_biography")
    public void setBiography(String biography) {
        this.biography = biography;
    }

    @ResultColumn(value = "user_image")
    public void setImage(String image) {
        this.image = image;
    }
}
