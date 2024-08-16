<%-- 
    Document   : services.jsp
    Created on : 16-Apr-2024, 12:51:57 am
    Author     : admin
--%>
<%@ page import="java.sql.*, java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Royal Hotel - services</title>

        <%@include file="all_components/allcss.jsp"%>
    </head>
    <body>
        <%@include file="all_components/navbar.jsp"%>

        <section class="services top">
            <div class="container p-4">
                <div class="heading text-center">
                    <h1>Our Facilities</h1>
                    <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt</p>
                </div>


                <div class="content flex_space">
                    <div class="left grid2">
                    <%
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rset = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234");

                            String selectQuery = "SELECT * FROM facilities";
                            ps = con.prepareStatement(selectQuery);

                            rset = ps.executeQuery();
                           while (rset.next()) {
                                    String name = rset.getString("name");
                                    String icon = rset.getString("icon");
                    %>

                        
                        <div class="box shadow rounded">
                            <div class="text">
                                <img src="<%= icon %>" />
                                <h3><%= name %></h3>
                            </div>
                        </div>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rset != null) rset.close();
                                if (ps != null) ps.close();
                                if (con != null) con.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                        <div class="box shadow rounded">
                            <div class="text">
                                <img src="img/service1.svg" />
                                <h3>Delicious Food</h3>
                            </div>
                        </div>
                        <div class="box shadow rounded">
                            <div class="text">
                                <img src="img/sr2.svg" />
                                <h3>Fitness  </h3>
                            </div>
                        </div>
                        <div class="box shadow rounded">
                            <div class="text">
                                <img src="img/sr2.svg" />
                                <h3>Fitness  </h3>
                            </div>
                        </div>
                        <div class="box shadow rounded">
                            <div class="text">
                                <img src="img/sr2.svg" />
                                <h3>Fitness  </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>













        <script src="https://kit.fontawesome.com/032d11eac3.js" crossorigin="anonymous"></script>


        <%@include file="all_components/footer.jsp"%>
    </body>
</html>
