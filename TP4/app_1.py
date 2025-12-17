from flask import Flask, request, render_template
import mysql.connector

app = Flask(__name__)
 
# MySQL configuration
db_config = {
    'host': 'tp4-sql',
    'user': 'root',
    'password': 'foo',
    'database': 'demosql'
}

# Initialize MySQL connection
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor() 


@app.route('/newuser',methods = ['POST', 'GET'])
def saisie():
	if request.method =='POST':
		res = request.form.get( "nom" )
		#return res.text()
		if re.fullmatch( ".{6,}", str ) == None:
			print( "Echec sur la condition 1" )
		else:
			if re.fullmatch ( ".*\d+.*", str ) == None:
				print( "Echec sur la condition 2" )
			else re.fullmatch( "[A-Z]+[a-z]+", str ) == None:
				print( "Echec sur la condition 3" )
			else re.fullmath ( "[#%\{\}@]+", str ) == None:
				print( "Echec sur la condition 4" )
		else
			return None




@app.route('/')
def index():
    # Sample query
    query = "SELECT * FROM myTable"
    cursor.execute(query)
    data = cursor.fetchall()
    
    # Close the cursor and connection
#    cursor.close()
#    conn.close()
    
    return render_template('index.html', data=data)

if __name__ == '__main__':
    app.run(debug=True)
    

