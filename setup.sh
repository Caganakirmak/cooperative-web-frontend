---

### 2. Dosya: `setup.sh`
Bu dosya senin altyapıyı kurarken sunucuda çalıştırdığın Linux komutlarının otomasyon halidir. Hocaya "altyapıyı kodla yönetiyorum" mesajı verir.

**Dosya Adı:** `setup.sh`  
**İçeriği:**

```bash
#!/bin/bash

# 1. Sistemi güncelle
sudo dnf update -y

# 2. Nginx Web Sunucusunu indir ve kur
sudo dnf install nginx -y

# 3. Nginx servisini başlat ve sunucu her açıldığında çalışmasını sağla
sudo systemctl start nginx
sudo systemctl enable nginx

# 4. Git reposundaki index.html dosyasını Nginx'in yayın klasörüne taşı
sudo cp index.html /usr/share/nginx/html/index.html

echo "IaaS Web Server altyapısı başarıyla kuruldu ve Nginx yayına başladı!"
