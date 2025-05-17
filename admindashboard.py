from tkinter import *
from tkinter import ttk, messagebox
import pymysql
from datetime import datetime

def create_admin_dashboard(username):
    window = Tk()
    window.title("POS Admin Dashboard")
    window.geometry('925x500+300+200')
    window.configure(bg="#f0f2f5")
    window.resizable(False, False)

    def get_db_connection():
        try:
            return pymysql.connect(host='localhost', user='root', password='', database='pos_db')
        except Exception as e:
            messagebox.showerror("Error", f"Database connection failed: {e}")
            return None

    def log_action(action):
        conn = get_db_connection()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute('''
                    INSERT INTO employee_logs (username, action, log_time)
                    VALUES (%s, %s, %s)
                ''', (username, action, datetime.now()))
                conn.commit()
            except Exception as e:
                messagebox.showerror("Error", f"Failed to log action: {e}")
            finally:
                conn.close()

    # Sidebar
    sidebar = Frame(window, bg="#2c3e50", width=200)
    sidebar.pack(side=LEFT, fill=Y)

    Label(sidebar, text=f"Admin: {username}", bg="#2c3e50", fg="white", font=('Microsoft YaHei UI Light', 12, 'bold')).pack(pady=20)

    def show_frame(frame, tab_name):
        for f in [history_frame, restock_frame, inventory_frame, reports_frame]:
            f.pack_forget()
        frame.pack(side=RIGHT, fill=BOTH, expand=True, padx=20, pady=20)
        log_action(f"Switched to {tab_name} tab")

    history_button = Button(sidebar, text="Employee History", bg="#57a1f8", fg="white", font=('Microsoft YaHei UI Light', 11), border=0, command=lambda: show_frame(history_frame, "Employee History"))
    history_button.pack(fill=X, pady=5, padx=10)

    restock_button = Button(sidebar, text="Restock Inventory", bg="#57a1f8", fg="white", font=('Microsoft YaHei UI Light', 11), border=0, command=lambda: show_frame(restock_frame, "Restock Inventory"))
    restock_button.pack(fill=X, pady=5, padx=10)

    inventory_button = Button(sidebar, text="Inventory", bg="#57a1f8", fg="white", font=('Microsoft YaHei UI Light', 11), border=0, command=lambda: show_frame(inventory_frame, "Inventory"))
    inventory_button.pack(fill=X, pady=5, padx=10)

    reports_button = Button(sidebar, text="Sales Reports", bg="#57a1f8", fg="white", font=('Microsoft YaHei UI Light', 11), border=0, command=lambda: show_frame(reports_frame, "Sales Reports"))
    reports_button.pack(fill=X, pady=5, padx=10)

    logout_button = Button(sidebar, text="Logout", bg="#ff4444", fg="white", font=('Microsoft YaHei UI Light', 11), border=0, command=lambda: [log_action("Logged out"), logout()])
    logout_button.pack(side=BOTTOM, fill=X, pady=5, padx=10)

    # Main content area
    content_frame = Frame(window, bg="white", bd=1, relief=SOLID)
    content_frame.pack(side=RIGHT, fill=BOTH, expand=True, padx=20, pady=20)

    # Employee History Frame
    history_frame = Frame(content_frame, bg="white")

    def view_history():
        for widget in history_list_frame.winfo_children():
            widget.destroy()
        username_filter = username_entry.get()
        date_filter = date_entry.get()
        conn = get_db_connection()
        if not conn:
            return
        try:
            cursor = conn.cursor()
            query = 'SELECT username, action, log_time FROM employee_logs'
            params = []
            conditions = []
            if username_filter:
                conditions.append('username LIKE %s')
                params.append(f'%{username_filter}%')
            if date_filter:
                conditions.append('DATE(log_time) = %s')
                params.append(date_filter)
            if conditions:
                query += ' WHERE ' + ' AND '.join(conditions)
            query += ' ORDER BY log_time DESC'
            cursor.execute(query, params)
            logs = cursor.fetchall()
            for i, (user, action, log_time) in enumerate(logs):
                Label(history_list_frame, text=f"{log_time}: {user} - {action}", bg='white', font=('Microsoft YaHei UI Light', 10), anchor='w').grid(row=i, column=0, padx=10, pady=2, sticky=W)
            history_list_frame.update_idletasks()
            history_canvas.config(scrollregion=history_canvas.bbox("all"))
        except Exception as e:
            messagebox.showerror("Error", f"Failed to load logs: {e}")
        finally:
            conn.close()

    Label(history_frame, text="Employee History", bg='white', font=('Microsoft YaHei UI Light', 16, 'bold')).pack(pady=10)
    Label(history_frame, text="Username Filter:", bg='white', font=('Microsoft YaHei UI Light', 11)).pack(anchor=W, padx=10)
    username_entry = Entry(history_frame, font=('Microsoft YaHei UI Light', 11))
    username_entry.pack(pady=5, padx=10)
    Label(history_frame, text="Date Filter (YYYY-MM-DD):", bg='white', font=('Microsoft YaHei UI Light', 11)).pack(anchor=W, padx=10)
    date_entry = Entry(history_frame, font=('Microsoft YaHei UI Light', 11))
    date_entry.pack(pady=5, padx=10)
    Button(history_frame, text="View History", bg='#57a1f8', fg='white', font=('Microsoft YaHei UI Light', 11), command=view_history).pack(pady=10)
    history_canvas = Canvas(history_frame, bg='white', height=200, highlightthickness=0)
    history_scrollbar = Scrollbar(history_frame, orient=VERTICAL, command=history_canvas.yview)
    history_list_frame = Frame(history_canvas, bg='white')
    history_canvas.configure(yscrollcommand=history_scrollbar.set)
    history_scrollbar.pack(side=RIGHT, fill=Y)
    history_canvas.pack(pady=10, fill=BOTH, expand=True)
    history_canvas.create_window((0, 0), window=history_list_frame, anchor='nw')
    def on_history_mouse_wheel(event):
        history_canvas.yview_scroll(-1 * (event.delta // 120), "units")
    history_canvas.bind_all("<MouseWheel>", on_history_mouse_wheel)

    # Restock Inventory Frame
    restock_frame = Frame(content_frame, bg='white')

    def update_restock_items_by_category():
        category = category_var_restock.get()
        conn = get_db_connection()
        items = []
        if conn:
            try:
                cursor = conn.cursor()
                if category == "All Categories":
                    cursor.execute('SELECT name FROM items')
                else:
                    cursor.execute('SELECT name FROM items WHERE category=%s', (category,))
                items = [row[0] for row in cursor.fetchall()]
            except Exception as e:
                messagebox.showerror("Error", f"Failed to load items: {e}")
            finally:
                conn.close()
        item_combobox_restock['values'] = items
        item_var_restock.set('')

    def restock_item():
        item_name = item_var_restock.get()
        stock_qty = stock_entry.get()
        if not item_name or not stock_qty:
            messagebox.showerror("Error", "Please select an item and enter stock quantity")
            return
        try:
            stock_qty = int(stock_qty)
            if stock_qty <= 0:
                raise ValueError("Stock quantity must be positive")
            if stock_qty > 100000:
                raise ValueError("Stock quantity cannot exceed 100,000")
            conn = get_db_connection()
            if not conn:
                return
            cursor = conn.cursor()
            cursor.execute('SELECT id, stock FROM items WHERE name=%s', (item_name,))
            item = cursor.fetchone()
            if not item:
                messagebox.showerror("Error", "Item not found")
                return
            item_id, current_stock = item
            new_stock = current_stock + stock_qty
            if not messagebox.askyesno("Confirm Restock", f"Restock {stock_qty} units of {item_name}? Current stock: {current_stock}, New stock: {new_stock}"):
                return
            cursor.execute('UPDATE items SET stock=stock+%s WHERE id=%s', (stock_qty, item_id))
            cursor.execute('''
                INSERT INTO employee_logs (username, action, log_time)
                VALUES (%s, %s, %s)
            ''', (username, f'Restocked {stock_qty} units of {item_name}', datetime.now()))
            conn.commit()
            messagebox.showinfo("Success", f"Restocked {stock_qty} units of {item_name}. New stock: {new_stock}")
            item_var_restock.set('')
            stock_entry.delete(0, 'end')
            update_restock_items_by_category()
        except ValueError as e:
            messagebox.showerror("Error", str(e))
        except Exception as e:
            messagebox.showerror("Error", f"Failed to restock: {e}")
        finally:
            if conn:
                conn.close()

    Label(restock_frame, text="Restock Inventory", bg='white', font=('Microsoft YaHei UI Light', 16, 'bold')).grid(row=0, column=0, columnspan=2, pady=10)
    Label(restock_frame, text="Category:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=1, column=0, sticky=W, padx=10)
    category_var_restock = StringVar()
    categories = ['All Categories', 'Processors', 'Graphics Cards', 'Memory', 'Storage', 'Motherboards', 'Power Supplies', 'Cases', 'Peripherals']
    category_combobox_restock = ttk.Combobox(restock_frame, textvariable=category_var_restock, values=categories, state='readonly', width=30)
    category_combobox_restock.grid(row=1, column=1, pady=5, padx=10)
    category_combobox_restock.set('All Categories')
    category_combobox_restock.bind('<<ComboboxSelected>>', lambda e: update_restock_items_by_category())
    Label(restock_frame, text="Item:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=2, column=0, sticky=W, padx=10)
    item_var_restock = StringVar()
    conn = get_db_connection()
    items = []
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute('SELECT name FROM items')
            items = [row[0] for row in cursor.fetchall()]
        except Exception as e:
            messagebox.showerror("Error", f"Failed to load items: {e}")
        finally:
            conn.close()
    item_combobox_restock = ttk.Combobox(restock_frame, textvariable=item_var_restock, values=items, state='readonly', width=30)
    item_combobox_restock.grid(row=2, column=1, pady=5, padx=10)
    Label(restock_frame, text="Additional Stock Quantity:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=3, column=0, sticky=W, padx=10)
    stock_entry = Entry(restock_frame, width=10, font=('Microsoft YaHei UI Light', 11))
    stock_entry.grid(row=3, column=1, pady=5, padx=10)
    Button(restock_frame, text="Restock Item", bg='#57a1f8', fg='white', font=('Microsoft YaHei UI Light', 11), command=restock_item).grid(row=4, column=0, columnspan=2, pady=10)

    # Inventory Frame
    inventory_frame = Frame(content_frame, bg='white')
    auto_refresh_var = IntVar(value=1)

    def refresh_inventory(search_term='', category='All Categories', brand='All Brands'):
        for widget in inventory_list_frame.winfo_children():
            widget.destroy()
        conn = get_db_connection()
        if not conn:
            return
        try:
            cursor = conn.cursor()
            query = 'SELECT category, name, price, stock FROM items'
            params = []
            conditions = []
            if search_term:
                conditions.append('name LIKE %s')
                params.append(f'%{search_term}%')
            if category != "All Categories":
                conditions.append('category=%s')
                params.append(category)
            if brand == "AMD":
                conditions.append('(name LIKE %s OR name LIKE %s)')
                params.extend(['%AMD%', '%Ryzen%'])
            elif brand == "Intel":
                conditions.append('(name LIKE %s OR name LIKE %s)')
                params.extend(['%Intel%', '%Core%'])
            if conditions:
                query += ' WHERE ' + ' AND '.join(conditions)
            cursor.execute(query, params)
            items = cursor.fetchall()
            for i, (cat, name, price, stock) in enumerate(items):
                Label(inventory_list_frame, text=f"[{cat}] {name}: ₱{price:.2f}, Stock: {stock}", bg='white', font=('Microsoft YaHei UI Light', 10), anchor='w').grid(row=i, column=0, padx=10, pady=5, sticky=W)
            inventory_list_frame.update_idletasks()
            canvas.config(scrollregion=canvas.bbox("all"))
        except Exception as e:
            messagebox.showerror("Error", f"Failed to load inventory: {e}")
        finally:
            conn.close()

    def search_inventory():
        refresh_inventory(search_entry.get(), category_var_inv.get(), brand_var.get())

    def update_inventory_by_category():
        refresh_inventory(search_entry.get(), category_var_inv.get(), brand_var.get())

    def update_inventory_by_brand():
        refresh_inventory(search_entry.get(), category_var_inv.get(), brand_var.get())

    def auto_refresh_inventory():
        if auto_refresh_var.get():
            refresh_inventory(search_entry.get(), category_var_inv.get(), brand_var.get())
            inventory_frame.after(5000, auto_refresh_inventory)

    Label(inventory_frame, text="Inventory", bg='white', font=('Microsoft YaHei UI Light', 16, 'bold')).grid(row=0, column=0, columnspan=5, pady=10)
    Label(inventory_frame, text="Category:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=1, column=0, sticky=W, padx=10)
    category_var_inv = StringVar()
    category_combobox_inv = ttk.Combobox(inventory_frame, textvariable=category_var_inv, values=categories, state='readonly', width=20)
    category_combobox_inv.grid(row=1, column=1, pady=5, padx=5)
    category_combobox_inv.set('All Categories')
    category_combobox_inv.bind('<<ComboboxSelected>>', lambda e: update_inventory_by_category())
    Label(inventory_frame, text="Brand:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=1, column=2, sticky=W, padx=5)
    brand_var = StringVar()
    brand_combobox = ttk.Combobox(inventory_frame, textvariable=brand_var, values=['All Brands', 'AMD', 'Intel'], state='readonly', width=15)
    brand_combobox.grid(row=1, column=3, pady=5, padx=5)
    brand_combobox.set('All Brands')
    brand_combobox.bind('<<ComboboxSelected>>', lambda e: update_inventory_by_brand())
    Label(inventory_frame, text="Search:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=2, column=0, sticky=W, padx=10)
    search_entry = Entry(inventory_frame, font=('Microsoft YaHei UI Light', 11), width=20)
    search_entry.grid(row=2, column=1, padx=5, pady=5)
    Button(inventory_frame, text="Search/Refresh", bg='#57a1f8', fg='white', font=('Microsoft YaHei UI Light', 11), command=search_inventory).grid(row=2, column=2, padx=5, pady=5)
    Checkbutton(inventory_frame, text="Auto-Refresh", variable=auto_refresh_var, bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=2, column=3, padx=5, pady=5)
    canvas = Canvas(inventory_frame, bg='white', highlightthickness=0)
    scrollbar = Scrollbar(inventory_frame, orient=VERTICAL, command=canvas.yview)
    inventory_list_frame = Frame(canvas, bg='white')
    canvas.configure(yscrollcommand=scrollbar.set)
    scrollbar.grid(row=3, column=4, sticky='ns')
    canvas.grid(row=3, column=0, columnspan=4, pady=10, sticky='nsew')
    canvas.create_window((0, 0), window=inventory_list_frame, anchor='nw', width=canvas.winfo_reqwidth())
    def on_mouse_wheel(event):
        canvas.yview_scroll(-1 * (event.delta // 120), "units")
    canvas.bind_all("<MouseWheel>", on_mouse_wheel)
    inventory_frame.grid_rowconfigure(3, weight=1)
    inventory_frame.grid_columnconfigure(0, weight=1)
    refresh_inventory()
    inventory_frame.after(5000, auto_refresh_inventory)

    # Sales Reports Frame
    reports_frame = Frame(content_frame, bg='white')

    def generate_sales_report():
        for widget in report_list_frame.winfo_children():
            widget.destroy()
        start_date = start_date_entry.get()
        end_date = end_date_entry.get()
        conn = get_db_connection()
        if not conn:
            return
        try:
            cursor = conn.cursor()
            query = '''
                SELECT s.employee_username, i.name, SUM(s.quantity) as total_qty, SUM(s.total) as total_amt
                FROM sales s JOIN items i ON s.item_id=i.id
            '''
            params = []
            conditions = []
            if start_date:
                conditions.append('DATE(s.sale_time) >= %s')
                params.append(start_date)
            if end_date:
                conditions.append('DATE(s.sale_time) <= %s')
                params.append(end_date)
            if conditions:
                query += ' WHERE ' + ' AND '.join(conditions)
            query += ' GROUP BY s.employee_username, i.name'
            cursor.execute(query, params)
            sales = cursor.fetchall()
            total_sales = sum(row[3] for row in sales)
            Label(report_list_frame, text=f"Total Sales: ₱{total_sales:.2f}", bg='white', font=('Microsoft YaHei UI Light', 12, 'bold')).pack(pady=5)
            for employee, name, qty, amt in sales:
                Label(report_list_frame, text=f"{employee}: {name}: {qty} units, ₱{amt:.2f}", bg='white', font=('Microsoft YaHei UI Light', 10)).pack(pady=2)
        except Exception as e:
            messagebox.showerror("Error", f"Failed to generate report: {e}")
        finally:
            conn.close()

    Label(reports_frame, text="Sales Reports", bg='white', font=('Microsoft YaHei UI Light', 16, 'bold')).pack(pady=10)
    Label(reports_frame, text="Start Date (YYYY-MM-DD):", bg='white', font=('Microsoft YaHei UI Light', 11)).pack(anchor=W, padx=10)
    start_date_entry = Entry(reports_frame, font=('Microsoft YaHei UI Light', 11))
    start_date_entry.pack(pady=5, padx=10)
    Label(reports_frame, text="End Date (YYYY-MM-DD):", bg='white', font=('Microsoft YaHei UI Light', 11)).pack(anchor=W, padx=10)
    end_date_entry = Entry(reports_frame, font=('Microsoft YaHei UI Light', 11))
    end_date_entry.pack(pady=5, padx=10)
    Button(reports_frame, text="Generate Report", bg='#57a1f8', fg='white', font=('Microsoft YaHei UI Light', 11), command=generate_sales_report).pack(pady=5)
    report_list_frame = Frame(reports_frame, bg='white')
    report_list_frame.pack(pady=10)

    # Logout Function
    def logout():
        conn = get_db_connection()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute('UPDATE users SET is_logged_in=0 WHERE username=%s', (username,))
                conn.commit()
            except Exception as e:
                messagebox.showerror("Error", f"Failed to update login status: {e}")
            finally:
                conn.close()
        from login import create_login_window
        window.destroy()
        login_window = create_login_window()
        login_window.mainloop()

    # Show History frame by default
    show_frame(history_frame, "Employee History")
    log_action("Logged in")

    return window

if __name__ == "__main__":
    window = create_admin_dashboard("admin1")
    window.mainloop()