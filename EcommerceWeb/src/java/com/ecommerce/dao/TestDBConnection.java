package com.ecommerce.dao;

import java.sql.Connection;

public class TestDBConnection {
    public static void main(String[] args) {
        try {
            Connection con = DatabaseConnection.getConnection();
            if (con != null && !con.isClosed()) {
                System.out.println("Database connected successfully!");
            } else {
                System.out.println("Database connection failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
