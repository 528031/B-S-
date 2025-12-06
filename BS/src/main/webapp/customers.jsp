<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>客户信息管理系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        header {
            background: linear-gradient(90deg, #4b6cb7 0%, #182848 100%);
            color: white;
            padding: 25px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .logo i {
            font-size: 28px;
        }
        
        .logo h1 {
            font-size: 24px;
            font-weight: 600;
        }
        
        .header-actions {
            display: flex;
            gap: 15px;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            font-size: 14px;
        }
        
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #3d8b40;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .btn-secondary {
            background-color: #2196F3;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #0b7dda;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .stats {
            display: flex;
            background-color: #f8f9fa;
            padding: 20px 30px;
            border-bottom: 1px solid #eaeaea;
        }
        
        .stat-card {
            flex: 1;
            text-align: center;
            padding: 15px;
        }
        
        .stat-card h3 {
            font-size: 28px;
            color: #4b6cb7;
            margin-bottom: 5px;
        }
        
        .stat-card p {
            color: #666;
            font-size: 14px;
        }
        
        .content {
            padding: 30px;
        }
        
        .table-container {
            overflow-x: auto;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
        }
        
        th {
            background: linear-gradient(90deg, #4b6cb7 0%, #182848 100%);
            color: white;
            padding: 16px 12px;
            text-align: left;
            font-weight: 600;
        }
        
        td {
            padding: 14px 12px;
            border-bottom: 1px solid #eaeaea;
        }
        
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        
        tr:hover {
            background-color: #e3f2fd;
            transition: all 0.2s ease;
        }
        
        .actions {
            display: flex;
            gap: 8px;
        }
        
        .action-btn {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            border: none;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .edit-btn {
            background-color: #FFC107;
            color: #333;
        }
        
        .edit-btn:hover {
            background-color: #e0a800;
        }
        
        .delete-btn {
            background-color: #f44336;
            color: white;
        }
        
        .delete-btn:hover {
            background-color: #d32f2f;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
            gap: 10px;
        }
        
        .pagination a {
            padding: 8px 15px;
            border: 1px solid #ddd;
            background-color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            color: #333;
        }
        
        .pagination a:hover {
            background-color: #f0f0f0;
        }
        
        .pagination .active {
            background-color: #4b6cb7;
            color: white;
            border-color: #4b6cb7;
        }
        
        .pagination .disabled {
            background-color: #f5f5f5;
            color: #999;
            pointer-events: none;
        }
        
        .pagination-info {
            margin-left: 20px;
            color: #666;
        }
        
        footer {
            text-align: center;
            padding: 20px;
            color: #666;
            border-top: 1px solid #eaeaea;
            font-size: 14px;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        
        @media (max-width: 768px) {
            .stats {
                flex-direction: column;
            }
            
            header {
                flex-direction: column;
                gap: 15px;
            }
            
            .header-actions {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%
        // 声明所有需要的变量
        int currentPage = 1;
        int pageSize = 5;
        int recordCount = 0;
        int pageCount = 0;
        double totalSalary = 0;
        double avgAge = 0;
        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        
        // 分页参数处理
        String pn = request.getParameter("page");
        if(pn != null && !pn.trim().isEmpty()) {
            try {
                currentPage = Integer.parseInt(pn);
            } catch(NumberFormatException e) {
                currentPage = 1;
            }
        }
        
        if(currentPage < 1) {
            currentPage = 1;
        }
    %>
    
    <%
        try {
            // PostgreSQL驱动
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://127.0.0.1:5432/shiyan3";
            String user = "postgres";
            String pass = "528031";
            
            conn = DriverManager.getConnection(url, user, pass);
            stmt = conn.createStatement();
            
            // 获取总记录数
            String countSql = "SELECT count(*) as cnt FROM customers";
            rs = stmt.executeQuery(countSql);
            
            if(rs.next()) {
                recordCount = rs.getInt("cnt");
            }
            rs.close();
            
            // 计算总页数
            if(recordCount > 0) {
                pageCount = (recordCount + pageSize - 1) / pageSize;
            }
            
            // 确保当前页在有效范围内
            if(currentPage > pageCount && pageCount > 0) {
                currentPage = pageCount;
            } else if(pageCount == 0) {
                currentPage = 1;
            }
            
            // 计算统计数据
            String statsSql = "SELECT AVG(age) as avg_age, SUM(salary) as total_salary FROM customers";
            rs = stmt.executeQuery(statsSql);
            if(rs.next()) {
                avgAge = rs.getDouble("avg_age");
                totalSalary = rs.getDouble("total_salary");
            }
            rs.close();
            
            // 执行分页查询 - 确保OFFSET不为负数
            int offset = (currentPage - 1) * pageSize;
            if(offset < 0) offset = 0;
            
            String sql = "SELECT * FROM customers ORDER BY id LIMIT " + pageSize + " OFFSET " + offset;
            rs = stmt.executeQuery(sql);

    %>
    
    <div class="container">
        <header>
            <div class="logo">
                <i class="fas fa-users"></i>
                <h1>客户信息管理系统</h1>
            </div>
            <div class="header-actions">
                <a href="customers_add.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i> 添加新客户
                </a>
                <a href="customers_export.jsp" class="btn btn-secondary">
                    <i class="fas fa-file-export"></i> 导出数据
                </a>
            </div>
        </header>
        
        <div class="stats">
            <div class="stat-card">
                <h3><%= recordCount %></h3>
                <p>总客户数</p>
            </div>
            <div class="stat-card">
                <h3>¥<%= String.format("%,.2f", totalSalary) %></h3>
                <p>总薪资支出</p>
            </div>
            <div class="stat-card">
                <h3><%= String.format("%.1f", avgAge) %></h3>
                <p>平均年龄</p>
            </div>
            <div class="stat-card">
                <h3><%= pageCount %></h3>
                <p>总页数</p>
            </div>
        </div>
        
        <div class="content">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>客户ID</th>
                            <th>客户姓名</th>
                            <th>年龄</th>
                            <th>地址</th>
                            <th>薪资</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if(recordCount == 0) {
                        %>
                        <tr>
                            <td colspan="6" class="no-data">
                                <i class="fas fa-inbox" style="font-size: 48px; margin-bottom: 15px; opacity: 0.5;"></i>
                                <p>暂无客户数据</p>
                            </td>
                        </tr>
                        <%
                            } else {
                                while (rs.next()) { 
                                    String id = rs.getString("id");
                                    String name = rs.getString("name");
                                    String age = rs.getString("age");
                                    String address = rs.getString("address");
                                    String salary = rs.getString("salary");
                        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= name %></td>
                            <td><%= age %></td>
                            <td><%= address %></td>
                            <td>¥<%= salary %></td>
                            <td class="actions">
                                <a href="customers_edit.jsp?id=<%= id %>" class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i> 编辑
                                </a>
                                <a href="customers_delete.jsp?id=<%= id %>" class="action-btn delete-btn" onclick="return confirm('确定要删除客户 <%= name %> 吗？此操作不可撤销。')">
                                    <i class="fas fa-trash"></i> 删除
                                </a>
                            </td>
                        </tr>
                        <% 
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
            
            <%
                // 分页导航 - 添加边界检查
                int prevPage = currentPage - 1;
                int nextPage = currentPage + 1;
                
                if(prevPage < 1) prevPage = 1;
                if(nextPage > pageCount) nextPage = pageCount;
            %>
            
            <% if(pageCount > 0) { %>
                <div class="pagination">
                    <a href="?page=1" class="<%= currentPage == 1 ? "disabled" : "" %>">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                    <a href="?page=<%= prevPage %>" class="<%= currentPage == 1 ? "disabled" : "" %>">
                        <i class="fas fa-angle-left"></i>
                    </a>
                    
                    <%
                        // 显示页码
                        int startPage = Math.max(1, currentPage - 2);
                        int endPage = Math.min(pageCount, currentPage + 2);
                        
                        for(int i = startPage; i <= endPage; i++) {
                    %>
                        <a href="?page=<%= i %>" class="<%= i == currentPage ? "active" : "" %>">
                            <%= i %>
                        </a>
                    <% } %>
                    
                    <a href="?page=<%= nextPage %>" class="<%= currentPage == pageCount ? "disabled" : "" %>">
                        <i class="fas fa-angle-right"></i>
                    </a>
                    <a href="?page=<%= pageCount %>" class="<%= currentPage == pageCount ? "disabled" : "" %>">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                    
                    <div class="pagination-info">
                        第 <%= currentPage %> 页，共 <%= pageCount %> 页，总计 <%= recordCount %> 条记录
                    </div>
                </div>
            <% } %>
        </div>
        
        <footer>
            <p>© 2023 客户信息管理系统 | 技术支持: IT部门 | 数据库: PostgreSQL | 版本: 2.1.0</p>
        </footer>
    </div>

    <%
        } catch(Exception e) {
            out.println("<div class='container' style='padding: 20px;'>");
            out.println("<h2 style='color: #f44336;'>数据库连接错误</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("</div>");
            e.printStackTrace();
        } finally {
            // 确保资源被正确关闭
            if(rs != null) try { rs.close(); } catch(SQLException e) {}
            if(stmt != null) try { stmt.close(); } catch(SQLException e) {}
            if(conn != null) try { conn.close(); } catch(SQLException e) {}
        }
    %>
</body>
</html>