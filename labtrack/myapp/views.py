import random
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.contrib.auth.models import User,Group
# Create your views here.
from myapp.models import department_table
from myapp.models import *
from django.db.models import Q

def login_get(request):
    return render(request, 'login.html')


def login_post(request):

    username=request.POST['username']
    password=request.POST['password']

    try:
        user=User.objects.get(username=username)

        if user.is_active == False:
            return render(request, 'login.html', {
                'msg': 'You are blocked'
            })

    except User.DoesNotExist:
        return render(request, 'login.html', {
            'msg': 'Invalid username or password'
        })

    user=authenticate(
        request,
        username=username,
        password=password
    )

    if user is not None:

        login(request,user)

        if user.groups.filter(name='admin').exists():
            return redirect('/myapp/adminhome_get/')

        elif user.groups.filter(name='lab').exists():
            return redirect('/myapp/lab_home/')

        elif user.groups.filter(name='staff').exists():
            return redirect('/myapp/staff_home/')
        #
        # elif user.groups.filter(name='user').exists():
        #     return redirect('/myapp//')

    return render(request, 'login.html', {
        'msg': 'Invalid username or password'
    })

def logout_get(request):

    logout(request)

    return redirect(
        '/myapp/login_get/'
    )

############ADMIN######################################

@login_required(login_url="/myapp/login_get/")
def adminhome_get(request):
    return render(request,'admin/admin_home.html')

@login_required(login_url="/myapp/login_get/")
def add_dept_get(request):
    return render(request, 'admin/add_dept.html')

@login_required(login_url="/myapp/login_get/")
def add_dept_post(request):
    department_name = request.POST['department_name']

    a = department_table()
    a.department_name = department_name
    a.save()

    return redirect('/myapp/view_dept/')

@login_required(login_url="/myapp/login_get/")
def view_dept(request):
    data = department_table.objects.all()
    return render(request, 'admin/view_dept.html', {'data': data})

@login_required(login_url="/myapp/login_get/")
def edit_dept_get(request, id):
    data = department_table.objects.get(id=id)
    return render(request, 'admin/edit_dept.html', {'data': data})

@login_required(login_url="/myapp/login_get/")
def edit_dept_post(request, id):
    data = department_table.objects.get(id=id)
    data.department_name = request.POST['department_name']
    data.save()
    return redirect('/myapp/view_dept/')

@login_required(login_url="/myapp/login_get/")
def delete_dept(request, id):
    data = department_table.objects.get(id=id)
    data.delete()
    return redirect('/myapp/view_dept/')

@login_required(login_url="/myapp/login_get/")
def add_course_get(request, id):
    data = department_table.objects.get(id=id)
    return render(request, 'admin/add_course.html', {'data': data})

@login_required(login_url="/myapp/login_get/")
def add_course_post(request):
    id = request.POST['id']
    department = department_table.objects.get(id=id)

    a = course_table()
    a.DEPARTMENT = department
    a.course_name = request.POST['course_name']
    a.duration = request.POST['duration']
    a.save()

    return redirect('/myapp/view_dept/')


@login_required(login_url="/myapp/login_get/")
def view_course(request, id):
    department = department_table.objects.get(id=id)
    data = course_table.objects.filter(DEPARTMENT=department)
    return render(request, 'admin/view_course.html', {'data': data, 'department': department})

@login_required(login_url="/myapp/login_get/")
def edit_course_get(request,id):
    data=course_table.objects.get(id=id)
    return render(request,'admin/edit_course.html',{'data':data})


@login_required(login_url="/myapp/login_get/")
def edit_course_post(request):
    id=request.POST['id']
    data=course_table.objects.get(id=id)

    data.course_name=request.POST['course_name']
    data.duration=request.POST['duration']
    data.save()

    return redirect('/myapp/view_course/'+str(data.DEPARTMENT.id)+'/')


@login_required(login_url="/myapp/login_get/")
def delete_course(request, id):
    data = course_table.objects.get(id=id)
    department_id = data.DEPARTMENT.id
    data.delete()

    return redirect('/myapp/view_course/' + str(department_id) + '/')


@login_required(login_url="/myapp/login_get/")
def view_student(request):
    data = student_table.objects.all()
    return render(request, 'admin/view_students.html', {'data': data})


@login_required(login_url="/myapp/login_get/")
def add_staff_get(request):
    data = department_table.objects.all()
    return render(request, 'admin/add_staff.html', {'data': data})

@login_required(login_url="/myapp/login_get/")

def add_staff_post(request):
    name = request.POST['name']
    dob = request.POST['dob']
    gender = request.POST['gender']
    phone = request.POST['phone']
    photo = request.FILES['photo']
    email = request.POST['email']
    designation = request.POST['designation']
    qualification = request.POST['qualification']
    address = request.POST['address']
    department = request.POST['DEPARTMENT']
    username = request.POST['username']
    password = request.POST['password']

    a = User.objects.create_user(username=username, password=password,email=email)
    a.save()
    a.groups.add(Group.objects.get(name='staff'))
    b = staff_table()
    b.LOGIN = a
    b.DEPARTMENT = department_table.objects.get(id=department)
    b.name = name
    b.dob = dob
    b.gender = gender
    b.phone = phone
    b.photo = photo
    b.email = email
    b.designation = designation
    b.qualification = qualification
    b.address = address
    b.save()

    return redirect('/myapp/view_staff/')

@login_required(login_url="/myapp/login_get/")
def view_staff(request):
    data = staff_table.objects.all()
    return render(request, 'admin/view_staff.html', {'data': data})

@login_required(login_url="/myapp/login_get/")
def edit_staff_get(request, id):
    data = staff_table.objects.get(id=id)
    department = department_table.objects.all()
    return render(request, 'admin/edit_staff.html', {'data': data, 'department': department})

@login_required(login_url="/myapp/login_get/")
def edit_staff_post(request):
    id = request.POST['id']
    a = staff_table.objects.get(id=id)

    a.name = request.POST['name']
    a.dob = request.POST['dob']
    a.gender = request.POST['gender']
    a.phone = request.POST['phone']
    a.email = request.POST['email']
    a.designation = request.POST['designation']
    a.qualification = request.POST['qualification']
    a.address = request.POST['address']
    a.DEPARTMENT = department_table.objects.get(id=request.POST['DEPARTMENT'])

    if 'photo' in request.FILES:
        a.photo = request.FILES['photo']

    a.save()

    return redirect('/myapp/view_staff/')

@login_required(login_url="/myapp/login_get/")
def delete_staff(request,id):
    staff_table.objects.get(LOGIN_id=id).delete()
    User.objects.get(id=id).delete()
    return redirect('/myapp/view_staff/')


#
# def add_lab_get(request):
#     return render(request, 'admin/add_lab.html')
#
#
# def add_lab_post(request):
#     lab_name = request.POST['lab_name']
#     room_number = request.POST['room_number']
#     description = request.POST['description']
#
#     a = lab_table()
#     a.lab_name = lab_name
#     a.room_number = room_number
#     a.description = description
#     a.save()
#
#     return redirect('/myapp/view_lab/')
@login_required(login_url="/myapp/login_get/")
def add_lab_get(request):
    coordinators = lab_coordinator_table.objects.filter(status='Active')
    return render(request, 'admin/add_lab.html', {'coordinators': coordinators})

@login_required(login_url="/myapp/login_get/")
def add_lab_post(request):
    lab_name = request.POST['lab_name']
    room_number = request.POST['room_number']
    description = request.POST['description']
    coordinator_id = request.POST['coordinator']
    coordinator = lab_coordinator_table.objects.get(id=coordinator_id)




    if lab_assignment_table.objects.filter(COORDINATOR=coordinator).exists():
        messages.warning(request, 'alredy assigned')
        return redirect('/myapp/view_lab/')

    else:
        a = lab_table()
        a.lab_name = lab_name
        a.room_number = room_number
        a.description = description
        a.save()

        b = lab_assignment_table()
        b.LAB = a
        b.COORDINATOR = coordinator
        b.save()

        return redirect('/myapp/view_lab/')



# def view_lab(request):
#     data = lab_table.objects.all()
#     res=[]
#     for i in data:
#         obla =lab_assignment_table.objects.get(LAB__id=i.id)
#         i.lc = obla.COORDINATOR.name
#         i.ph = obla.COORDINATOR.phone
#         res.append(i)
#     return render(request, 'admin/view_lab.html', {'data': res})

