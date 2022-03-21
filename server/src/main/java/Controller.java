import databaseInteraction.UserDbConnect;
import webService.WebApiServer;

import java.sql.SQLException;
import java.util.Scanner;

public class Controller {
    private static Scanner in;
    private static UserDbConnect db;

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        in = new Scanner(System.in);
        db = new UserDbConnect();

        WebApiServer server = new WebApiServer();
        server.start(8080);

        System.out.println(
                "Listening on port 8080.\n"+
                "To terminate the program - enter the 'exit' command."
        );

        while (in.hasNextLine()) {
            if (in.nextLine().equalsIgnoreCase("exit")) break;
        }

        db.disconnect();
        server.stop();
    }
}
