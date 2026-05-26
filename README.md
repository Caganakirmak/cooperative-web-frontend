# 🌾 Şanlıurfa Tarım Kooperatifi - Cloud Infrastructure Project

Bu proje, Şanlıurfa Tarım Kooperatifi Farmer Member Portal projesinin **IaaS (Infrastructure as a Service)** katmanı altyapı ve frontend kurulumunu barındırmaktadır.

## 🚀 Bulut Altyapı Mimarisi (IaaS)

Projenin canlı altyapısı tamamen **AWS (Amazon Web Services)** üzerinde modellenmiştir:

* **Compute:** 1 Adet `t3.micro` EC2 Instance (Amazon Linux 2023 OS)
* **Web Server:** Apache HTTP Server (Static Hosting)
* **Storage:** EBS (Elastic Block Store) gp3 SSD Volume
* **Network & Security:** Custom VPC, Public Subnet, AWS Security Group

### 🔒 Ağ ve Güvenlik Duvarı Kuralları (Security Group)

* **Port 22 (SSH):** Yönetimsel sunucu bağlantıları için erişime açıktır.
* **Port 80 (HTTP):** Web portalının dış dünyaya yayınlanması için herkese açıktır.
* **Port 443 (HTTPS):** Güvenli bağlantılar için herkese açıktır.

## 🛠️ Deployment Yöntemi

Bu kurulumda sunucu ayağa kaldırılırken AWS EC2 **User Data** özelliği kullanılmıştır. Instance ilk başladığında `user-data.sh` betiği otomatik olarak çalışmış ve Apache web sunucusu kurulup yapılandırılmıştır.

## 🌐 Canlı Yayın Linkleri (Live Deployments)

AWS EC2 üzerinde Apache ile ayağa kaldırılan IaaS web sunucusuna aşağıdaki adreslerden ulaşabilirsiniz:

* 🔗 **Doğrudan IP Erişimi:** [http://13.63.170.0](http://13.63.170.0)
* 🔗 **AWS Public DNS Erişimi:** [http://ec2-13-63-170-0.eu-north-1.compute.amazonaws.com](http://ec2-13-63-170-0.eu-north-1.compute.amazonaws.com)