@login_required(login_url="/myapp/login_get/")
def view_lab(request):
    data = lab_table.objects.all()
    res=[]
    for i in data:
        obla = lab_assignment_table.objects.filter(LAB__id=i.id, status='Active').first()
        if obla:
            i.lc = obla.COORDINATOR.name
            i.ph = obla.COORDINATOR.phone
        else:
            i.lc = 'Not Assigned'
            i.ph = 'Not Assigned'
        res.append(i)
    return render(request, 'admin/view_lab.html', {'data': res})

@login_required(login_url="/myapp/login_get/")
def edit_lab_get(request,id):
    data = lab_table.objects.get(id=id)
    return render(request,'admin/edit_lab.html',{'data':data})

@login_required(login_url="/myapp/login_get/")
def edit_lab_post(request):
    id = request.POST['id']
    lab_name = request.POST['lab_name']
    room_number = request.POST['room_number']
    description = request.POST['description']

    a = lab_table.objects.get(id=id)
    a.lab_name = lab_name
    a.room_number = room_number
    a.description = description
    a.save()

    return redirect('/myapp/view_lab/')


@login_required(login_url="/myapp/login_get/")
def delete_lab(request,id):
    lab_table.objects.get(id=id).delete()
    return redirect('/myapp/view_lab/')

@login_required(login_url="/myapp/login_get/")
def add_subject_get(request,id):
    data = course_table.objects.get(id=id)
    lab = lab_table.objects.all()
    return render(request,'admin/add_subject.html',{'data':data,'lab':lab})

@login_required(login_url="/myapp/login_get/")
def add_subject_post(request):
    id = request.POST['id']
    lab = request.POST['LAB']
    subject_name = request.POST['subject_name']
    subject_code = request.POST['subject_code']
    semester = request.POST['semester']
    description = request.POST['description']

    a = subject_table()
    a.COURSE = course_table.objects.get(id=id)
    a.LAB = lab_table.objects.get(id=lab)
    a.subject_name = subject_name
    a.subject_code = subject_code
    a.semester = semester
    a.description = description
    a.save()

    return redirect('/myapp/view_subject/' + str(id) + '/')

@login_required(login_url="/myapp/login_get/")
def view_subject(request,id):
    data = subject_table.objects.filter(COURSE_id=id)
    course = course_table.objects.get(id=id)
    return render(request,'admin/view_subject.html',{'data':data,'course':course})

@login_required(login_url="/myapp/login_get/")
def edit_subject_get(request,id):
    data = subject_table.objects.get(id=id)
    course = course_table.objects.all()
    lab = lab_table.objects.all()
    return render(request,'admin/edit_subject.html',{'data':data,'course':course,'lab':lab})

@login_required(login_url="/myapp/login_get/")
def edit_subject_post(request):
    id = request.POST['id']
    course = request.POST['COURSE']
    lab = request.POST['LAB']
    subject_name = request.POST['subject_name']
    subject_code = request.POST['subject_code']
    semester = request.POST['semester']
    description = request.POST['description']

    a = subject_table.objects.get(id=id)
    a.COURSE = course_table.objects.get(id=course)
    a.LAB = lab_table.objects.get(id=lab)
    a.subject_name = subject_name
    a.subject_code = subject_code
    a.semester = semester
    a.description = description
    a.save()

    return redirect('/myapp/view_subject/' + str(course) + '/')

@login_required(login_url="/myapp/login_get/")
def delete_subject(request,id):
    a = subject_table.objects.get(id=id)
    course_id = a.COURSE.id
    a.delete()
    return redirect('/myapp/view_subject/' + str(course_id) + '/')

@login_required(login_url="/myapp/login_get/")
def view_schedule(request,id):
    lab = lab_table.objects.get(id=id)
    data = schedule_table.objects.filter(LAB_id=id)
    course_id = request.GET.get('course_id')
    assignment = lab_assignment_table.objects.filter(LAB_id=id)

    return render(request,'admin/view_schedule.html',{'data':data,'lab':lab,'course_id':course_id,'assignment':assignment})

@login_required(login_url="/myapp/login_get/")
def add_schedule_get(request,id):
    lab = lab_table.objects.get(id=id)
    subject = subject_table.objects.filter(LAB_id=id)
    course_id = request.GET.get('course_id')
    return render(request,'admin/add_schedule.html',{'lab':lab,'subject':subject,'course_id':course_id})

@login_required(login_url="/myapp/login_get/")
def add_schedule_post(request):
    lab = request.POST['LAB']
    subject = request.POST['SUBJECT']
    day = request.POST['day']
    hour = request.POST['hour']
    course_id = request.POST['course_id']

    a = schedule_table()
    a.LAB = lab_table.objects.get(id=lab)
    a.SUBJECT = subject_table.objects.get(id=subject)
    a.day = day
    a.hour = hour
    a.save()

    return redirect('/myapp/view_schedule/' + str(lab) + '/?course_id=' + str(course_id))

@login_required(login_url="/myapp/login_get/")
def edit_schedule_get(request,id):
    data = schedule_table.objects.get(id=id)
    lab = lab_table.objects.get(id=data.LAB.id)
    subject = subject_table.objects.filter(LAB_id=lab.id)
    course_id = request.GET.get('course_id')
    return render(request,'admin/edit_schedule.html',{'data':data,'lab':lab,'subject':subject,'course_id':course_id})


@login_required(login_url="/myapp/login_get/")
def edit_schedule_post(request):
    id = request.POST['id']
    lab = request.POST['LAB']
    subject = request.POST['SUBJECT']
    day = request.POST['day']
    hour = request.POST['hour']
    course_id = request.POST['course_id']

    a = schedule_table.objects.get(id=id)
    a.LAB = lab_table.objects.get(id=lab)
    a.SUBJECT = subject_table.objects.get(id=subject)
    a.day = day
    a.hour = hour
    a.save()

    return redirect('/myapp/view_schedule/' + str(lab) + '/?course_id=' + str(course_id))


@login_required(login_url="/myapp/login_get/")
def delete_schedule(request,id):
    a = schedule_table.objects.get(id=id)
    lab_id = a.LAB.id
    a.delete()
    course_id = request.GET.get('course_id')
    return redirect('/myapp/view_schedule/' + str(lab_id) + '/?course_id=' + str(course_id))

@login_required(login_url="/myapp/login_get/")
def add_lab_coordinator_get(request):
    department = department_table.objects.all()
    return render(request,'admin/add_lab_coordinator.html',{'department':department})

@login_required(login_url="/myapp/login_get/")
def add_lab_coordinator_post(request):
    name = request.POST['name']
    dob = request.POST['dob']
    gender = request.POST['gender']
    phone = request.POST['phone']
    photo = request.FILES['photo']
    email = request.POST['email']
    place = request.POST['place']
    address = request.POST['address']
    department = request.POST['DEPARTMENT']
    username = request.POST['username']
    password = request.POST['password']

    a = User.objects.create_user(username=username,password=password,email=email)
    a.groups.add(Group.objects.get(name='lab'))

    b = lab_coordinator_table()
    b.LOGIN = a
    b.DEPARTMENT = department_table.objects.get(id=department)
    b.name = name
    b.dob = dob
    b.gender = gender
    b.phone = phone
    b.photo = photo
    b.email = email
    b.place = place
    b.address = address
    b.save()

    return redirect('/myapp/view_lab_coordinator/')

@login_required(login_url="/myapp/login_get/")
def view_lab_coordinator(request):
    data = lab_coordinator_table.objects.all()
    return render(request,'admin/view_lab_coordinator.html',{'data':data})

@login_required(login_url="/myapp/login_get/")
def edit_lab_coordinator_get(request,id):
    data = lab_coordinator_table.objects.get(id=id)
    department = department_table.objects.all()
    return render(request,'admin/edit_lab_coordinator.html',{'data':data,'department':department})

