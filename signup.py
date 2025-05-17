import tkinter as tk
from tkinter import messagebox
import pymysql

def create_signup_window():
    window = tk.Tk()
    window.title("Signup")
    window.geometry('925x500+300+200')
    window.configure(bg="#f0f2f5")
    window.resizable(False, False)

    def connect_database():
        username = user.get()
        password = code.get()
        confirm_password = confirm_code.get()
        if not username or username == 'Username' or not password or password == 'Password' or not confirm_password or confirm_password == 'Confirm Password':
            messagebox.showerror('Error', 'All Fields Are Required')
            return
        if password != confirm_password:
            messagebox.showerror('Error', 'Password Mismatch')
            return
        try:
            con = pymysql.connect(host='localhost', user='root', password='', database='pos_db')
            mycursor = con.cursor()
        except:
            messagebox.showerror('Error', 'Database Connectivity Issue, Please Try Again')
            return

        try:
            mycursor.execute('''
                CREATE TABLE IF NOT EXISTS users (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    username VARCHAR(255) UNIQUE,
                    password VARCHAR(255),
                    is_admin TINYINT(1) DEFAULT 0
                )
            ''')
            mycursor.execute('SELECT COUNT(*) FROM users WHERE username = %s', (username,))
            if mycursor.fetchone()[0] > 0:
                messagebox.showerror('Error', 'Username already exists')
                con.close()
                return
            query = 'INSERT INTO users (username, password) VALUES (%s, %s)'
            mycursor.execute(query, (username, password))
            con.commit()
            messagebox.showinfo('Success', 'Registration is successful')
            con.close()
            open_login()
        except Exception as e:
            messagebox.showerror('Error', f"Failed to register: {e}")
            con.close()
            window.destroy()

    def open_login():
        from login import create_login_window
        window.destroy()
        login_window = create_login_window()
        login_window.mainloop()

    frame = tk.Frame(window, width=350, height=390, bg='white')
    frame.place(x=480, y=50)

    heading = tk.Label(
        frame, text='Sign up', fg="#57a1f8", bg='white',
        font=('Microsoft YaHei UI Light', 23, 'bold')
    )
    heading.place(x=100, y=5)

    def on_enter(e):
        user.delete(0, 'end')

    def on_leave(e):
        if user.get() == '':
            user.insert(0, 'Username')

    user = tk.Entry(
        frame, width=25, fg='black', border=0, bg='white',
        font=('Microsoft YaHei UI Light', 11)
    )
    user.place(x=30, y=80)
    user.insert(0, 'Username')
    user.bind('<FocusIn>', on_enter)
    user.bind('<FocusOut>', on_leave)

    tk.Frame(frame, width=295, height=2, bg='black').place(x=25, y=107)

    def on_enter(e):
        code.delete(0, 'end')
        code.config(show="*")

    def on_leave(e):
        if code.get() == '':
            code.config(show="")
            code.insert(0, 'Password')

    code = tk.Entry(
        frame, width=25, fg='black', border=0, bg='white',
        font=('Microsoft YaHei UI Light', 11), show=""
    )
    code.place(x=30, y=150)
    code.insert(0, 'Password')
    code.bind('<FocusIn>', on_enter)
    code.bind('<FocusOut>', on_leave)

    tk.Frame(frame, width=295, height=2, bg='black').place(x=25, y=177)

    def on_enter(e):
        confirm_code.delete(0, 'end')
        confirm_code.config(show="*")

    def on_leave(e):
        if confirm_code.get() == '':
            confirm_code.config(show="")
            confirm_code.insert(0, 'Confirm Password')

    confirm_code = tk.Entry(
        frame, width=25, fg='black', border=0, bg='white',
        font=('Microsoft YaHei UI Light', 11), show=""
    )
    confirm_code.place(x=30, y=220)
    confirm_code.insert(0, 'Confirm Password')
    confirm_code.bind('<FocusIn>', on_enter)
    confirm_code.bind('<FocusOut>', on_leave)

    tk.Frame(frame, width=295, height=2, bg='black').place(x=25, y=247)

    tk.Button(
        frame, width=39, pady=7, text='Sign up',
        bg='#57a1f8', fg='white', border=0, command=connect_database
    ).place(x=35, y=280)

    label = tk.Label(
        frame, text="I have an account",
        fg='black', bg='white', font=('Microsoft YaHei UI Light', 9)
    )
    label.place(x=90, y=340)

    signin = tk.Button(
        frame, width=6, text="Sign in", border=0,
        bg='white', cursor='hand2', fg='#57a1f8', command=open_login
    )
    signin.place(x=200, y=340)

    return window

if __name__ == "__main__":
    window = create_signup_window()
    window.mainloop()