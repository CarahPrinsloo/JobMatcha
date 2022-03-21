package domain;

import orm.user.UserDO;

public class User {
    public String fullName;
    public int age;
    public String email;
    public String password;
    public String jobTitle;
    public String biography;
    public String image;


    public User(String fullName, int age, String email, String password, String jobTitle, String biography, String image) {
        this.fullName = fullName;
        this.age = age;
        this.email = email;
        this.password = password;
        this.jobTitle = jobTitle;
        this.biography = biography;
        this.image = image;
    }

    private User DAOToUser(UserDO userDAO) throws ClassNotFoundException {
        return new User(
                fullName,
                age,
                email,
                password,
                jobTitle,
                biography,
                image
        );
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

    public void setFirstName(String fullName) {
        this.fullName = fullName;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public void setBiography(String biography) {
        this.biography = biography;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