@login_required(login_url="/myapp/login_get/")
def edit_lab_coordinator_post(request):
    id = request.POST['id']
    name = request.POST['name']
    dob = request.POST['dob']
    gender = request.POST['gender']
    phone = request.POST['phone']
    email = request.POST['email']
    place = request.POST['place']
    address = request.POST['address']
    department = request.POST['DEPARTMENT']

    a = lab_coordinator_table.objects.get(id=id)
    a.name = name
    a.dob = dob
    a.gender = gender
    a.phone = phone
    a.email = email
    a.place = place
    a.address = address
    a.DEPARTMENT = department_table.objects.get(id=department)

    if 'photo' in request.FILES:
        a.photo = request.FILES['photo']

    a.save()
    return redirect('/myapp/view_lab_coordinator/')

@login_required(login_url="/myapp/login_get/")
def delete_lab_coordinator(request,id):
    a = lab_coordinator_table.objects.get(id=id)
    login = a.LOGIN
    a.delete()
    login.delete()
    return redirect('/myapp/view_lab_coordinator/')

@login_required(login_url="/myapp/login_get/")
def assign_lab_coordinator_get(request,id):
    lab = lab_table.objects.get(id=id)
    coordinator = lab_coordinator_table.objects.filter(status='Active')

    return render(request,'admin/assign_lab_coordinator.html',{'lab':lab,'coordinator':coordinator})

#
# def assign_lab_coordinator_post(request):
#     lab = request.POST['LAB']
#     coordinator = request.POST['COORDINATOR']
#
#     if lab_assignment_table.objects.filter(LAB_id=lab).exists():
#         messages.error(request,'This lab is already assigned to a coordinator.')
#         return redirect('/myapp/assign_lab_coordinator_get/'+str(lab))
#     else:
#         a = lab_assignment_table()
#         a.LAB = lab_table.objects.get(id=lab)
#         a.COORDINATOR = lab_coordinator_table.objects.get(id=coordinator)
#         a.status='assigned'
#         a.save()
#         messages.success(request,'Lab coordinator assigned successfully.')
#
#     return redirect('/myapp/view_schedule/' + str(lab) + '/')

@login_required(login_url="/myapp/login_get/")
def assign_lab_coordinator_post(request):
    lab = request.POST['LAB']
    coordinator = request.POST['COORDINATOR']



    a = lab_assignment_table()
    a.LAB = lab_table.objects.get(id=lab)
    a.COORDINATOR = lab_coordinator_table.objects.get(id=coordinator)
    a.status = 'assigned'
    a.save()

    schedule_table.objects.filter(LAB_id=lab).update(status='Assigned')

    messages.success(request,'Lab coordinator assigned successfully.')

    return redirect('/myapp/view_schedule/' + str(lab) + '/')


@login_required(login_url="/myapp/login_get/")
def view_lab_submissions_admin(request):
    data = lab_submission_table.objects.all().order_by('-submitted_date')
    return render(request,'admin/view_lab_submissions_admin.html',{'data':data})


@login_required(login_url="/myapp/login_get/")
def assign_subject_staff_get(request,id):
    subject = subject_table.objects.get(id=id)
    staff = staff_table.objects.filter(DEPARTMENT_id=subject.COURSE.DEPARTMENT.id,status='Active')
    return render(request,'admin/assign_subject_staff.html',{'subject':subject,'staff':staff})

@login_required(login_url="/myapp/login_get/")
def assign_subject_staff_post(request):
    subject = request.POST['SUBJECT']
    staff = request.POST['STAFF']


    a = subject_assignment_table()
    a.SUBJECT = subject_table.objects.get(id=subject)
    a.STAFF = staff_table.objects.get(id=staff)
    a.save()

    messages.success(request,'Staff assigned to subject successfully.')
    b=subject_table.objects.get(id=subject)
    b.assignedtstaus='assigned'
    b.save()

    return redirect('/myapp/view_subject/' + str(subject_table.objects.get(id=subject).COURSE.id) + '/')


@login_required(login_url="/myapp/login_get/")
def view_equipment(request,id):
    lab = lab_table.objects.get(id=id)
    data = equipment_table.objects.filter(LAB_id=id)
    return render(request,'admin/view_equipment.html',{'data':data,'lab':lab})

@login_required(login_url="/myapp/login_get/")
def add_equipment_get(request,id):
    lab = lab_table.objects.get(id=id)
    return render(request,'admin/add_equipment.html',{'lab':lab})


@login_required(login_url="/myapp/login_get/")

def add_equipment_post(request):
    lab = request.POST['LAB']
    equipment_name = request.POST['equipment_name']
    category = request.POST['category']
    quantity = request.POST['quantity']
    available_quantity = request.POST['available_quantity']
    status = request.POST['status']

    a = equipment_table()
    a.LAB = lab_table.objects.get(id=lab)
    a.equipment_name = equipment_name
    a.category = category
    a.quantity = quantity
    a.available_quantity = available_quantity
    a.status = status
    a.save()

    return redirect('/myapp/view_equipment/' + str(lab) + '/')


@login_required(login_url="/myapp/login_get/")

def edit_equipment_get(request,id):
    data = equipment_table.objects.get(id=id)
    return render(request,'admin/edit_equipment.html',{'data':data})

@login_required(login_url="/myapp/login_get/")

def edit_equipment_post(request):
    id = request.POST['id']
    equipment_name = request.POST['equipment_name']
    category = request.POST['category']
    quantity = request.POST['quantity']
    available_quantity = request.POST['available_quantity']
    status = request.POST['status']

    a = equipment_table.objects.get(id=id)
    a.equipment_name = equipment_name
    a.category = category
    a.quantity = quantity
    a.available_quantity = available_quantity
    a.status = status
    a.save()

    return redirect('/myapp/view_equipment/' + str(a.LAB.id) + '/')

@login_required(login_url="/myapp/login_get/")

def delete_equipment(request,id):
    a = equipment_table.objects.get(id=id)
    lab_id = a.LAB.id
    a.delete()
    return redirect('/myapp/view_equipment/' + str(lab_id) + '/')


def change_password_get(request):
    return render(request,'admin/change_password.html')


def change_password_post(request):
    current_password = request.POST['current_password']
    new_password = request.POST['new_password']
    confirm_password = request.POST['confirm_password']

    if not request.user.check_password(current_password):
        messages.error(request,'Current password is incorrect.')
        return redirect('/myapp/change_password_get/')

    if new_password != confirm_password:
        messages.error(request,'New password and confirm password do not match.')
        return redirect('/myapp/change_password_get/')

    if len(new_password) < 6:
        messages.error(request,'Password must contain at least 6 characters.')
        return redirect('/myapp/change_password_get/')

    a = request.user
    a.set_password(new_password)
    a.save()

    messages.success(request,'Password changed successfully. Please log in again.')
    return redirect('/myapp/login_get/')

@login_required(login_url="/myapp/login_get/")
def view_complaints_admin(request):
    data = complaint_table.objects.all().order_by('-date')
    return render(request,'admin/view_complaints_admin.html',{'data':data})

@login_required(login_url="/myapp/login_get/")

def reply_complaint_get(request,id):
    data = complaint_table.objects.get(id=id)
    return render(request,'admin/reply_complaint.html',{'data':data})

@login_required(login_url="/myapp/login_get/")

def reply_complaint_post(request):
    id = request.POST['id']
    reply = request.POST['reply']

    a = complaint_table.objects.get(id=id)

    if a.status == 'Replied':
        messages.error(request,'This complaint has already been replied to.')
        return redirect('/myapp/view_complaints_admin/')

    a.reply = reply
    a.status = 'Replied'
    a.save()

    messages.success(request,'Reply sent successfully.')
    return redirect('/myapp/view_complaints_admin/')

@login_required(login_url="/myapp/login_get/")

def view_feedback_admin(request):
    data = feedback_table.objects.all().order_by('-date')
    return render(request,'admin/view_feedback.html',{'data':data})

@login_required(login_url="/myapp/login_get/")

def admin_reports(request):
    submissions = lab_submission_table.objects.all().order_by('-submitted_date')

    fines = equipment_assignment_table.objects.filter(fine_amount__gt=0)

    equipment = equipment_table.objects.all()

    return render(request, 'admin/admin_reports.html', {
        'submissions': submissions,
        'fines': fines,
        'equipment': equipment
    })



##################lab###############################
@login_required(login_url="/myapp/login_get/")

def lab_home(request):
    return render(request,'lab/lab_home.html')

@login_required(login_url="/myapp/login_get/")

