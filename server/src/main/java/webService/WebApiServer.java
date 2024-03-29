package webService;

import io.javalin.Javalin;

public class WebApiServer {
    private final Javalin server;

    public WebApiServer() {
        server = Javalin.create(config -> {
            config.defaultContentType = "application/json";
        });
        WebApiHandler apiHandler = new WebApiHandler();

        this.server.post("/user", context -> apiHandler.addUser(context));
        this.server.get("/user/{email}", context -> apiHandler.getUser(context));
        this.server.get("/users", context -> apiHandler.getAllUsers(context));
    }

    public WebApiServer(String databaseFileName) {
        server = Javalin.create(config -> {
            config.defaultContentType = "application/json";
        });
        WebApiHandler apiHandler = new WebApiHandler();
        apiHandler.setDatabaseFileName(databaseFileName);

        this.server.post("/user", context -> apiHandler.addUser(context));
        this.server.get("/user/{email}", context -> apiHandler.getUser(context));
        this.server.get("/users", context -> apiHandler.getAllUsers(context));
    }

    public void start(int port) {
        this.server.start(port);
    }

    public void stop() {
        this.server.stop();
    }
}
