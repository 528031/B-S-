<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%
    // 获取表单数据
    String originalId = request.getParameter("original_id");
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String ageStr = request.getParameter("age");
    String address = request.getParameter("address");
    String salaryStr = request.getParameter("salary");
    
    // 验证数据
    if (id == null || name == null || id.trim().isEmpty() || name.trim().isEmpty()) {
        response.sendRedirect("customers.jsp?msg=invalid_data");
        return;
    }
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        // 数据库连接
        Class.forName("org.postgresql.Driver");
        String url = "jdbc:postgresql://127.0.0.1:5432/shiyan3";
        String user = "postgres";
        String pass = "528031";
        
        conn = DriverManager.getConnection(url, user, pass);
        
        // 更新数据
        String sql = "UPDATE customers SET name = ?, age = ?, address = ?, salary = ? WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        
        if(ageStr != null && !ageStr.isEmpty()) {
            pstmt.setInt(2, Integer.parseInt(ageStr));
        } else {
            pstmt.setNull(2, java.sql.Types.INTEGER);
        }
        
        pstmt.setString(3, address);
        
        if(salaryStr != null && !salaryStr.isEmpty()) {
            pstmt.setDouble(4, Double.parseDouble(salaryStr));
        } else {
            pstmt.setNull(4, java.sql.Types.NUMERIC);
        }
        
        pstmt.setString(5, originalId);
        
        int result = pstmt.executeUpdate();
        
        if(result > 0) {
            // 更新成功，重定向到客户列表
            response.sendRedirect("customers.jsp?msg=edit_success");
        } else {
            response.sendRedirect("customers_edit.jsp?id=" + originalId + "&msg=edit_failed");
        }
        
    } catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("customers_edit.jsp?id=" + originalId + "&msg=error&error=" + e.getMessage());
    } finally {
        if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
        if(conn != null) try { conn.close(); } catch(SQLException e) {}
    }
%>