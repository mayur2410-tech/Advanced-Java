import java.sql.Statement;
import java.util.Properties;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;

public class Main {

    public static void main(String[] args) throws Exception {

     Properties props = new Properties();
props.load(new FileInputStream("db.properties"));

String url = props.getProperty("db.url");
String user = props.getProperty("db.user");
String pass = props.getProperty("db.password");
         
        try {
             Connection conn = DriverManager.getConnection(url,user,pass) ;
         System.out.println("Connected to DB!");

         //query to create the table 

         String sql = "CREATE TABLE IF NOT EXISTS employees (" +
                      "id INT AUTO_INCREMENT PRIMARY KEY," +
                      "name VARCHAR(200) NOT NULL," + 
                      "department VARCHAR(50) NOT NULL," + 
                      "salary DOUBLE )";

        // STATEMNent object 
        Statement stmt = conn.createStatement();
        stmt.executeUpdate(sql);
        System.out.println("Table creates Successfully");




        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

       
    }
}