def lab_view_profile(request):
    data = lab_coordinator_table.objects.get(LOGIN=request.user)
    return render(request,'lab/view_profile.html',{'data':data})

@login_required(login_url="/myapp/login_get/")

def lab_view_assigned_lab(request):
    data=lab_assignment_table.objects.filter(COORDINATOR__LOGIN=request.user)
    # coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)
    # assignments = lab_assignment_table.objects.filter(COORDINATOR=coordinator, status='assigned').order_by('id')
    #
    # data = []
    # lab_ids = []
    #
    # for i in assignments:
    #     if i.LAB.id not in lab_ids:
    #         data.append(i)
    #         lab_ids.append(i.LAB.id)

    return render(request,'lab/view_assigned_lab.html',{'data':data})

@login_required(login_url="/myapp/login_get/")

def lab_view_schedules(request,id):
    coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)

    assignment = lab_assignment_table.objects.filter(
        COORDINATOR=coordinator,
        LAB_id=id
    ).exists()

    if not assignment:
        return redirect('/myapp/lab_view_assigned_lab/')

    lab = lab_table.objects.get(id=id)
    data = schedule_table.objects.filter(LAB=lab).order_by('day')

    return render(request,'lab/view_schedules.html',{'data':data,'lab':lab})


# def lab_view_exercises(request):
#     coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)
#
#     data = lab_excercise_table.objects.filter(
#         ASSIGNMENT__COORDINATOR=coordinator
#     ).order_by('-date')
#
#     return render(request, 'lab/view_lab_exercises.html', {'data': data})

@login_required(login_url="/myapp/login_get/")

def lab_view_exercises(request):
    lab=lab_assignment_table.objects.get(COORDINATOR__LOGIN=request.user).LAB.id
    data=lab_excercise_table.objects.filter(LAB_id=lab)
    return render(request, 'lab/view_lab_exercises.html', {'data': data})


# def lab_view_student_submissions(request, id):
#     coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)
#
#     exercise = lab_excercise_table.objects.get(
#         id=id,
#         ASSIGNMENT__COORDINATOR=coordinator
#     )
#
#     data = lab_submission_table.objects.filter(
#         INSTRUCTION=exercise
#     ).order_by('-submitted_date')
#
#     return render(
#         request,
#         'lab/view_student_submissions.html',
#         {'data': data, 'exercise': exercise}
#     )


# def lab_approve_submission(request, id):
#     if request.method == 'POST':
#         coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)
#
#         a = lab_submission_table.objects.get(
#             id=id,
#             INSTRUCTION__ASSIGNMENT__COORDINATOR=coordinator
#         )
#
#         if a.status == 'Pending':
#             a.status = 'Approved'
#             a.save()
#
#     return redirect('/myapp/lab_view_student_submissions/' + str(a.INSTRUCTION.id) + '/')


# def lab_reject_submission(request, id):
#     if request.method == 'POST':
#         coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)
#
#         a = lab_submission_table.objects.get(
#             id=id,
#             INSTRUCTION__ASSIGNMENT__COORDINATOR=coordinator
#         )
#
#         if a.status == 'Pending':
#             a.status = 'Rejected'
#             a.save()
#
#     return redirect('/myapp/lab_view_student_submissions/' + str(a.INSTRUCTION.id) + '/')

@login_required(login_url="/myapp/login_get/")

def lab_view_equipment_requests(request):
    coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)

    data = equipment_assignment_table.objects.filter(
        EQUIPMENT__LAB__lab_assignment_table__COORDINATOR=coordinator
    ).distinct().order_by('-date')

    return render(request,'lab/view_equipment_requests.html',{'data':data})

@login_required(login_url="/myapp/login_get/")

def lab_assign_equipment(request,id):

    if request.method == 'POST':

        coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)

        a = equipment_assignment_table.objects.filter(
            id=id,
            EQUIPMENT__LAB__lab_assignment_table__COORDINATOR=coordinator
        ).distinct().get()

        if a.status == 'Pending':

            equipment = a.EQUIPMENT

            if equipment.available_quantity >= a.quantity:

                equipment.available_quantity = equipment.available_quantity - a.quantity
                equipment.save()

                a.status = 'Assigned'
                a.save()

                messages.success(request,'Equipment assigned successfully.')

            else:
                messages.error(request,'Insufficient equipment available.')

    return redirect('/myapp/lab_view_equipment_requests/')

@login_required(login_url="/myapp/login_get/")

def lab_fine_damage(request,id):

    coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)

    a = equipment_assignment_table.objects.filter(
        id=id,
        EQUIPMENT__LAB__lab_assignment_table__COORDINATOR=coordinator
    ).distinct().get()

    if a.status != 'Assigned':
        messages.error(request,'Equipment is not assigned.')
        return redirect('/myapp/lab_view_equipment_requests/')

    if request.method == 'POST':

        damage_description = request.POST['damage_description']
        fine_amount = request.POST['fine_amount']

        a.damage_description = damage_description
        a.fine_amount = float(fine_amount)
        a.save()

        messages.success(request,'Fine and damage details saved successfully.')

        return redirect('/myapp/lab_view_equipment_requests/')

    return render(request,'lab/fine_damage.html',{'a':a})



# def lab_send_notification(request):
#     coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)
#
#     data = student_table.objects.filter(
#         equipment_assignment_table__EQUIPMENT__LAB__lab_assignment_table__COORDINATOR=coordinator
#     ).distinct()
#
#     return render(request,'lab/send_notification.html',{'data':data})
#
#
# def lab_send_notification_post(request,id):
#     if request.method == 'POST':
#         message = request.POST['message']
#
#         coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)
#
#         student = student_table.objects.get(
#             id=id,
#             equipment_assignment_table__EQUIPMENT__LAB__lab_assignment_table__COORDINATOR=coordinator
#         )
#
#         a = chat_message_table()
#         a.SENDER = request.user
#         a.RECEIVER = student.LOGIN
#         a.message = message
#         a.save()
#
#         messages.success(request,'Notification sent successfully.')
#         return redirect('/myapp/lab_send_notification/')
#
#     return redirect('/myapp/lab_send_notification/')
@login_required(login_url="/myapp/login_get/")

def lab_send_notification(request):
    return render(request,'lab/send_notification.html')

@login_required(login_url="/myapp/login_get/")

def lab_send_notification_post(request):
    if request.method == 'POST':
        title = request.POST['title']
        message = request.POST['message']

        coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)

        labs = lab_assignment_table.objects.filter(
            COORDINATOR=coordinator,
            status='Active'
        ).values_list('LAB_id',flat=True)

        courses = subject_table.objects.filter(
            LAB_id__in=labs
        ).values_list('COURSE_id',flat=True)

        students = student_table.objects.filter(
            COURSE_id__in=courses
        ).distinct()

        for i in students:
            a = notification_table()
            print(i)
            a.COORDINATOR = coordinator
            a.STUDENT = i
            a.title = title
            a.message = message
            a.save()

        messages.success(request,'Notification sent to students assigned to your labs.')
        return redirect('/myapp/lab_send_notification/')

    return redirect('/myapp/lab_send_notification/')

@login_required(login_url="/myapp/login_get/")
def lab_add_reference(request):
    coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)
    data = subject_table.objects.filter(LAB__lab_assignment_table__COORDINATOR=coordinator).distinct()
    return render(request,'lab/add_reference.html',{'data':data})

@login_required(login_url="/myapp/login_get/")

def lab_add_reference_post(request):
    if request.method == 'POST':
        subject = request.POST['subject']
        reference_name = request.POST['reference_name']
        description = request.POST['description']
        reference_file = request.FILES['reference_file']

        a = reference_table()
        a.SUBJECT_id = subject
        a.reference_name = reference_name
        a.description = description
        a.reference_file = reference_file
        a.save()

        messages.success(request,'Reference added successfully.')
        return redirect('/myapp/lab_view_references/')

    return redirect('/myapp/lab_add_reference/')

@login_required(login_url="/myapp/login_get/")

def lab_view_references(request):
    coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)
    data = reference_table.objects.filter(SUBJECT__LAB__lab_assignment_table__COORDINATOR=coordinator).distinct().order_by('-date')

    return render(request,'lab/view_reference.html',{'data':data})


