/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package medac.practica_intermodular;

/**
 * Esta clase se encarga de gestionar la conexión a la base de datos.
 * Proporciona un método estático para obtener una conexión a la base de datos MySQL.
 * 
 * @author Jose Rivas Ceacero
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
     * Obtiene una conexión a la base de datos MySQL.
     * 
     */ 
public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/Practica_Intermodular";
    private static final String USER = "root";
    private static final String PASSWORD = "Med@c";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

