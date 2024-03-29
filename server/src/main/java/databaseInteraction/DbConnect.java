package databaseInteraction;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class DbConnect {
    private Connection connection;
    private String userDbFilename;
    private String dbUrl;

    DbConnect(String databaseFileName) throws ClassNotFoundException {
        Class.forName("org.sqlite.JDBC");

        userDbFilename = System.getProperty("user.dir") + databaseFileName;
        setDbUrl();
        this.connection = setConnection();
    }

    private void setDbUrl() {
        File dbFile = new File(userDbFilename);
        if (dbFile.exists()) {
            String DISK_DB_URL = "jdbc:sqlite:";
            dbUrl = DISK_DB_URL + userDbFilename;
        } else {
            throw new IllegalArgumentException("Database file " + userDbFilename + " not found.");
        }
    }

    private Connection setConnection() {
        try {
            return DriverManager.getConnection(dbUrl);
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    public void disconnect() throws SQLException {
        connection.close();
    }

    public Connection getConnection() {
        return connection;
    }
}
