# CBA Recruitment Application
from flask import Flask, render_template, jsonify,flash,request,redirect, url_for, session
import pandas as pd
import numpy as np
import model #Database model

app = Flask(__name__)
app.config["SECRET_KEY"] = "OCML3BRawWEUeaxcuKHLpw"

@app.route('/')
def index():
	'''Home Page'''
	if 'session_data' in session: #check session login
		if session['session_data']['admin_logged_in'] == True:
			result = model.list_form()
			thelist = []
			for row in result:
				action = '/update/{0}'.format(row[0])
				status = switch_case(row[4])
				listvalue = list((row[1], row[2], row[3], status, action))
				thelist.append(listvalue)
			return render_template('index.html', result=thelist)
	return redirect('/login')		

def switch_case(arg):
	'''switch case functionality'''
	switcher = { 0:"FirstRound",1: "SecondRound",2: "Selected",3: "Onboard"}
	return switcher.get(int(arg))

@app.route('/insert', methods = ['GET', 'POST'])
def insert():
	'''Insert employee details'''
	if request.method == 'POST': 
		model.create_form(request.form)
		return redirect(url_for('index'))
	return render_template('insert.html')

@app.route('/update/<int:id>', methods = ['GET', 'POST'])
def update(id=None):
	'''Update the employee records'''
	if id:
		edit_form = model.edit_form(id)
		for edit_value in edit_form:
			db_data = dict(id=edit_value[0], name=edit_value[1], role=edit_value[2], team= edit_value[3], status=edit_value[4])
	if request.method == 'POST':
		model.update_form(request.form, id)
		return redirect(url_for('index'))
	return render_template('update.html', data=db_data) 

@app.route('/export', methods = ['GET', 'POST'])
def export():
	'''Export the selected employee records'''
	res_list = model.list_form()
	column_name = ["id", "name", "role", "team", "status"]
	df = pd.DataFrame(list(res_list),columns=column_name)
	# Create a Pandas Excel writer using XlsxWriter as the engine.
	# Also set the default datetime and date formats.
	path = "employee.xlsx"
	writer = pd.ExcelWriter(path, engine='xlsxwriter', date_format='yyyy-mm-dd')

	# Convert the dataframe to an XlsxWriter Excel object.
	df.to_excel(writer, sheet_name='cba_employee', index=False)

	# Get the xlsxwriter workbook and worksheet objects in order to set the column
	# widths, to make the dates clearer.
	# workbook  = writer.book
	worksheet = writer.sheets['cba_employee']

	worksheet.set_column('A:B', 20)

	# Close the Pandas Excel writer and output the Excel file.
	writer.save()
	return redirect('/')

@app.route('/login', methods = ['GET', 'POST'])
def login():
	'''Admin login page'''
	#Check if admin is already login
	if 'session_data' in session:
		if session['session_data']['admin_logged_in'] == True:
			return redirect('/')
	#Fetch post value from login form   
	if request.method == "POST":
		name = request.form.get("name")
		password = request.form.get("password")
		#Check user name and password is match to db details
		try:
			checklogin = model.check_login(name, password)
			checklogin = [element for tupl in checklogin for element in tupl]
			#Set session
			session_data = dict(name=checklogin[1], email=checklogin[2], id=checklogin[0], admin_logged_in=True)
			session['session_data'] = session_data
			return redirect('/')
		except:
			return redirect('/login')       
	return render_template('login.html')

@app.route("/logout")
def logout():
	'''Logout the session'''
	clear_session = [session.pop(key) for key in list(session.keys())]	
	return redirect("/login")

if __name__ == '__main__':
	app.run(host='0.0.0.0',port=80,debug=True)