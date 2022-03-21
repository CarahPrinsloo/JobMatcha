import webService.WebApiServer;

import java.util.Scanner;

public class Controller {
    private static Scanner in;

    public static void main(String[] args) {
        in = new Scanner(System.in);

        WebApiServer server = new WebApiServer();
        server.start(8080);

        System.out.println(
                "Listening on port 8080.\n"+
                "To terminate the program - enter the 'exit' command."
        );

        while (in.hasNextLine()) {
            if (in.nextLine().equalsIgnoreCase("exit")) break;
        }

        server.stop();
    }
}
