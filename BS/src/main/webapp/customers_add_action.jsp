<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%
    // 获取表单数据
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String ageStr = request.getParameter("age");
    String address = request.getParameter("address");
    String salaryStr = request.getParameter("salary");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        // 数据库连接
        Class.forName("org.postgresql.Driver");
        String url = "jdbc:postgresql://127.0.0.1:5432/shiyan3";
        String user = "postgres";
        String pass = "528031";
        
        conn = DriverManager.getConnection(url, user, pass);
        
        // 插入数据
        String sql = "INSERT INTO customers (id, name, age, address, salary) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, name);
        
        if(ageStr != null && !ageStr.isEmpty()) {
            pstmt.setInt(3, Integer.parseInt(ageStr));
        } else {
            pstmt.setNull(3, java.sql.Types.INTEGER);
        }
        
        pstmt.setString(4, address);
        
        if(salaryStr != null && !salaryStr.isEmpty()) {
            pstmt.setDouble(5, Double.parseDouble(salaryStr));
        } else {
            pstmt.setNull(5, java.sql.Types.NUMERIC);
        }
        
        int result = pstmt.executeUpdate();
        
        if(result > 0) {
            // 添加成功，重定向到客户列表
            response.sendRedirect("customers.jsp?msg=add_success");
        } else {
            response.sendRedirect("customers_add.jsp?msg=add_failed");
        }
        
    } catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("customers_add.jsp?msg=error&error=" + e.getMessage());
    } finally {
        if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
        if(conn != null) try { conn.close(); } catch(SQLException e) {}
    }
%>