@login_required(login_url="/myapp/login_get/")

def lab_edit_reference(request, id):
    coordinator = lab_coordinator_table.objects.get(LOGIN=request.user)

    data = reference_table.objects.get(
        id=id,
        SUBJECT__LAB__lab_assignment_table__COORDINATOR=coordinator
    )

    subjects = subject_table.objects.filter(
        LAB__lab_assignment_table__COORDINATOR=coordinator
    ).distinct()

    return render(request, 'lab/edit_reference.html', {
        'data': data,
        'subjects': subjects
    })

@login_required(login_url="/myapp/login_get/")

def lab_edit_reference_post(request):
    if request.method == 'POST':
        id = request.POST['id']
        subject = request.POST['subject']
        reference_name = request.POST['reference_name']
        description = request.POST['description']

        a = reference_table.objects.get(id=id)

        a.SUBJECT_id = subject
        a.reference_name = reference_name
        a.description = description

        if 'reference_file' in request.FILES:
            a.reference_file = request.FILES['reference_file']

        a.save()

        messages.success(request, 'Reference updated successfully.')
        return redirect('/myapp/lab_view_references/')

    return redirect('/myapp/lab_view_references/')

@login_required(login_url="/myapp/login_get/")

def lab_delete_reference(request, id):
    data = reference_table.objects.get(id=id)
    data.delete()

    messages.success(request, 'Reference deleted successfully.')
    return redirect('/myapp/lab_view_references/')

def lab_change_password_get(request):
    return render(request,'lab/change_password.html')


def lab_change_password_post(request):
    current_password = request.POST['current_password']
    new_password = request.POST['new_password']
    confirm_password = request.POST['confirm_password']

    if not request.user.check_password(current_password):
        messages.error(request,'Current password is incorrect.')
        return redirect('/myapp/lab_change_password_get/')

    if new_password != confirm_password:
        messages.error(request,'New password and confirm password do not match.')
        return redirect('/myapp/lab_change_password_get/')

    if len(new_password) < 6:
        messages.error(request,'Password must contain at least 6 characters.')
        return redirect('/myapp/lab_change_password_get/')

    a = request.user
    a.set_password(new_password)
    a.save()

    messages.success(request,'Password changed successfully. Please log in again.')
    return redirect('/myapp/login_get/')


####################STAFF####################

@login_required(login_url="/myapp/login_get/")

def staff_home(request):
    return render(request,'staff/staff_home.html')

@login_required(login_url="/myapp/login_get/")

def staff_view_profile(request):
    data = staff_table.objects.get(LOGIN=request.user)
    return render(request,'staff/view_profile.html',{'data':data})

@login_required(login_url="/myapp/login_get/")

def staff_add_student(request):
    dept=staff_table.objects.get(LOGIN=request.user).DEPARTMENT.id
    data = course_table.objects.filter(DEPARTMENT_id=dept)
    return render(request,'staff/add_student.html',{'data':data})

#
# def staff_add_student_post(request):
#     if request.method == 'POST':
#         cid = request.POST['cid']
#         name = request.POST['name']
#         sem = request.POST['sem']
#         dob = request.POST['dob']
#         gender = request.POST['gender']
#         photo = request.FILES['photo']
#         phone = request.POST['phone']
#         email = request.POST['email']
#         address = request.POST['address']
#         username = request.POST['username']
#         password = request.POST['password']
#
#         if User.objects.filter(username=username).exists():
#             messages.error(request,'Username already exists.')
#             return redirect('/myapp/staff_add_student/')
#
#         user = User()
#         user.username = username
#         user.set_password(password)
#         user.save()
#         user.groups.add(Group.objects.get(name='user'))
#
#         a = student_table()
#         a.LOGIN = user
#         a.COURSE = course_table.objects.get(id=cid)
#         a.name = name
#         a.sem = sem
#         a.dob = dob
#         a.gender = gender
#         a.photo = photo
#         a.phone = phone
#         a.email = email
#         a.address = address
#         a.save()
#
#         messages.success(request,'Student added successfully.')
#         return redirect('/myapp/staff_view_students/')
#
#     return redirect('/myapp/staff_add_student/')
@login_required(login_url="/myapp/login_get/")

def staff_add_student_post(request):
    cid = request.POST['cid']
    name = request.POST['name']
    sem = request.POST['sem']
    dob = request.POST['dob']
    gender = request.POST['gender']
    phone = request.POST['phone']
    photo = request.FILES['photo']
    email = request.POST['email']
    address = request.POST['address']
    username = request.POST['username']
    password = request.POST['password']

    if User.objects.filter(username=username).exists():
        messages.error(request, 'Username already exists.')
        return redirect('/myapp/staff_add_student/')

    a = User.objects.create_user(username=username, password=password, email=email)
    a.groups.add(Group.objects.get(name='user'))

    b = student_table()
    b.LOGIN = a
    b.COURSE = course_table.objects.get(id=cid)
    b.name = name
    b.sem = sem
    b.dob = dob
    b.gender = gender
    b.phone = phone
    b.photo = photo
    b.email = email
    b.address = address
    b.save()

    messages.success(request, 'Student added successfully.')
    return redirect('/myapp/staff_view_students/')

@login_required(login_url="/myapp/login_get/")

def staff_view_students(request):
    dept = staff_table.objects.get(LOGIN=request.user).DEPARTMENT.id
    data = student_table.objects.filter(COURSE__DEPARTMENT_id=dept)
    return render(request,'staff/view_students.html',{'data':data})


@login_required(login_url="/myapp/login_get/")

def staff_edit_student(request,id):
    a = student_table.objects.get(id=id)
    dept = staff_table.objects.get(LOGIN=request.user).DEPARTMENT.id
    data = course_table.objects.filter(DEPARTMENT_id=dept)
    return render(request,'staff/edit_student.html',{'a':a,'data':data})

@login_required(login_url="/myapp/login_get/")

def staff_edit_student_post(request):
    if request.method == 'POST':
        id = request.POST['id']
        cid = request.POST['cid']
        name = request.POST['name']
        sem = request.POST['sem']
        dob = request.POST['dob']
        gender = request.POST['gender']
        phone = request.POST['phone']
        email = request.POST['email']
        address = request.POST['address']

        a = student_table.objects.get(id=id)
        a.COURSE = course_table.objects.get(id=cid)
        a.name = name
        a.sem = sem
        a.dob = dob
        a.gender = gender

        if 'photo' in request.FILES:
            a.photo = request.FILES['photo']

        a.phone = phone
        a.email = email
        a.address = address
        a.save()

        messages.success(request,'Student updated successfully.')
        return redirect('/myapp/staff_view_students/')

    return redirect('/myapp/staff_view_students/')

@login_required(login_url="/myapp/login_get/")
def delete_student(request,id):
    a=student_table.objects.get(id=id)
    b=a.LOGIN
    b.delete()
    a.delete()
    return redirect('/myapp/staff_view_students/')

@login_required(login_url="/myapp/login_get/")
def staff_add_exercise(request):
    data = lab_assignment_table.objects.all().order_by('LAB__lab_name','id')
    labs = lab_table.objects.all()
    return render(request,'staff/add_exercise.html',{'data':data,'labs':labs})

@login_required(login_url="/myapp/login_get/")
def staff_add_exercise_post(request):
    if request.method == 'POST':
        aid = request.POST['aid']
        title = request.POST['title']
        instruction = request.POST['instruction']
        reference_file = request.FILES['reference_file']
        date = request.POST['date']
        deadline = request.POST['deadline']

        a = lab_excercise_table()
        a.ASSIGNMENT = lab_table.objects.get(id=aid)
        a.title = title
        a.instruction = instruction
        a.reference_file = reference_file
        a.date = date
        a.deadline = deadline
        a.save()

        messages.success(request,'Lab instructions added successfully.')
        return redirect('/myapp/staff_view_exercise/')

    return redirect('/myapp/staff_add_exercise/')

@login_required(login_url="/myapp/login_get/")
def staff_view_exercise(request):
    data = lab_excercise_table.objects.all()
    return render(request,'staff/view_exercise.html',{'data':data})

