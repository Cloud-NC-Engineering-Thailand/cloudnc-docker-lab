# สิ่งที่จะได้จากการทำ LAB นี้

1.สามารถเรียนรู้การสร้าง `Image` จาก `Dockerfile` และสามารถนำ `Image` ไปรันใน `Docker container` ได้


# สิ่งที่ต้องการให้ทำ

1.รันคำสั่ง `ping google.com` บน `bash` จะได้การตอบรับจากทาง Google กลับมา เมื่อต้องการจะหยุดการทำงานเพื่อรันคำสั่งต่อไปให้กด ctrl+c หรือ command+c
(ping เป็นคำสั่งเพื่อใช้ทดสอบสถานะบนอินเตอร์เน็ตชองเครื่องคอมพิวเตอร์หรือเครืองเซิฟเวอร์ปลายทาง)

2.สร้าง `Dockerfile` ขึ้นมาที่ `root` 

3.สร้าง `Image` ที่ชื่อว่า `my-ping` และเมื่อเรียกใช้แล้วจะสามารถรันคำสั่ง `ping google.com` ได้

4.สร้าง `container` ที่ชื่อว่า `ping-container` จาก `Image` ที่ชื่อว่า `my-ping`


# คำใบ้

คำสั่งที่จำเป็นใน Lab นี้


| คำสั่ง     | เหตุผลที่ต้องใช้                       |
| :-------- :-------------------------------- |
| `touch (filename)`     | ใช้เพื่อสร้างไฟล์ |
| `nano (filename)`     | ใช้เพื่อแก้ไขไฟล์ |
| `docker build -t (image name) .`     | ใช้เพื่อสร้าง Image |
| `docker image ls`     | ใช้เพื่อเรียกดู docker image ที่มีอยู่ |
| `docker run --name (container name) (image name)`     | ใช้เพื่อเรียกสร้าง container จาก image |


# เฉลย

1.`touch Dockerfile`

2.`nano Dockerfile`

3.เรียกใช้ Bash จาก Dockerhub และรันคำสั่ง ping google.com
```bash
FROM bash
CMD ["ping", "google.com"]
```

เมื่อต้องการจะออกจาก nano สำหรับ Window 

1.ctrl+x

2.ctrl+y เพื่อ save

3.enter

4.สร้าง DockerImage ด้วยการรันคำสั่ง
```bash
docker build -t my-ping .

docker image ls
```

5.สร้าง container จาก DockerImage ด้วยการรันคำสั่ง
```bash
docker run --name ping-container my-ping
```
