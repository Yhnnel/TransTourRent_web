from flask import Flask,render_template,request,redirect,session,url_for
import mysql.connector

db=mysql.connector.connect(
   host='localhost',
   user='root',
   password='',
   database='transtourent',
)

app=Flask(__name__)
app.secret_key= 'secretkey'

def getCustomer():
    sql=f"SELECT * FROM `customer`"
    cursor=db.cursor(dictionary=True)
    cursor.execute(sql)
    customer_list:list=cursor.fetchall()
    cursor.close()
    return customer_list

def getTransaction():
    sql=f"SELECT * FROM `transaction`"
    cursor=db.cursor(dictionary=True)
    cursor.execute(sql)
    transaction_list:list=cursor.fetchall()
    cursor.close()
    return transaction_list

def getDestination():
    sql=f"SELECT * FROM `destination`"
    cursor=db.cursor(dictionary=True)
    cursor.execute(sql)
    destination_list:list=cursor.fetchall()
    cursor.close()
    return destination_list

def getDriver():
    sql=f"SELECT * FROM `driver`"
    cursor=db.cursor(dictionary=True)
    cursor.execute(sql)
    driver_list:list=cursor.fetchall()
    cursor.close()
    return driver_list

def getVehicle():
    sql=f"SELECT * FROM `vehicle`"
    cursor=db.cursor(dictionary=True)
    cursor.execute(sql)
    vehicle_list:list=cursor.fetchall()
    cursor.close()
    return vehicle_list

@app.route("/van")
def van():
    if 'user' in session:
        user = session['user']

        driver_list = getDriver()
        vehicle_list = getVehicle()

        return render_template("/van.html", driver_list = driver_list, vehicle_list = vehicle_list)

    else:
        return redirect("/login")

@app.route("/vehicle_details_van", methods=["POST"])
def vehicle_details_van():
    if 'user' in session:
        user = session['user']

        vehicle_id = request.form['vehicle_id']
        vehicle_id = int(vehicle_id)

        driver_list = getDriver()
        vehicle_list = getVehicle()

        vehicle_info:list=[]
        for vehicle in vehicle_list:
            for driver in driver_list:
                if vehicle['vehicle_id'] == vehicle_id and vehicle['driver_id'] == driver['driver_id']:
                    return render_template("/vehicle_details_van.html", driver_list = driver_list, vehicle_list = vehicle_list, vehicle_id = vehicle_id)
    
    else:
        return redirect("/login")

@app.route("/bus")
def bus():
    if 'user' in session:
        user = session['user']

        driver_list = getDriver()
        vehicle_list = getVehicle()

        return render_template("/bus.html", driver_list = driver_list, vehicle_list = vehicle_list)
    
    else:
        return redirect("/login")

@app.route("/vehicle_details_bus", methods=["POST"])
def vehicle_details_bus():
    if 'user' in session:
        user = session['user']

        vehicle_id = request.form['vehicle_id']
        vehicle_id = int(vehicle_id)

        driver_list = getDriver()
        vehicle_list = getVehicle()

        vehicle_info:list=[]
        for vehicle in vehicle_list:
            for driver in driver_list:
                if vehicle['vehicle_id'] == vehicle_id and vehicle['driver_id'] == driver['driver_id']:
                     return render_template("/vehicle_details_bus.html", driver_list = driver_list, vehicle_list = vehicle_list, vehicle_id = vehicle_id)

    else:
        return redirect("/login")

@app.route("/booknow", methods=["POST"])
def booknow():
    if 'user' in session:
        user = session['user']

        vehicle_id = request.form['vehicle_id']
        vehicle_id = int(vehicle_id)

        customer_list = getCustomer()
        customer_info:list=[]
        for customer in customer_list:
            if customer['customer_id'] == user:          
                customer_info.append(customer)

        return render_template("/booknow.html", vehicle_id = vehicle_id, customer_info = customer_info)
    
    else:
        return redirect("/login")

