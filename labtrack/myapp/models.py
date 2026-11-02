from django.db import models

# Create your models here.

from django.db import models
from django.contrib.auth.models import User


class department_table(models.Model):
    department_name = models.CharField(max_length=50)


class course_table(models.Model):
    DEPARTMENT = models.ForeignKey(department_table, on_delete=models.CASCADE)

    course_name = models.CharField(max_length=100)
    duration = models.CharField(max_length=30)


class student_table(models.Model):
    LOGIN = models.ForeignKey(User, on_delete=models.CASCADE)
    COURSE = models.ForeignKey(course_table, on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    sem =models.IntegerField()
    dob = models.DateField()
    gender = models.CharField(max_length=10)
    photo = models.FileField()
    phone = models.CharField(max_length=15)
    email = models.EmailField()
    address = models.TextField()

class staff_table(models.Model):
    LOGIN = models.ForeignKey(User, on_delete=models.CASCADE)
    DEPARTMENT = models.ForeignKey(department_table, on_delete=models.CASCADE)

    name = models.CharField(max_length=50)
    dob = models.DateField()
    gender = models.CharField(max_length=10)
    phone = models.CharField(max_length=15)
    photo = models.FileField()
    email = models.EmailField()
    designation = models.CharField(max_length=50)
    qualification=models.CharField(max_length=100)
    address = models.TextField()
    joining_date = models.DateField(auto_now_add=True)
    status = models.CharField(max_length=15, default='Active')


class lab_coordinator_table(models.Model):
    LOGIN = models.ForeignKey(User, on_delete=models.CASCADE)
    DEPARTMENT = models.ForeignKey(department_table, on_delete=models.CASCADE)

    name = models.CharField(max_length=50)
    dob = models.DateField()
    gender = models.CharField(max_length=10)
    phone = models.CharField(max_length=15)
    photo = models.FileField()
    email = models.EmailField()
    place = models.CharField(max_length=50)
    address = models.TextField()
    joining_date = models.DateField(auto_now_add=True)
    status = models.CharField(max_length=15, default='Active')


class lab_table(models.Model):
    lab_name = models.CharField(max_length=100)
    room_number = models.CharField(max_length=30)
    description = models.TextField()
    status = models.CharField(max_length=20, default='Active')



class subject_table(models.Model):
    COURSE = models.ForeignKey(course_table, on_delete=models.CASCADE)
    LAB = models.ForeignKey(lab_table, on_delete=models.CASCADE)
    assignedtstaus=models.CharField(max_length=100,default='pending')
    subject_name = models.CharField(max_length=100)
    subject_code = models.CharField(max_length=30)
    semester = models.IntegerField()
    description = models.TextField()


class schedule_table(models.Model):
    LAB = models.ForeignKey(lab_table, on_delete=models.CASCADE)
    SUBJECT = models.ForeignKey(subject_table, on_delete=models.CASCADE)
    day = models.CharField(max_length=20)
    status=models.CharField(max_length=100,default='pending')
    hour = models.IntegerField()



class subject_assignment_table(models.Model):
    SUBJECT = models.ForeignKey(subject_table, on_delete=models.CASCADE)
    STAFF = models.ForeignKey(staff_table, on_delete=models.CASCADE)
    assigned_date = models.DateField(auto_now_add=True)
    status = models.CharField(max_length=15, default='Active')



class lab_assignment_table(models.Model):
    COORDINATOR = models.ForeignKey(lab_coordinator_table, on_delete=models.CASCADE)
    LAB = models.ForeignKey(lab_table, on_delete=models.CASCADE)
    assigned_date = models.DateField(auto_now_add=True)
    status = models.CharField(max_length=15, default='Active')



class lab_excercise_table(models.Model):

    LAB=models.ForeignKey(lab_table,on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    instruction = models.TextField()
    reference_file = models.FileField()
    date = models.DateField()
    deadline = models.DateTimeField()


class lab_submission_table(models.Model):
    STUDENT = models.ForeignKey(student_table, on_delete=models.CASCADE)
    INSTRUCTION = models.ForeignKey(lab_excercise_table, on_delete=models.CASCADE)
    file = models.FileField()
    submitted_date = models.DateTimeField(auto_now_add=True)
    description = models.CharField(max_length=200)
    status = models.CharField(max_length=20, default='Pending')
    grade = models.CharField(max_length=20, default='Not Graded')
    feedback = models.TextField(default='Pending')


class equipment_table(models.Model):
    LAB = models.ForeignKey(lab_table, on_delete=models.CASCADE)
    equipment_name = models.CharField(max_length=100)
    category = models.CharField(max_length=50)
    quantity = models.IntegerField()
    available_quantity = models.IntegerField()
    status = models.CharField(max_length=20, default='Available')


class equipment_assignment_table(models.Model):
    EQUIPMENT = models.ForeignKey(equipment_table, on_delete=models.CASCADE)
    STUDENT = models.ForeignKey(student_table, on_delete=models.CASCADE)
    date = models.DateField(auto_now_add=True)
    quantity = models.IntegerField(default=1)
    damage_description = models.TextField(default='None')
    fine_amount = models.FloatField(default=0)
    status = models.CharField(max_length=20, default='Issued')


class complaint_table(models.Model):
    STUDENT = models.ForeignKey(student_table, on_delete=models.CASCADE)
    date = models.DateField(auto_now_add=True)
    complaint = models.TextField()
    reply = models.TextField(default='Pending')
    status = models.CharField(max_length=15, default='Pending')


class feedback_table(models.Model):
    LOGIN = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.DateField(auto_now_add=True)
    review = models.TextField()
    rating = models.IntegerField()


class Chat(models.Model):
    FROMID = models.ForeignKey(User, on_delete=models.CASCADE,related_name='fuser')
    TOID = models.ForeignKey(User, on_delete=models.CASCADE,related_name='tfuser')
    message=models.CharField(max_length=200)
    date = models.DateField()


class reference_table(models.Model):
    SUBJECT = models.ForeignKey(subject_table, on_delete=models.CASCADE)
    reference_name = models.CharField(max_length=100)
    description = models.TextField()
    reference_file = models.FileField()
    date = models.DateField(auto_now_add=True)

class notification_table(models.Model):
    COORDINATOR = models.ForeignKey(lab_coordinator_table, on_delete=models.CASCADE)
    STUDENT = models.ForeignKey(student_table, on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    message = models.TextField()
    date = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=20, default='Unread')