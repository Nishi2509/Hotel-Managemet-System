package hotel; // Assuming your package is named "hotel"

public class Facility {
    private int id;
    private String name;

    // Constructor
    public Facility(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getters and setters (if needed)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
