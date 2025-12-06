<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加客户 - 客户信息管理系统</title>
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
                    <h2><i class="fas fa-user-plus"></i> 添加新客户</h2>
                    <p>请填写以下客户信息，带 <span style="color: #f44336">*</span> 的字段为必填项</p>
                </div>
                
                <form action="customers_add_action.jsp" method="post">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                客户ID <span class="required">*</span>
                            </label>
                            <input type="text" name="id" class="form-control" required 
                                   placeholder="例如: C001">
                            <span class="form-hint">客户唯一标识，建议使用字母数字组合</span>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">
                                客户姓名 <span class="required">*</span>
                            </label>
                            <input type="text" name="name" class="form-control" required 
                                   placeholder="请输入客户姓名">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">年龄</label>
                            <input type="number" name="age" class="form-control" 
                                   min="18" max="100" placeholder="18-100之间">
                            <span class="form-hint">客户年龄应在18-100岁之间</span>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">薪资</label>
                            <input type="number" name="salary" class="form-control" 
                                   step="0.01" min="0" placeholder="例如: 15000.00">
                            <span class="form-hint">请输入客户的月薪</span>
                        </div>
                        
                        <div class="form-group full-width">
                            <label class="form-label">地址</label>
                            <input type="text" name="address" class="form-control" 
                                   placeholder="请输入详细地址">
                        </div>
                    </div>
                    
                    <div class="form-card">
                        <h4><i class="fas fa-info-circle"></i> 填写提示</h4>
                        <p>请确保填写的客户信息准确无误。客户ID一旦创建将无法修改，请谨慎填写。所有必填字段必须填写完整才能成功添加客户。</p>
                    </div>
                    
                    <div class="form-actions">
                        <button type="reset" class="btn btn-secondary">
                            <i class="fas fa-redo"></i> 重置表单
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check"></i> 确认添加
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
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.classList.remove('focused');
                });
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
                input.addEventListener('input', function() {
                    if (this.hasAttribute('required') && this.value.trim()) {
                        this.style.borderColor = '#4CAF50';
                        this.style.backgroundColor = '#f5fff5';
                    } else if (!this.hasAttribute('required')) {
                        this.style.borderColor = '#ddd';
                        this.style.backgroundColor = '#fafafa';
                    }
                });
            });
        });
    </script>
</body>
</html>