@login_required(login_url="/myapp/login_get/")
def staff_view_assigned_labs(request):
    staff = staff_table.objects.get(LOGIN_id=request.user.id)

    data = subject_assignment_table.objects.filter(
        STAFF=staff,
        status='Active'
    ).select_related('SUBJECT', 'SUBJECT__LAB', 'SUBJECT__COURSE')

    return render(request, 'staff/view_assigned_labs.html', {'data': data})

@login_required(login_url="/myapp/login_get/")
def staff_add_exercise(request, id):
    lab = lab_table.objects.get(id=id)
    return render(request, 'staff/add_exercise.html', {'lab': lab})

# def staff_add_exercise(request, id):
#     lab = lab_table.objects.get(id=id)
#     return render(request, 'staff/add_exercise.html', {'lab': lab})

@login_required(login_url="/myapp/login_get/")
def staff_add_exercise_post(request):
    if request.method == 'POST':
        lab_id = request.POST['lab_id']
        title = request.POST['title']
        instruction = request.POST['instruction']
        reference_file = request.FILES['reference_file']
        date = request.POST['date']
        deadline = request.POST['deadline']

        a = lab_excercise_table()
        a.LAB = lab_table.objects.get(id=lab_id)
        a.title = title
        a.instruction = instruction
        a.reference_file = reference_file
        a.date = date
        a.deadline = deadline
        a.save()

        messages.success(request, 'Instruction added successfully.')
        return redirect('/myapp/staff_view_assigned_labs/')

    return redirect('/myapp/staff_view_assigned_labs/')

@login_required(login_url="/myapp/login_get/")
def staff_view_instructions(request, id):
    lab = lab_table.objects.get(id=id)
    data = lab_excercise_table.objects.filter(LAB=lab)

    return render(request, 'staff/view_exercise.html', {'data': data, 'lab': lab})

@login_required(login_url="/myapp/login_get/")
def staff_edit_exercise(request, id):
    data = lab_excercise_table.objects.get(id=id)
    return render(request, 'staff/edit_exercise.html', {'data': data})

@login_required(login_url="/myapp/login_get/")

def staff_edit_exercise_post(request):
    if request.method == 'POST':
        id = request.POST['id']
        title = request.POST['title']
        instruction = request.POST['instruction']
        date = request.POST['date']
        deadline = request.POST['deadline']

        a = lab_excercise_table.objects.get(id=id)
        a.title = title
        a.instruction = instruction

        if 'reference_file' in request.FILES:
            a.reference_file = request.FILES['reference_file']

        a.date = date
        a.deadline = deadline
        a.save()

        messages.success(request, 'Instruction updated successfully.')
        return redirect('/myapp/staff_view_instructions/' + str(a.LAB.id) + '/')

    return redirect('/myapp/staff_view_assigned_labs/')

@login_required(login_url="/myapp/login_get/")
def staff_delete_exercise(request, id):
    a = lab_excercise_table.objects.get(id=id)
    lab_id = a.LAB.id
    a.delete()

    messages.success(request, 'Instruction deleted successfully.')
    return redirect('/myapp/staff_view_instructions/' + str(lab_id) + '/')

@login_required(login_url="/myapp/login_get/")
def staff_view_submissions(request):
    staff = staff_table.objects.get(LOGIN_id=request.user.id)

    data = lab_submission_table.objects.filter(
        INSTRUCTION__LAB__subject_table__subject_assignment_table__STAFF=staff
    ).distinct().select_related('STUDENT', 'INSTRUCTION', 'INSTRUCTION__LAB')

    return render(request, 'staff/view_submissions.html', {'data': data})


@login_required(login_url="/myapp/login_get/")

def staff_review_submission(request, id):
    data = lab_submission_table.objects.get(id=id)
    return render(request, 'staff/review_submission.html', {'data': data})

@login_required(login_url="/myapp/login_get/")
def staff_review_submission_post(request):
    if request.method == 'POST':
        id = request.POST['id']
        grade = request.POST['grade']
        feedback = request.POST['feedback']
        status = request.POST['status']

        a = lab_submission_table.objects.get(id=id)
        a.grade = grade
        a.feedback = feedback
        a.status = status
        a.save()

        messages.success(request, 'Submission reviewed successfully.')
        return redirect('/myapp/staff_view_submissions/')

    return redirect('/myapp/staff_view_submissions/')


def staff_change_password_get(request):
    return render(request,'staff/change_password.html')


def staff_change_password_post(request):
    current_password = request.POST['current_password']
    new_password = request.POST['new_password']
    confirm_password = request.POST['confirm_password']

    if not request.user.check_password(current_password):
        messages.error(request,'Current password is incorrect.')
        return redirect('/myapp/staff_change_password_get/')

    if new_password != confirm_password:
        messages.error(request,'New password and confirm password do not match.')
        return redirect('/myapp/staff_change_password_get/')

    if len(new_password) < 6:
        messages.error(request,'Password must contain at least 6 characters.')
        return redirect('/myapp/staff_change_password_get/')

    a = request.user
    a.set_password(new_password)
    a.save()

    messages.success(request,'Password changed successfully. Please log in again.')
    return redirect('/myapp/login_get/')



#######################student###############################



def flutter_login_post(request):

    usrnm = request.POST['Username']
    psw = request.POST['Password']

    print(usrnm, psw, 'LOGIN')

    lg = authenticate(
        request,
        username=usrnm,
        password=psw
    )

    print(lg, 'one')

    if lg is not None:

        print('two')

        if lg.groups.filter(name="user").exists():

            print('three', lg.id)

            login(request, lg)

            return JsonResponse({
                'status': 'ok',
                'lid': str(lg.id)
            })

        else:

            return JsonResponse({
                'status': 'error',
                'message': 'invalid groups'
            })

    else:

        return JsonResponse({
            'status': 'error',
            'message': 'invalid credentials'
        })



def flutter_view_profile(request):

    if request.method == 'POST':

        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        return JsonResponse({
            'status': 'ok',
            'name': student.name,
            'course': student.COURSE.course_name,
            'sem': student.sem,
            'dob': student.dob.strftime('%Y-%m-%d'),
            'gender': student.gender,
            'photo': request.build_absolute_uri(student.photo.url)if student.photo else "",
            'phone': student.phone,
            'email': student.email,
            'address': student.address
        })

    return JsonResponse({
        'status': 'no',
        'message': 'POST method required'
    })


def flutter_view_labs(request):

    if request.method == 'POST':

        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        subjects = subject_table.objects.filter(COURSE=student.COURSE)

        labs = []

        for s in subjects:

            lab = s.LAB

            coordinators = lab_assignment_table.objects.filter(LAB=lab, status='Active')

            coordinator_list = []

            for c in coordinators:

                coordinator_list.append({
                    'name': c.COORDINATOR.name,
                    'phone': c.COORDINATOR.phone,
                    'email': c.COORDINATOR.email
                })

            labs.append({
                'id': lab.id,
                'lab_name': lab.lab_name,
                'room_number': lab.room_number,
                'description': lab.description,
                'status': lab.status,
                'coordinators': coordinator_list
            })

        unique_labs = []
        lab_ids = []

        for lab in labs:

            if lab['id'] not in lab_ids:

                lab_ids.append(lab['id'])
                unique_labs.append(lab)

        return JsonResponse({
            'status': 'ok',
            'labs': unique_labs
        })

    return JsonResponse({
        'status': 'no',
        'message': 'POST method required'
    })

def flutter_view_lab_exercises(request):
    if request.method == 'POST':
        lab_id = request.POST['lab_id']

        exercises = lab_excercise_table.objects.filter(LAB_id=lab_id)

        data = []

        for i in exercises:
            data.append({
                'id': i.id,
                'title': i.title,
                'instruction': i.instruction,
                'date': str(i.date),
                'deadline': str(i.deadline),
                'reference_file': request.build_absolute_uri(i.reference_file.url) if i.reference_file else ''
            })

        return JsonResponse({
            'status': 'ok',
            'exercises': data
        })

    return JsonResponse({
        'status': 'no'
    })



def flutter_submit_lab_exercise(request):
    if request.method == 'POST':

        lid = request.POST['lid']
        instruction_id = request.POST['instruction_id']
        description = request.POST['description']
        file = request.FILES.get('file')

        if not file:
            return JsonResponse({'status': 'no', 'message': 'Please select a file'})

        student = student_table.objects.get(LOGIN_id=lid)
        exercise = lab_excercise_table.objects.get(id=instruction_id)

        a = lab_submission_table()
        a.STUDENT = student
        a.INSTRUCTION = exercise
        a.file = file
        a.description = description
        a.save()

        return JsonResponse({'status': 'ok', 'message': 'Lab exercise submitted successfully'})

    return JsonResponse({'status': 'no', 'message': 'POST method required'})


