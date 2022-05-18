# Flask Backend

# Getting Started 🚀
# Installation & Setup
### 1. Create and activate a virtualenv using python 3.8.9 
->Python version 3.10 does not work with this version of Flask-JWT


```
virtualenv venv --python=python3.8.9
```

### 2. Install all required modules
```
pip install -r requirements.txt
```

### 3. Change directory to code folder

```
cd code
```

### 3. Change the host='ipv4' to your ipv4 address

_Your ipv4 address can be found using cmd by typing ipconfig_

```
app.run(port=5000, debug=True, host='192.168.1.160)
```

### 5. Start application
```
python app.py
```

# Available end points

### /auth POST

```
{ipv4Address}:5000/auth
```

### /register POST

```
{ipv4Address}:5000/register
```






