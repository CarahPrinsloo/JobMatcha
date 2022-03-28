package orm.user;

import net.lemnik.eodsql.BaseQuery;
import net.lemnik.eodsql.Select;
import net.lemnik.eodsql.Update;

import java.util.List;

public interface UserDAI extends BaseQuery {
    @Select(
            "SELECT * FROM users"
    )
    List<UserDO> getAllUsers();

    @Select(
            "SELECT * FROM users u "
                    + "WHERE u.user_email = ?{1}"
    )
    UserDO getUser(String email);

    @Update(
            "INSERT INTO "+
                    "users (user_fullname, user_age, user_email, user_password, user_job_title, user_biography, user_image) "
                    + "VALUES (?{1.fullName}, ?{1.age}, ?{1.email}, ?{1.password}, ?{1.jobTitle}, ?{1.biography}, ?{1.image})"
    )
    void addUser(UserDO user);

    @Update(
            "UPDATE users "
                    + "SET user_fullname = ?{1.fullName}, "+
                    "user_age = ?{1.age}, "+
                    "user_email = ?{1.email}, "+
                    "user_password = ?{1.password}, "+
                    "user_job_title = ?{1.jobTitle}, "+
                    "user_biography = ?{1.biography}, "+
                    "user_image = ?{1.image} "+
                    "WHERE user_email = ?{2}"
    )
    void updateUser(UserDO user, String currentEmail);

    @Update("DELETE FROM users")
    void deleteAll();
}