def flutter_view_lab_submissions(request):
    if request.method == 'POST':

        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        submissions = lab_submission_table.objects.filter(STUDENT=student).order_by('-submitted_date')

        data = []

        for i in submissions:
            data.append({
                'id': i.id,
                'exercise_title': i.INSTRUCTION.title,
                'lab_name': i.INSTRUCTION.LAB.lab_name,
                'description': i.description,
                'file': request.build_absolute_uri(i.file.url) if i.file else '',
                'submitted_date': str(i.submitted_date),
                'status': i.status,
                'grade': i.grade,
                'feedback': i.feedback
            })

        return JsonResponse({'status': 'ok', 'submissions': data})

    return JsonResponse({'status': 'no', 'message': 'POST method required'})



def flutter_edit_lab_submission(request):
    if request.method == 'POST':

        lid = request.POST['lid']
        submission_id = request.POST['submission_id']
        description = request.POST['description']
        file = request.FILES.get('file')

        student = student_table.objects.get(LOGIN_id=lid)

        a = lab_submission_table.objects.get(id=submission_id, STUDENT=student)

        a.description = description

        if file:
            a.file = file

        a.save()

        return JsonResponse({'status': 'ok', 'message': 'Submission updated successfully'})

    return JsonResponse({'status': 'no', 'message': 'POST method required'})


def flutter_delete_lab_submission(request):
    if request.method == 'POST':

        lid = request.POST['lid']
        submission_id = request.POST['submission_id']

        student = student_table.objects.get(LOGIN_id=lid)

        a = lab_submission_table.objects.get(id=submission_id, STUDENT=student)

        a.delete()

        return JsonResponse({
            'status': 'ok',
            'message': 'Submission deleted successfully'
        })

    return JsonResponse({
        'status': 'no',
        'message': 'POST method required'
    })



def flutter_view_equipment(request):
    if request.method == 'POST':

        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        subjects = subject_table.objects.filter(COURSE=student.COURSE)

        equipment_list = []
        equipment_ids = []

        for s in subjects:

            lab = s.LAB

            equipments = equipment_table.objects.filter(
                LAB=lab,
                status='Available',
                available_quantity__gt=0
            )

            for e in equipments:

                if e.id not in equipment_ids:

                    equipment_ids.append(e.id)

                    equipment_list.append({
                        'id': e.id,
                        'lab_name': e.LAB.lab_name,
                        'equipment_name': e.equipment_name,
                        'category': e.category,
                        'quantity': e.quantity,
                        'available_quantity': e.available_quantity,
                        'status': e.status
                    })

        return JsonResponse({
            'status': 'ok',
            'equipment': equipment_list
        })

    return JsonResponse({
        'status': 'no',
        'message': 'POST method required'
    })


def flutter_request_equipment(request):
    if request.method == 'POST':

        lid = request.POST['lid']
        equipment_id = request.POST['equipment_id']
        quantity = int(request.POST['quantity'])

        student = student_table.objects.get(LOGIN_id=lid)

        equipment = equipment_table.objects.get(id=equipment_id)

        if quantity <= 0:
            return JsonResponse({
                'status': 'no',
                'message': 'Enter a valid quantity'
            })

        if equipment.status != 'Available' or quantity > equipment.available_quantity:
            return JsonResponse({
                'status': 'no',
                'message': 'Requested quantity is not available'
            })

        a = equipment_assignment_table()

        a.EQUIPMENT = equipment
        a.STUDENT = student
        a.quantity = quantity
        a.status = 'Pending'

        a.save()

        return JsonResponse({
            'status': 'ok',
            'message': 'Equipment request sent successfully'
        })

    return JsonResponse({
        'status': 'no',
        'message': 'POST method required'
    })


def flutter_view_assigned_equipment(request):
    if request.method == 'POST':

        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        data = equipment_assignment_table.objects.filter(
            STUDENT=student,
            status='Assigned'
        ).order_by('-date')

        equipment = []

        for i in data:
            equipment.append({
                'id': i.id,
                'lab_name': i.EQUIPMENT.LAB.lab_name,
                'equipment_name': i.EQUIPMENT.equipment_name,
                'category': i.EQUIPMENT.category,
                'quantity': i.quantity,
                'date': str(i.date),
                'status': i.status,
                'damage_description': i.damage_description,
                'fine_amount': i.fine_amount
            })

        return JsonResponse({
            'status': 'ok',
            'equipment': equipment
        })

    return JsonResponse({
        'status': 'no',
        'message': 'POST method required'
    })



def flutter_view_subjects(request):
    if request.method == 'POST':
        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        data = subject_table.objects.filter(
            COURSE=student.COURSE
        ).order_by('semester', 'subject_name')

        subjects = []

        for i in data:
            subjects.append({
                'id': i.id,
                'subject_name': i.subject_name,
                'subject_code': i.subject_code,
                'semester': i.semester,
                'description': i.description
            })

        return JsonResponse({
            'status': 'ok',
            'subjects': subjects
        })

    return JsonResponse({
        'status': 'no',
        'message': 'POST method required'
    })



def flutter_view_subject_references(request):
    if request.method == 'POST':
        lid = request.POST['lid']
        subject_id = request.POST['subject_id']

        student = student_table.objects.get(LOGIN_id=lid)

        data = reference_table.objects.filter(
            SUBJECT_id=subject_id,
            SUBJECT__COURSE=student.COURSE
        ).order_by('-date')

        references = []

        for i in data:
            if i.reference_file:
                file_url = request.build_absolute_uri(i.reference_file.url)
            else:
                file_url = ''

            references.append({
                'id': i.id,
                'reference_name': i.reference_name,
                'description': i.description,
                'reference_file': file_url,
                'date': i.date.strftime('%d-%m-%Y')
            })

        return JsonResponse({
            'status': 'ok',
            'references': references
        })

    return JsonResponse({'status': 'no'})



def flutter_view_my_fines(request):
    if request.method == 'POST':
        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        data = equipment_assignment_table.objects.filter(
            STUDENT=student
        ).exclude(
            fine_amount=0
        ).order_by('-date')

        fines = []

        for i in data:
            fines.append({
                'id': i.id,
                'equipment_name': i.EQUIPMENT.equipment_name,
                'category': i.EQUIPMENT.category,
                'quantity': i.quantity,
                'damage_description': i.damage_description,
                'fine_amount': i.fine_amount,
                'date': i.date.strftime('%d-%m-%Y'),
                'status': i.status
            })

        return JsonResponse({
            'status': 'ok',
            'fines': fines
        })

    return JsonResponse({'status': 'no'})



def flutter_send_complaint(request):
    if request.method == 'POST':
        lid = request.POST['lid']
        complaint = request.POST['complaint']

        student = student_table.objects.get(LOGIN_id=lid)

        c = complaint_table()
        c.STUDENT = student
        c.complaint = complaint
        c.save()

        return JsonResponse({
            'status': 'ok',
            'message': 'Complaint sent successfully'
        })

    return JsonResponse({'status': 'no'})


def flutter_view_complaints(request):
    if request.method == 'POST':
        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        data = complaint_table.objects.filter(
            STUDENT=student
        ).order_by('-date', '-id')

        complaints = []

        for i in data:
            complaints.append({
                'id': i.id,
                'complaint': i.complaint,
                'reply': i.reply,
                'status': i.status,
                'date': i.date.strftime('%d-%m-%Y')
            })

        return JsonResponse({
            'status': 'ok',
            'complaints': complaints
        })

    return JsonResponse({'status': 'no'})


def flutter_send_feedback(request):
    if request.method == 'POST':
        lid = request.POST['lid']
        review = request.POST['review']
        rating = request.POST['rating']

        f = feedback_table()
        f.LOGIN_id = lid
        f.review = review
        f.rating = rating
        f.save()

        return JsonResponse({'status': 'ok'})

    return JsonResponse({'status': 'no'})


