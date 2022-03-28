package databaseInteraction;

import net.lemnik.eodsql.EoDException;
import net.lemnik.eodsql.QueryTool;
import orm.user.UserDAI;
import orm.user.UserDO;

import java.util.List;

public class UserDbConnect extends DbConnect {
    private final UserDAI userQuery;

    public UserDbConnect(String databaseFilename) throws ClassNotFoundException {
        super(databaseFilename);
        userQuery = QueryTool.getQuery(this.getConnection(), UserDAI.class);
    }

    /**
     * Get a user by email.
     * @param email the email of the user
     * @return a UserDO
     */
    public UserDO get(String email) {
        return userQuery.getUser(email);
    }

    /**
     * Add a single user to the database.
     * @param user the user to add
     */
    public void add(UserDO user) {
        userQuery.addUser(user);
    }

    /**
     * Update a single user in the database.
     * @param user the user to add
     * @param currentUserEmail the email of the user to update
     * @return true if the user information was updated
     */
    public void update(UserDO user, String currentUserEmail) {
        userQuery.updateUser(user, currentUserEmail);
    }

    public List<UserDO> getAll() {
        try {
            return userQuery.getAllUsers();
        } catch (EoDException e) {
            e.printStackTrace();
            return null;
        }
    }

    public void deleteAll() {
        try {
            userQuery.deleteAll();
        } catch (EoDException ignore) {}
    }
}
