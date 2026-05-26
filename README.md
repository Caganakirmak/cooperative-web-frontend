# 🌾 Şanlıurfa Tarım Kooperatifi - Cloud Infrastructure Project

Bu proje, Şanlıurfa Tarım Kooperatifi Farmer Member Portal projesinin **IaaS (Infrastructure as a Service)** katmanı altyapı ve frontend kurulumunu barındırmaktadır.

## 🚀 Bulut Altyapı Mimarisi (IaaS)

Projenin canlı altyapısı tamamen **AWS (Amazon Web Services)** üzerinde modellenmiştir:

* **Compute:** 1 Adet `t3.micro` EC2 Instance (Amazon Linux 2023 OS)
* **Web Server:** Apache HTTP Server (Static Hosting)
* **Storage:** EBS (Elastic Block Store) gp3 SSD Volume + S3 Bucket (Farmer Data Storage)
* **Network & Security:** Custom VPC, Public Subnet, Private Subnet, AWS Security Group

## 🔒 Ağ ve Güvenlik Duvarı Kuralları (Security Group)

* **Port 22 (SSH):** Yönetimsel sunucu bağlantıları için erişime açıktır.
* **Port 80 (HTTP):** Web portalının dış dünyaya yayınlanması için herkese açıktır.
* **Port 443 (HTTPS):** Güvenli bağlantılar için herkese açıktır.

## 🛠️ Deployment Yöntemi

Bu kurulumda sunucu ayağa kaldırılırken AWS EC2 **User Data** özelliği kullanılmıştır. Instance ilk başladığında `user_data.sh` betiği otomatik olarak çalışmış ve Apache web sunucusu kurulup yapılandırılmıştır.

## 🏗️ Terraform ile Infrastructure as Code (IaC)

Tüm altyapı `main.tf` dosyası ile Terraform kullanılarak kodlanmıştır.

### Terraform ile Yönetilen Kaynaklar

* VPC (`vpc-0fe56db9e42e2a486`)
* Public Subnet + Private Subnet
* Internet Gateway + Route Tables
* Security Group
* EC2 Instance (`t3.micro`)
* S3 Bucket (Farmer data storage)

### Mevcut Altyapıyı Import Etmek İçin

```bash
bash import.sh
```

### Altyapıyı Uygulamak İçin

```bash
terraform init
terraform plan
terraform apply
```

## 🌐 Canlı Yayın Linkleri (Live Deployments)

AWS EC2 üzerinde Apache ile ayağa kaldırılan IaaS web sunucusuna aşağıdaki adreslerden ulaşabilirsiniz:

* 🔗 **Doğrudan IP Erişimi:** [http://51.20.184.64](http://51.20.184.64)
* 🔗 **AWS Public DNS Erişimi:** [http://ec2-51-20-184-64.eu-north-1.compute.amazonaws.com](http://ec2-51-20-184-64.eu-north-1.compute.amazonaws.com)
