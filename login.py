from tkinter import *
from tkinter import messagebox
import pymysql
from employeedashboard import create_dashboard_window
from admindashboard import create_admin_dashboard
from signup import create_signup_window

def create_login_window():
    root = Tk()
    root.title("POS System Login")
    root.geometry('925x500+300+200')
    root.configure(bg="#f0f2f5")
    root.resizable(False, False)

    # Sign-in logic connected to the database
    def signin():
        username = user.get()
        password = code.get()
        if username == '' or username == 'Username' or password == '' or password == 'Password':
            messagebox.showerror('Error', 'Please enter valid username and password')
            return
        try:
            connection = pymysql.connect(
                host="localhost",
                user="root",
                password="",
                database="pos_db"
            )
            cursor = connection.cursor()
            query = "SELECT username FROM users WHERE username=%s AND password=%s"
            cursor.execute(query, (username, password))
            result = cursor.fetchone()
            if result:
                root.destroy()
                dashboard_window = create_dashboard_window(username) if not username == 'admin' else create_admin_dashboard(username)
                dashboard_window.mainloop()
            else:
                messagebox.showerror("Invalid", "Invalid username or password!")
            connection.close()
        except Exception as e:
            messagebox.showerror("Error", f"Database connectivity issue: {e}")

    # Frame for user inputs
    frame = Frame(root, width=350, height=350, bg="white")
    frame.place(x=480, y=70)

    heading = Label(
        frame,
        text='POS System Login',
        fg='#57a1f8',
        bg='white',
        font=('Microsoft YaHei UI Light', 19, 'bold')
    )
    heading.place(x=75, y=5)

    def on_enter_username(e):
        if user.get() == 'Username':
            user.delete(0, 'end')

    def on_leave_username(e):
        if user.get() == '':
            user.insert(0, 'Username')

    user = Entry(
        frame, width=25, fg='black', border=0, bg='white',
        font=('Microsoft YaHei UI Light', 11)
    )
    user.place(x=30, y=80)
    user.insert(0, 'Username')
    user.bind('<FocusIn>', on_enter_username)
    user.bind('<FocusOut>', on_leave_username)

    Frame(frame, width=295, height=2, bg='black').place(x=25, y=107)

    def on_enter_password(e):
        if code.get() == 'Password':
            code.delete(0, 'end')
            code.config(show="*")

    def on_leave_password(e):
        if code.get() == '':
            code.config(show="")
            code.insert(0, 'Password')

    code = Entry(
        frame, width=25, fg='black', border=0, bg='white',
        font=('Microsoft YaHei UI Light', 11)
    )
    code.place(x=30, y=150)
    code.insert(0, 'Password')
    code.bind('<FocusIn>', on_enter_password)
    code.bind('<FocusOut>', on_leave_password)

    Frame(frame, width=295, height=2, bg='black').place(x=25, y=177)

    Button(
        frame, width=39, pady=7, text='Sign in',
        bg='#57a1f8', fg='white', border=0, command=signin
    ).place(x=35, y=204)

    label = Label(
        frame, text="Don't have an account?",
        fg='black', bg="white", font=('Microsoft YaHei UI Light', 9)
    )
    label.place(x=75, y=270)

    sign_up = Button(
        frame, width=6, text='Sign up', border=0,
        bg='white', cursor='hand2', fg='#57a1f8',
        command=lambda: [root.destroy(), create_signup_window().mainloop()]
    )
    sign_up.place(x=215, y=270)

    return root

if __name__ == "__main__":
    window = create_login_window()
    window.mainloop()