def flutter_view_feedback(request):
    if request.method == 'POST':
        lid = request.POST['lid']

        data = feedback_table.objects.filter(LOGIN_id=lid).order_by('-date', '-id')

        feedbacks = []

        for i in data:
            feedbacks.append({
                'id': i.id,
                'review': i.review,
                'rating': i.rating,
                'date': i.date.strftime('%d-%m-%Y')
            })

        return JsonResponse({
            'status': 'ok',
            'feedbacks': feedbacks
        })

    return JsonResponse({'status': 'no'})

def flutter_view_notifications(request):
    if request.method == 'POST':
        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        data = notification_table.objects.filter(
            STUDENT=student
        ).order_by('-date')

        notifications = []

        for i in data:
            notifications.append({
                'id': i.id,
                'title': i.title,
                'message': i.message,
                'date': i.date.strftime('%d-%m-%Y %H:%M'),
                'status': i.status
            })

        return JsonResponse({
            'status': 'ok',
            'notifications': notifications
        })

    return JsonResponse({'status': 'no'})


def flutter_change_password(request):
    if request.method == 'POST':
        lid = request.POST['lid']
        old_password = request.POST['old_password']
        new_password = request.POST['new_password']
        confirm_password = request.POST['confirm_password']

        user = User.objects.get(id=lid)

        if not user.check_password(old_password):
            return JsonResponse({'status': 'no', 'message': 'Incorrect old password'})

        if new_password != confirm_password:
            return JsonResponse({'status': 'no', 'message': 'Passwords do not match'})

        user.set_password(new_password)
        user.save()

        return JsonResponse({'status': 'ok', 'message': 'Password changed successfully'})

    return JsonResponse({'status': 'no'})

def flutter_view_timetable(request):

    if request.method == 'POST':

        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        schedules = schedule_table.objects.filter(
            SUBJECT__COURSE=student.COURSE
        ).select_related('LAB', 'SUBJECT').order_by('day', 'hour')

        data = []

        for i in schedules:
            data.append({
                'id': i.id,
                'day': i.day,
                'hour': i.hour,
                'status': i.status,
                'lab_name': i.LAB.lab_name,
                'room_number': i.LAB.room_number,
                'subject_name': i.SUBJECT.subject_name,
                'subject_code': i.SUBJECT.subject_code,
                'semester': i.SUBJECT.semester,
            })

        return JsonResponse({
            'status': 'ok',
            'course': student.COURSE.course_name,
            'data': data
        })

def flutter_view_department_staff(request):
    if request.method == 'POST':
        lid = request.POST['lid']

        student = student_table.objects.get(LOGIN_id=lid)

        data = staff_table.objects.filter(
            DEPARTMENT=student.COURSE.DEPARTMENT,
            status='Active'
        )

        staff = []

        for i in data:
            staff.append({
                'id': i.LOGIN_id,
                'name': i.name,
                'designation': i.designation,
                'email': i.email
            })

        return JsonResponse({
            'status': 'ok',
            'staff': staff
        })

    return JsonResponse({'status': 'no'})


def chat1(request,id):
    request.session["userid"] = str(id)
    cid = str(request.session["userid"])
    request.session["new"] = cid
    qry = student_table.objects.get(id=cid)

    return render(request, "staff/chat.html", {'photo': qry.photo, 'name': qry.name, 'toid': cid})

def chat_view(request):
    fromid = request.user.id
    toid = request.session["userid"]
    qry = student_table.objects.get(id=request.session["userid"])
    from django.db.models import Q

    res = Chat.objects.filter(Q(FROMID_id=fromid, TOID_id=qry.LOGIN.id) | Q(FROMID_id=qry.LOGIN.id, TOID_id=fromid))
    l = []

    for i in res:
        l.append({"id": i.id, "message": i.message, "to": i.TOID_id, "date": i.date, "from": i.FROMID_id})

    return JsonResponse({'photo': qry.photo.url, "data": l, 'name': qry.name, 'toid': qry.LOGIN.id})

def chat_send(request, msg):
    lid = request.user.id
    toid = request.session["userid"]
    obs=student_table.objects.get(id=toid)

    message = msg

    import datetime
    d = datetime.datetime.now().date()
    chatobt = Chat()
    chatobt.message = message
    chatobt.TOID_id = obs.LOGIN.id
    chatobt.FROMID_id = lid
    chatobt.date = d
    chatobt.save()

    return JsonResponse({"status": "ok"})




def User_sendchat(request):
    FROM_id=request.POST['from_id']
    TOID_id=request.POST['to_id']
    print(FROM_id)
    print(TOID_id)
    msg=request.POST['message']

    from  datetime import datetime
    c=Chat()
    c.FROMID_id=FROM_id
    c.TOID_id=TOID_id
    c.message=msg
    c.date=datetime.now()
    c.save()
    return JsonResponse({'status':"ok"})

def flutter_send_chat_message(request):
    print(request.POST)
    FROM_id=request.POST['lid']
    TOID_id=request.POST['receiver_id']
    print(FROM_id)
    print(TOID_id)
    msg=request.POST['message']

    from  datetime import datetime
    c=Chat()
    c.FROMID_id=FROM_id
    c.TOID_id=TOID_id
    c.message=msg
    c.date=datetime.now()
    c.save()
    return JsonResponse({'status':"ok"})


def User_viewchat(request):
    fromid = request.POST["from_id"]
    toid = request.POST["to_id"]
    # lmid = request.POST["lastmsgid"]
    from django.db.models import Q

    res = Chat.objects.filter(Q(FROMID_id=fromid, TOID_id=toid) | Q(FROMID_id=toid, TOID_id=fromid))
    l = []

    for i in res:
        l.append({"id": i.id, "msg": i.message, "from": i.FROMID_id, "date": i.date, "to": i.TOID_id})

    return JsonResponse({"status":"ok",'data':l})



def flutter_view_chat_messages(request):
    print(request.POST)
    fromid = request.POST["lid"]
    toid = request.POST["receiver_id"]
    # lmid = request.POST["lastmsgid"]
    from django.db.models import Q

    res = Chat.objects.filter(Q(FROMID_id=fromid, TOID_id=toid) | Q(FROMID_id=toid, TOID_id=fromid))
    l = []

    for i in res:
        l.append({"id": i.id, "msg": i.message, "from": i.FROMID_id, "date": i.date, "to": i.TOID_id})
    print(l)
    return JsonResponse({"status":"ok",'data':l})




def forgot_password(request):
    return render(request,'forgotpassword.html')

def forgotpassword_post(request):
    email=request.POST['email']
    if User.objects.filter(email=email).exists():
        import random
        new_pass = random.randint(0000000, 9999999)
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login("leagaladvisorteam@gmail.com", " eugnxtyylwtqwlav") # App Password
        to = email
        subject = "Test Email"
        body = "Your new password is " + str(new_pass)
        msg = f"Subject: {subject}\n\n{body}"
        server.sendmail("s@gmail.com", to, msg) # Disconnect from the server
        server.quit()

        user = User.objects.get(email=email)
        user.set_password(str(new_pass))
        user.save()

        return redirect('/myapp/login_get/')
    else:
        messages.warning(request, 'email not exists')
        return redirect('/myapp/forgot_password/')






def android_forget_password_post(request):
    email = request.POST.get('email')
    if not email:
        return JsonResponse({'status': 'error', 'message': 'Email is required'})

    try:
        user = User.objects.get(email=email)
        print(email)

        # Generate new password
        new_pass = str(random.randint(1000, 9999))
        user.password = make_password(new_pass)
        user.save()

        # Email configuration
        smtp_server = "smtp.gmail.com"
        smtp_port = 587
        sender_email = "trainingstarted@gmail.com"
        app_password = "nlxasujxgazlbmgz"

        subject = "Your New Password"
        body = f"Your new password is: {new_pass}"
        message = MIMEMultipart()
        message["From"] = sender_email
        message["To"] = email
        message["Subject"] = subject
        message.attach(MIMEText(body, "plain"))

        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(sender_email, app_password)
        server.send_message(message)
        server.quit()

        return JsonResponse({'status': 'ok', 'message': 'Password sent to your email'})

    except User.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Email not found'})

    except Exception as e:
        return JsonResponse({'status': 'error', 'message': f'Email send error: {str(e)}'})