@app.route("/booking_conf", methods=["POST"])
def booking_conf():
    if 'user' in session:
        user = session['user']

        pick_location = request.form['pick_up_loc']
        destination = request.form['destination']
        num_days = request.form['num_days']
        vehicle_id = request.form['vehicle_id']
        vehicle_id = int(vehicle_id)

        if pick_location == "" or destination == "" or num_days == "":
            customer_list = getCustomer()
            customer_info:list=[]
            for customer in customer_list:
                if customer['customer_id'] == user:          
                    customer_info.append(customer)

            return render_template("/booknow.html", vehicle_id = vehicle_id, customer_info = customer_info, message = "Please fill up!")

        else:
            driver_list = getDriver()
            vehicle_list = getVehicle() 
            customer_list = getCustomer()
            customer_info:list=[]
            for customer in customer_list:
                if customer['customer_id'] == user:          
                    customer_info.append(customer)
            
            total_amount:float
            for vehicle in vehicle_list:
                if vehicle['vehicle_id'] == vehicle_id:
                    num_days = float(num_days)
                    total_amount = num_days * vehicle['rent_price']
                    num_days = int(num_days)

            return render_template("/booking_conf.html", driver_list = driver_list, vehicle_list = vehicle_list, vehicle_id = vehicle_id, customer_info = customer_info, pick_location = pick_location, destination = destination, num_days = num_days, total_amount = total_amount)
    else:
        return redirect("/login")

@app.route("/bookings", methods=["POST"])
def bookings():
    if 'user' in session:
        user = session['user']

        booking_conf = request.form['booking_conf_btn']

        destination_list = getDestination()
        destination_id = len(destination_list)+1

        transaction_list = getTransaction()
        transaction_id = len(transaction_list)+1


        if booking_conf == "Cancel":
            vehicle_id = int(vehicle_id)

            customer_list = getCustomer()
            customer_info:list=[]
            for customer in customer_list:
                if customer['customer_id'] == user:          
                    customer_info.append(customer)

            return render_template("/booknow.html", vehicle_id = vehicle_id, customer_info = customer_info)

        elif booking_conf == "Confirm Booking":

            pick_location = request.form['pick_up_loc']
            destination = request.form['destination']
            num_days = request.form['num_days']
            total_amount = request.form['total_amount']
            total_amount = float(total_amount)

            print(user)
            print(vehicle_id)
            print(pick_location)
            print(destination)
            print(num_days)
            print(total_amount)

            sql=f"INSERT INTO `destination`(`destination_id`,`destination`,`num_days`,`pick_address`) VALUES('{destination_id}','{destination}','{num_days}','{pick_location}')"
            cursor=db.cursor(dictionary=True)
            cursor.execute(sql)
            db.commit()
            cursor.close()

            sql=f"INSERT INTO `transaction`(`transaction_id`,`customer_id`,`vehicle_id`,`destination_id`,`total_payment`, `payment_id`) VALUES('{transaction_id}','{user}','{vehicle_id}','{destination_id}', '{total_amount}', NULL)"
            cursor=db.cursor(dictionary=True)
            cursor.execute(sql)
            db.commit()
            cursor.close()

            customer_booking:list=[]
            for transaction in transaction_list:
                if transaction['customer_id'] == user:
                    customer_booking.append(transaction)

            return render_template("/bookings.html", customer_booking = customer_booking)

        elif booking_conf == "BOOKINGS":
            customer_booking:list=[]
            for transaction in transaction_list:
                if transaction['customer_id'] == user:
                    customer_booking.append(transaction)

            return render_template("/bookings.html", customer_booking = customer_booking)

    else:
        return redirect("/login")

@app.route("/payment", methods=["POST"])
def payment():
    if 'user' in session:
        user = session['user']

        transaction_list = getTransaction()

        customer_booking:list=[]
        for transaction in transaction_list:
            if transaction['customer_id'] == user:
                customer_booking.append(transaction)

        return render_template("/payment.html", customer_booking = customer_booking)
    
    else:
        return redirect("/login")

@app.route("/profile")
def profile():
    if 'user' in session:
        user = session['user']

        customer_list = getCustomer()
        customer_info:list=[]
        for customer in customer_list:
            if customer['customer_id'] == user:          
                customer_info.append(customer)
                return render_template("/profile.html", customer_info = customer_info)
    
    else:
        return redirect("/login")

