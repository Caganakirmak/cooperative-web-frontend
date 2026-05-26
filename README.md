# 🌾 Şanlıurfa Tarım Kooperatifi - Cloud Infrastructure Project

Bu proje, Şanlıurfa Tarım Kooperatifi Farmer Member Portal projesinin **IaaS (Infrastructure as a Service)** katmanı altyapı ve frontend kurulumunu barındırmaktadır.

## 🚀 Bulut Altyapı Mimarisi (IaaS)

Projenin canlı altyapısı tamamen **AWS (Amazon Web Services)** üzerinde modellenmiştir:
* **Compute:** 1 Adet `t3.micro` EC2 Instance (Amazon Linux 2023 OS)
* **Web Server:** Nginx Web Server (Reverse Proxy & Static Hosting)
* **Storage:** EBS (Elastic Block Store) gp3 SSD Volume
* **Network & Security:** Custom AWS Security Group

### 🔒 Ağ ve Güvenlik Duvarı Kuralları (Security Group)
* **Port 22 (SSH):** Yönetimsel sunucu bağlantıları için erişime açıktır.
* **Port 80 (HTTP):** Web portalının dış dünyaya yayınlanması için herkese açıktır.

## 🛠️ Manuel Canlıya Alım (Deployment) Adımları

Sunucu ayağa kaldırıldıktan sonra altyapının kurulması için `setup.sh` betiği çalıştırılmıştır:
```bash
chmod +x setup.sh
./setup.sh
```

## 🌐 Canlı Yayın Linkleri (Live Deployments)

AWS EC2 üzerinde Nginx ile ayağa kaldırılan IaaS web sunucusuna aşağıdaki adreslerden ulaşabilirsiniz:

* 🔗 **Doğrudan IP Erişimi:** [http://51.20.75.93](http://51.20.75.93)
* 🔗 **AWS Public DNS Erişimi:** [http://ec2-51-20-75-93.eu-north-1.compute.amazonaws.com/](http://ec2-51-20-75-93.eu-north-1.compute.amazonaws.com/)
