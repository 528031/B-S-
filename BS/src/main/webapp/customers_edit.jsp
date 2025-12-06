<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑客户 - 客户信息管理系统</title>
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
        
        .btn-warning {
            background-color: #FF9800;
            color: white;
        }
        
        .btn-warning:hover {
            background-color: #e68900;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .content {
            padding: 40px;
            display: flex;
            justify-content: center;
        }
        
        .form-container {
            width: 100%;
            max-width: 700px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            padding: 40px;
            border: 1px solid #eaeaea;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-header h2 {
            color: #4b6cb7;
            font-size: 24px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .form-header p {
            color: #666;
            font-size: 14px;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #444;
            font-size: 14px;
        }
        
        .form-label .required {
            color: #f44336;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
            background-color: #fafafa;
        }
        
        .form-control:focus {
            border-color: #4b6cb7;
            outline: none;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(75, 108, 183, 0.1);
        }
        
        .form-control:hover {
            background-color: #f5f5f5;
        }
        
        .form-control:read-only {
            background-color: #f0f0f0;
            color: #777;
            cursor: not-allowed;
        }
        
        .form-hint {
            display: block;
            margin-top: 5px;
            font-size: 12px;
            color: #888;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .form-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-top: 10px;
            border-left: 4px solid #4b6cb7;
        }
        
        .form-card h4 {
            color: #4b6cb7;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 16px;
        }
        
        .form-card p {
            color: #666;
            font-size: 14px;
            line-height: 1.5;
        }
        
        footer {
            text-align: center;
            padding: 20px;
            color: #666;
            border-top: 1px solid #eaeaea;
            font-size: 14px;
        }
        
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            header {
                flex-direction: column;
                gap: 15px;
            }
            
            .header-actions {
                width: 100%;
                justify-content: center;
            }
            
            .form-container {
                padding: 25px;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%
        // 获取要编辑的客户ID
        String customerId = request.getParameter("id");
        if(customerId == null || customerId.trim().isEmpty()) {
            response.sendRedirect("customers.jsp?msg=invalid_id");
            return;
        }
        
        // 数据库变量
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        // 客户信息变量
        String id = "";
        String name = "";
        String age = "";
        String address = "";
        String salary = "";
        
        try {
            // 数据库连接
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://127.0.0.1:5432/shiyan3";
            String user = "postgres";
            String pass = "528031";
            
            conn = DriverManager.getConnection(url, user, pass);
            
            // 查询客户信息
            String sql = "SELECT * FROM customers WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, customerId);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                id = rs.getString("id");
                name = rs.getString("name");
                age = rs.getString("age");
                address = rs.getString("address");
                salary = rs.getString("salary");
            } else {
                response.sendRedirect("customers.jsp?msg=customer_not_found");
                return;
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("customers.jsp?msg=db_error");
            return;
        } finally {
            if(rs != null) try { rs.close(); } catch(SQLException e) {}
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
            if(conn != null) try { conn.close(); } catch(SQLException e) {}
        }
    %>
    
    <div class="container">
        <header>
            <div class="logo">
                <i class="fas fa-users"></i>
                <h1>客户信息管理系统</h1>
            </div>
            <div class="header-actions">
                <a href="customers.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> 返回客户列表
                </a>
            </div>
        </header>
        
        <div class="content">
            <div class="form-container">
                <div class="form-header">
                    <h2><i class="fas fa-user-edit"></i> 编辑客户信息</h2>
                    <p>修改客户 <%= name %> 的信息，带 <span style="color: #f44336">*</span> 的字段为必填项</p>
                </div>
                
                <form action="customers_edit_action.jsp" method="post">
                    <input type="hidden" name="original_id" value="<%= id %>">
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                客户ID <span class="required">*</span>
                            </label>
                            <input type="text" name="id" class="form-control" required 
                                   value="<%= id %>" readonly>
                            <span class="form-hint">客户ID为唯一标识，创建后不可修改</span>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">
                                客户姓名 <span class="required">*</span>
                            </label>
                            <input type="text" name="name" class="form-control" required 
                                   value="<%= name != null ? name : "" %>" placeholder="请输入客户姓名">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">年龄</label>
                            <input type="number" name="age" class="form-control" 
                                   min="18" max="100" value="<%= age != null ? age : "" %>" placeholder="18-100之间">
                            <span class="form-hint">客户年龄应在18-100岁之间</span>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">薪资</label>
                            <input type="number" name="salary" class="form-control" 
                                   step="0.01" min="0" value="<%= salary != null ? salary : "" %>" placeholder="例如: 15000.00">
                            <span class="form-hint">请输入客户的月薪</span>
                        </div>
                        
                        <div class="form-group full-width">
                            <label class="form-label">地址</label>
                            <input type="text" name="address" class="form-control" 
                                   value="<%= address != null ? address : "" %>" placeholder="请输入详细地址">
                        </div>
                    </div>
                    
                    <div class="form-card">
                        <h4><i class="fas fa-info-circle"></i> 编辑提示</h4>
                        <p>请注意，客户ID一旦创建将无法修改。其他信息可以按需更新。请确保所有修改的信息准确无误。</p>
                    </div>
                    
                    <div class="form-actions">
                        <a href="customers.jsp" class="btn btn-secondary">
                            <i class="fas fa-times"></i> 取消
                        </a>
                        <button type="reset" class="btn btn-warning">
                            <i class="fas fa-redo"></i> 重置
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check"></i> 确认修改
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <footer>
            <p>© 2023 客户信息管理系统 | 技术支持: IT部门 | 数据库: PostgreSQL | 版本: 2.1.0</p>
        </footer>
    </div>

    <script>
        // 表单交互增强
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const inputs = form.querySelectorAll('.form-control');
            
            // 输入框焦点效果
            inputs.forEach(input => {
                if (!input.readOnly) {
                    input.addEventListener('focus', function() {
                        this.parentElement.classList.add('focused');
                    });
                    
                    input.addEventListener('blur', function() {
                        this.parentElement.classList.remove('focused');
                    });
                }
            });
            
            // 表单提交前验证
            form.addEventListener('submit', function(e) {
                let valid = true;
                const requiredInputs = form.querySelectorAll('[required]');
                
                requiredInputs.forEach(input => {
                    if (!input.value.trim()) {
                        valid = false;
                        input.style.borderColor = '#f44336';
                        input.style.backgroundColor = '#fff5f5';
                    } else {
                        input.style.borderColor = '#4CAF50';
                        input.style.backgroundColor = '#f5fff5';
                    }
                });
                
                if (!valid) {
                    e.preventDefault();
                    alert('请填写所有必填字段！');
                }
            });
            
            // 实时验证
            inputs.forEach(input => {
                if (!input.readOnly) {
                    input.addEventListener('input', function() {
                        if (this.hasAttribute('required') && this.value.trim()) {
                            this.style.borderColor = '#4CAF50';
                            this.style.backgroundColor = '#f5fff5';
                        } else if (!this.hasAttribute('required')) {
                            this.style.borderColor = '#ddd';
                            this.style.backgroundColor = '#fafafa';
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>