@app.route("/profileupdate", methods=["POST"])
def profileupdate():
    if 'user' in session:
        user = session['user']

        fname:str = request.form['fname']
        lname:str = request.form['lname']
        location:str = request.form['location']
        contact_num:int = request.form['contact_no']
        email:str = request.form['email']
        age:int = request.form['age']
        gender:str = request.form['gender']
        birth_month:str = request.form['month']
        birth_day:int = request.form['day']
        birth_year:int = request.form['year']
        username:str = request.form['username']

        print(fname)
        print(lname)
        print(location)
        print(contact_num)
        print(email)
        print(age)
        print(gender)
        print(birth_month)
        print(birth_day)
        print(birth_year)
        print(fname)
        print(username)

        sql=f"Update `customer`set `firstname`= '{fname}',`lastname` = '{lname}',`location`= '{location}', `contact_num`= '{contact_num}', `email` = '{email}', `gender` = '{gender}', `birth_month` = '{birth_month}', `birth_day` = '{birth_day}', `birth_year` = '{birth_year}', `age` = '{age}', `username` = '{username}' where `customer_id` = '{user}'"
        cursor=db.cursor(dictionary=True)
        cursor.execute(sql)
        db.commit()
        cursor.close()

        return redirect("/profile_edit")
    else:
        return redirect("/login")

@app.route("/profile_edit")
def profile_edit():
    if 'user' in session:
        user = session['user']

        customer_list = getCustomer()
        customer_info:list=[]
        for customer in customer_list:
            if customer['customer_id'] == user:          
                customer_info.append(customer)
                return render_template("/profile_edit.html", customer_info = customer_info)
    
    else:
        return redirect("/login")

@app.route("/register")
def register():
    if 'user' in session:
        user = session['user']

        return render_template("/register.html")
    
    else:
        return redirect("/login")

@app.route("/vehicle_details1")
def vehicle_details1():
    if 'user' in session:
        user = session['user']

        return render_template("/vehicle_details1.html")
    
    else:
        return redirect("/login")

@app.route("/vehicle")
def vehicle():
    if 'user' in session:
        user = session['user']

        return render_template("/vehicle.html")
    
    else:
        return redirect("/login")

@app.route("/login")
def login():
    return render_template("/login.html")

@app.route("/account_login", methods=["POST"])
def account_login():
    username:str = request.form['username']
    password:str = request.form['password']

    customer_list = getCustomer()
    for customer in customer_list:
        if customer['username'] == username and customer['password'] == password:
            session['user'] = customer['customer_id']
            return redirect("/home")

    return redirect("/login")

@app.route("/registration")
def registration():
    return render_template("/register.html")

@app.route("/new_customer_registration", methods=["POST"])
def new_customer_registration():
    customer_list = getCustomer()
    customer_id = len(customer_list)+1

    fname:str = request.form['fname']
    lname:str = request.form['lname']
    location:str = request.form['location']
    contact_num:int = request.form['contact_no']
    email:str = request.form['email']
    age:int = request.form['age']
    gender:str = request.form['gender']
    birth_month:str = request.form['month']
    birth_day:int = request.form['days']
    birth_year:int = request.form['year']
    username:str = request.form['username']
    password:str = request.form['password']

    sql=f"INSERT INTO `customer`(`customer_id`,`lastname`,`firstname`,`location`, `contact_num`, `email`, `gender`, `birth_month`, `birth_day`, `birth_year`, `age`, `custValid_id`, `username`,`password`) VALUES('{customer_id}','{lname}','{fname}','{location}','{contact_num}','{email}','{gender}','{birth_month}', '{birth_day}','{birth_year}','{age}','','{username}', '{password}')"
    cursor=db.cursor(dictionary=True)
    cursor.execute(sql)
    db.commit()
    cursor.close()

    session['user'] = customer_id
    return redirect("/home")
@app.route("/home")
def homepage():
    if 'user' in session:
        user = session['user']

        print(user)
        return render_template("/home.html")
    
    else:
        return redirect("/")

@app.route("/")
def index():
    return render_template("/index.html")

@app.route("/logout")
def logout():
    session.pop('user', None)
    return redirect("/")
 
if __name__=="__main__":
    app.run(host="0.0.0.0",debug=True)