#!/bin/bash
# 1. Sistemi güncelle
yum update -y
# 2. Apache Web Sunucusunu indir ve kur
yum install -y httpd
# 3. Apache servisini başlat ve sunucu her açıldığında çalışmasını sağla
systemctl start httpd
systemctl enable httpd
# 4. index.html dosyasını Apache'nin yayın klasörüne oluştur
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Şanlıurfa Tarım Kooperatifi</title>
    <style>
        body { font-family: Arial; text-align: center; padding: 50px; background: #f0f7e6; }
        h1 { color: #2d6a2d; }
        .status { background: #2d6a2d; color: white; padding: 10px; border-radius: 8px; }
    </style>
</head>
<body>
    <h1>🌾Şanlıurfa Tarım Kooperatifi</h1>
    <p>Farmer Member Portal - Cloud Infrastructure Phase 2</p>
    <div class="status">✅IaaS Web Server - Running on AWS EC2</div>
    <p>CMPE433 - Group 3</p>
</body>
</html>
EOF
echo "IaaS Web Server altyapısı başarıyla kuruldu ve Apache yayına başladı!"
