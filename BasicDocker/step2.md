# สิ่งที่จะได้จากการทำ LAB นี้

1.สามารถเรียนรู้การสร้าง `Tag Docker Image` เพื่อที่จะได้สามารถเลือก `Image` ที่ต้องการจะ `Push` เข้า `Dockerhub` หรือ `Container` อื่นๆได้ ในกรณีนี้เราจะ `Push` เข้า `machine` ของเราเอง


# สิ่งที่ต้องการให้ทำ

1.`Tag Image` ที่ชื่อว่า `my-ping` และเปลี่ยนชื่อ `Image` ที่ถูก `Tag` เป็น `local-registry:5000/my-ping`

2.เช็คว่า `Image` ที่ถูก `Tag` นั้นอยู่ใน `Machine` ของเราแล้วหรือยัง

3.สร้าง `Push Image` ที่ถูกแท็คได้


# คำใบ้

คำสั่งที่จำเป็นใน Lab นี้

| คำสั่ง     | เหตุผลที่ต้องใช้                       |
| :-------- :-------------------------------- |
| `docker tag (image name) (tag name)`     | ใช้เพื่อ Copy Image ที่มีอยู่และเปลี่ยนจากชื่อ Image นั้นเป็นอีกชื่อนึง |
| `docker image ls`     | ใช้เพื่อเรียกดู docker image ที่มีอยู่ |
| `docker push (tag name)`     | ใช้เพื่อ push image ที่เรา Tag เอาไว้ |


# เฉลย

```bash
docker tag my-ping local-registry:5000/my-ping

docker image ls

docker push local-registry:5000/my-ping
```

