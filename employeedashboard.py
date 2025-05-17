from tkinter import *
from tkinter import ttk, messagebox
import pymysql
from datetime import datetime, date

def create_dashboard_window(username):
    window = Tk()
    window.title("POS Employee Dashboard")
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
            except:
                pass
            finally:
                conn.close()

    # Styling
    style = ttk.Style()
    style.configure("TCombobox", font=('Microsoft YaHei UI Light', 11))
    style.configure("TButton", font=('Microsoft YaHei UI Light', 11))
    button_style = {
        'font': ('Microsoft YaHei UI Light', 11),
        'bg': '#57a1f8', 'fg': 'white', 'border': 0,
        'activebackground': '#4682b4', 'activeforeground': 'white'
    }
    card_style = {'bg': 'white', 'bd': 1, 'relief': 'solid', 'padx': 10, 'pady': 10}

    # Sidebar
    sidebar = Frame(window, bg="#2c3e50", width=200)
    sidebar.pack(side=LEFT, fill=Y)

    Label(sidebar, text=f"Welcome, {username}", bg="#2c3e50", fg="white",
          font=('Microsoft YaHei UI Light', 12, 'bold')).pack(pady=20)

    # Track after ID for inventory refresh
    inventory_after_id = None

    def show_frame(frame, tab_name):
        nonlocal inventory_after_id
        for f in [sales_frame, inventory_frame, reports_frame, logs_frame]:
            f.pack_forget()
        if frame != inventory_frame and inventory_after_id:
            window.after_cancel(inventory_after_id)
            inventory_after_id = None
        frame.pack(side=RIGHT, fill=BOTH, expand=True, padx=20, pady=20)
        log_action(f"Switched to {tab_name} tab")
        if frame == inventory_frame and auto_refresh_var.get():
            auto_refresh_inventory()

    buttons = [
        ("Sales", lambda: show_frame(sales_frame, "Sales")),
        ("Inventory", lambda: show_frame(inventory_frame, "Inventory")),
        ("Reports", lambda: show_frame(reports_frame, "Reports")),
        ("My Logs", lambda: show_frame(logs_frame, "Logs"))
    ]
    for text, cmd in buttons:
        btn = Button(sidebar, text=text, **button_style, command=cmd)
        btn.pack(fill=X, pady=5, padx=10)
        btn.bind("<Enter>", lambda e, b=btn: b.config(bg='#4682b4'))
        btn.bind("<Leave>", lambda e, b=btn: b.config(bg='#57a1f8'))

    logout_button = Button(sidebar, text="Logout", font=('Microsoft YaHei UI Light', 11),
                           bg="#ff4444", fg="white", border=0,
                           command=lambda: [log_action("Logged out"), logout()])
    logout_button.pack(side=BOTTOM, fill=X, pady=5, padx=10)
    logout_button.bind("<Enter>", lambda e: logout_button.config(bg='#cc3333'))
    logout_button.bind("<Leave>", lambda e: logout_button.config(bg='#ff4444'))

    # Main content area
    content_frame = Frame(window, bg="#f0f2f5")
    content_frame.pack(side=RIGHT, fill=BOTH, expand=True, padx=20, pady=20)

    # Sales Frame
    sales_frame = Frame(content_frame, **card_style)
    cart = []

    def update_cart_display():
        for widget in cart_list_frame.winfo_children():
            widget.destroy()
        total = 0
        for i, (name, item_id, price, qty, supplier_id, supplier_name) in enumerate(cart):
            subtotal = price * qty
            total += subtotal
            frame = Frame(cart_list_frame, bg='white')
            frame.grid(row=i, column=0, sticky='w', pady=2)
            Label(frame, text=f"{name} ({supplier_name}): ₱{price:.2f} x ", bg='white',
                  font=('Microsoft YaHei UI Light', 10)).pack(side=LEFT)
            qty_var = IntVar(value=qty)
            qty_entry = Entry(frame, textvariable=qty_var, width=5,
                              font=('Microsoft YaHei UI Light', 10))
            qty_entry.pack(side=LEFT)
            Label(frame, text=f" = ₱{subtotal:.2f}", bg='white',
                  font=('Microsoft YaHei UI Light', 10)).pack(side=LEFT, padx=5)
            Button(frame, text="Update", bg='#57a1f8', fg='white',
                   font=('Microsoft YaHei UI Light', 9),
                   command=lambda n=name, v=qty_var: update_cart_quantity(n, v.get())).pack(side=LEFT, padx=5)
            Button(frame, text="Remove", bg='#ff4444', fg='white',
                   font=('Microsoft YaHei UI Light', 9),
                   command=lambda n=name: [remove_from_cart(n), log_action(f"Removed {n} from cart")]).pack(side=LEFT)
        total_label.config(text=f"Total: ₱{total:.2f}")

    def update_cart_quantity(item_name, new_qty):
        try:
            new_qty = int(new_qty)
            if new_qty <= 0:
                raise ValueError("Quantity must be positive")
            conn = get_db_connection()
            if not conn:
                return
            cursor = conn.cursor()
            cursor.execute('SELECT stock FROM items WHERE name=%s', (item_name,))
            stock = cursor.fetchone()[0]
            if new_qty > stock:
                messagebox.showerror("Error", f"Only {stock} units available")
                conn.close()
                return
            for i, (name, item_id, price, qty, supplier_id, supplier_name) in enumerate(cart):
                if name == item_name:
                    cart[i] = (name, item_id, price, new_qty, supplier_id, supplier_name)
                    break
            update_cart_display()
            log_action(f"Updated {item_name} quantity to {new_qty}")
            conn.close()
        except ValueError:
            messagebox.showerror("Error", "Invalid quantity")

    def add_to_cart():
        item_name = item_var.get()
        quantity = quantity_entry.get()
        supplier_name = supplier_var.get()
        if not item_name or not quantity or not supplier_name:
            messagebox.showerror("Error", "Please select an item, supplier, and enter a quantity")
            return
        try:
            quantity = int(quantity)
            if quantity <= 0:
                raise ValueError("Quantity must be positive")
            conn = get_db_connection()
            if not conn:
                return
            cursor = conn.cursor()
            cursor.execute('SELECT id, price, stock FROM items WHERE name=%s', (item_name,))
            item = cursor.fetchone()
            if not item:
                messagebox.showerror("Error", "Item not found")
                return
            item_id, price, stock = item
            cursor.execute('SELECT id FROM suppliers WHERE name=%s', (supplier_name,))
            supplier = cursor.fetchone()
            if not supplier:
                messagebox.showerror("Error", "Supplier not found")
                return
            supplier_id = supplier[0]
            if quantity > stock:
                messagebox.showerror("Error", f"Only {stock} units available")
                return
            for i, (name, _, _, qty, _, s_name) in enumerate(cart):
                if name == item_name and s_name == supplier_name:
                    new_qty = qty + quantity
                    if new_qty > stock:
                        messagebox.showerror("Error", f"Only {stock} units available")
                        return
                    cart[i] = (name, item_id, price, new_qty, supplier_id, supplier_name)
                    break
            else:
                cart.append((item_name, item_id, price, quantity, supplier_id, supplier_name))
            update_cart_display()
            log_action(f"Added {quantity} x {item_name} (Supplier: {supplier_name}) to cart")
            item_var.set('')
            supplier_var.set('')
            quantity_entry.delete(0, 'end')
        except ValueError as e:
            messagebox.showerror("Error", "Invalid quantity")
        finally:
            if conn:
                conn.close()

    def remove_from_cart(item_name):
        global cart
        cart = [item for item in cart if item[0] != item_name]
        update_cart_display()

    def clear_cart():
        global cart
        cart.clear()
        update_cart_display()
        log_action("Cleared cart")

    def show_receipt(cart, sale_time):
        receipt_window = Toplevel(window)
        receipt_window.title("Sale Receipt")
        receipt_window.geometry('400x400')
        receipt_window.configure(bg='white')
        receipt_window.resizable(False, False)
        receipt_window.grab_set()  # Make modal

        # Header
        Label(receipt_window, text="Sale Receipt", bg='white',
              font=('Microsoft YaHei UI Light', 16, 'bold')).pack(pady=10)
        Label(receipt_window, text=f"Date: {sale_time.strftime('%B %d, %Y, %I:%M %p')}",
              bg='white', font=('Microsoft YaHei UI Light', 10)).pack()

        # Itemized list
        receipt_frame = Frame(receipt_window, bg='white')
        receipt_frame.pack(padx=10, pady=10, fill=BOTH, expand=True)
        total = 0
        for i, (name, _, price, qty, _, supplier_name) in enumerate(cart):
            subtotal = price * qty
            total += subtotal
            Label(receipt_frame, text=f"{name} ({supplier_name})", bg='white',
                  font=('Microsoft YaHei UI Light', 10, 'bold'), anchor='w').grid(row=i*2, column=0, sticky='w', padx=5, pady=2)
            Label(receipt_frame, text=f"₱{price:.2f} x {qty} = ₱{subtotal:.2f}", bg='white',
                  font=('Microsoft YaHei UI Light', 10), anchor='w').grid(row=i*2+1, column=0, sticky='w', padx=15, pady=2)

        # Total
        Label(receipt_frame, text=f"Total: ₱{total:.2f}", bg='white',
              font=('Microsoft YaHei UI Light', 12, 'bold')).grid(row=len(cart)*2, column=0, pady=10)

        # OK Button
        Button(receipt_window, text="OK", **button_style, command=lambda: [receipt_window.destroy(), clear_cart()]).pack(pady=10)

    def process_sale():
        if not cart:
            messagebox.showerror("Error", "Cart is empty")
            return
        payment_method = payment_var.get()
        if not payment_method:
            messagebox.showerror("Error", "Please select a payment method")
            return
        conn = get_db_connection()
        if not conn:
            return
        try:
            cursor = conn.cursor()
            sale_time = datetime.now()
            for item_name, item_id, price, quantity, supplier_id, supplier_name in cart:
                total = price * quantity
                cursor.execute('''
                    INSERT INTO sales (employee_username, item_id, quantity, total, payment_method, supplier_id, sale_time)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                ''', (username, item_id, quantity, total, payment_method, supplier_id, sale_time))
                cursor.execute('UPDATE items SET stock=stock-%s WHERE id=%s', (quantity, item_id))
                cursor.execute('''
                    INSERT INTO employee_logs (username, action, log_time)
                    VALUES (%s, %s, %s)
                ''', (username, f'Sale: {quantity} x {item_name} ({payment_method}, Supplier: {supplier_name})', sale_time))
            conn.commit()
            # Show receipt before clearing cart
            show_receipt(cart, sale_time)
        except Exception as e:
            messagebox.showerror("Error", f"Failed to process sale: {e}")
        finally:
            conn.close()

    def update_items_by_category():
        category = category_var.get()
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
            finally:
                conn.close()
        item_combobox['values'] = items
        item_var.set('')

    def update_suppliers():
        conn = get_db_connection()
        suppliers = []
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute('SELECT name FROM suppliers')
                suppliers = [row[0] for row in cursor.fetchall()]
            finally:
                conn.close()
        supplier_combobox['values'] = suppliers
        supplier_var.set('')

    Label(sales_frame, text="Process Sale", bg='white', font=('Microsoft YaHei UI Light', 16, 'bold')).grid(row=0, column=0, columnspan=3, pady=10)
    Label(sales_frame, text="Category:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=1, column=0, sticky=W, padx=10)
    category_var = StringVar(value="All Categories")
    categories = ['All Categories', 'Processors', 'Graphics Cards', 'Memory', 'Storage', 'Motherboards', 'Power Supplies', 'Cases', 'Peripherals']
    category_combobox = ttk.Combobox(sales_frame, textvariable=category_var, values=categories, state='readonly', width=30)
    category_combobox.grid(row=1, column=1, pady=5, padx=10)
    category_combobox.bind('<<ComboboxSelected>>', lambda e: update_items_by_category())
    Label(sales_frame, text="Item:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=2, column=0, sticky=W, padx=10)
    item_var = StringVar()
    item_combobox = ttk.Combobox(sales_frame, textvariable=item_var, values=[], state='readonly', width=30)
    item_combobox.grid(row=2, column=1, pady=5, padx=10)
    update_items_by_category()
    Label(sales_frame, text="Supplier:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=3, column=0, sticky=W, padx=10)
    supplier_var = StringVar()
    supplier_combobox = ttk.Combobox(sales_frame, textvariable=supplier_var, values=[], state='readonly', width=30)
    supplier_combobox.grid(row=3, column=1, pady=5, padx=10)
    update_suppliers()
    Label(sales_frame, text="Quantity:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=4, column=0, sticky=W, padx=10)
    quantity_entry = Entry(sales_frame, width=10, font=('Microsoft YaHei UI Light', 11))
    quantity_entry.grid(row=4, column=1, pady=5, padx=10)
    Button(sales_frame, text="Add to Cart", **button_style, command=add_to_cart).grid(row=5, column=0, columnspan=2, pady=10)
    Label(sales_frame, text="Payment Method:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=6, column=0, sticky=W, padx=10)
    payment_var = StringVar()
    ttk.Combobox(sales_frame, textvariable=payment_var, values=['Cash', 'Card'], state='readonly', width=30).grid(row=6, column=1, pady=5, padx=10)
    cart_list_frame = Frame(sales_frame, bg='white')
    cart_list_frame.grid(row=7, column=0, columnspan=2, pady=10, sticky='w')
    total_label = Label(sales_frame, text="Total: ₱0.00", bg='white', font=('Microsoft YaHei UI Light', 12, 'bold'))
    total_label.grid(row=8, column=0, columnspan=2, pady=5)
    Button(sales_frame, text="Clear Cart", bg='#ff4444', fg='white', font=('Microsoft YaHei UI Light', 11), command=clear_cart).grid(row=9, column=0, pady=5)
    Button(sales_frame, text="Process Sale", **button_style, command=process_sale).grid(row=9, column=1, pady=5)

    # Inventory Frame
    inventory_frame = Frame(content_frame, **card_style)
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
                fg = '#ff4444' if stock <= 10 else 'black'
                Label(inventory_list_frame, text=f"[{cat}] {name}: ₱{price:.2f}, Stock: {stock}",
                      bg='white', fg=fg, font=('Microsoft YaHei UI Light', 10), anchor='w').grid(row=i, column=0, padx=10, pady=5, sticky=W)
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
        nonlocal inventory_after_id
        if auto_refresh_var.get() and inventory_frame.winfo_ismapped():
            refresh_inventory(search_entry.get(), category_var_inv.get(), brand_var.get())
            inventory_after_id = inventory_frame.after(5000, auto_refresh_inventory)
        else:
            inventory_after_id = None

    Label(inventory_frame, text="Inventory", bg='white', font=('Microsoft YaHei UI Light', 16, 'bold')).grid(row=0, column=0, columnspan=5, pady=10)
    Label(inventory_frame, text="Category:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=1, column=0, sticky=W, padx=10)
    category_var_inv = StringVar(value="All Categories")
    category_combobox_inv = ttk.Combobox(inventory_frame, textvariable=category_var_inv, values=categories, state='readonly', width=20)
    category_combobox_inv.grid(row=1, column=1, pady=5, padx=5)
    category_combobox_inv.bind('<<ComboboxSelected>>', lambda e: update_inventory_by_category())
    Label(inventory_frame, text="Brand:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=1, column=2, sticky=W, padx=5)
    brand_var = StringVar(value="All Brands")
    brand_combobox = ttk.Combobox(inventory_frame, textvariable=brand_var, values=['All Brands', 'AMD', 'Intel'], state='readonly', width=15)
    brand_combobox.grid(row=1, column=3, pady=5, padx=5)
    brand_combobox.bind('<<ComboboxSelected>>', lambda e: update_inventory_by_brand())
    Label(inventory_frame, text="Search:", bg='white', font=('Microsoft YaHei UI Light', 11)).grid(row=2, column=0, sticky=W, padx=10)
    search_entry = Entry(inventory_frame, font=('Microsoft YaHei UI Light', 11), width=20)
    search_entry.grid(row=2, column=1, padx=5, pady=5)
    Button(inventory_frame, text="Search/Refresh", **button_style, command=search_inventory).grid(row=2, column=2, padx=5, pady=5)
    Checkbutton(inventory_frame, text="Auto-Refresh", variable=auto_refresh_var, bg='white',
                font=('Microsoft YaHei UI Light', 11), command=auto_refresh_inventory).grid(row=2, column=3, padx=5, pady=5)
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
    if auto_refresh_var.get():
        auto_refresh_inventory()

    # Reports Frame
    reports_frame = Frame(content_frame, **card_style)

    def generate_daily_report():
        for widget in report_list_frame.winfo_children():
            widget.destroy()
        conn = get_db_connection()
        if not conn:
            return
        try:
            cursor = conn.cursor()
            today = date.today()
            cursor.execute('''
                SELECT i.name, SUM(s.quantity) as total_qty, SUM(s.total) as total_amt
                FROM sales s JOIN items i ON s.item_id=i.id
                WHERE s.employee_username=%s AND DATE(s.sale_time)=%s
                GROUP BY i.name
            ''', (username, today))
            sales = cursor.fetchall()
            total_sales = sum(row[2] for row in sales)
            Label(report_list_frame, text=f"Today's Sales: ₱{total_sales:.2f}", bg='white',
                  font=('Microsoft YaHei UI Light', 12, 'bold')).pack(pady=5)
            for name, qty, amt in sales:
                Label(report_list_frame, text=f"{name}: {qty} units, ₱{amt:.2f}", bg='white',
                      font=('Microsoft YaHei UI Light', 10)).pack(pady=2)
        except Exception as e:
            messagebox.showerror("Error", f"Failed to generate report: {e}")
        finally:
            conn.close()

    Label(reports_frame, text="Daily Sales Report", bg='white', font=('Microsoft YaHei UI Light', 16, 'bold')).pack(pady=10)
    Button(reports_frame, text="Generate Report", **button_style, command=generate_daily_report).pack(pady=5)
    report_list_frame = Frame(reports_frame, bg='white')
    report_list_frame.pack(pady=10)

    # Logs Frame
    logs_frame = Frame(content_frame, **card_style)

    def view_logs():
        for widget in logs_list_frame.winfo_children():
            widget.destroy()
        conn = get_db_connection()
        if not conn:
            return
        try:
            cursor = conn.cursor()
            cursor.execute('SELECT action, log_time FROM employee_logs WHERE username=%s ORDER BY log_time DESC', (username,))
            logs = cursor.fetchall()
            for action, log_time in logs:
                Label(logs_list_frame, text=f"{log_time}: {action}", bg='white',
                      font=('Microsoft YaHei UI Light', 10)).pack(pady=2)
        except Exception as e:
            messagebox.showerror("Error", f"Failed to load logs: {e}")
        finally:
            conn.close()

    Label(logs_frame, text="My Activity Logs", bg='white', font=('Microsoft YaHei UI Light', 16, 'bold')).pack(pady=10)
    Button(logs_frame, text="View Logs", **button_style, command=view_logs).pack(pady=5)
    logs_list_frame = Frame(logs_frame, bg='white')
    logs_list_frame.pack(pady=10)

    # Logout Function
    def logout():
        nonlocal inventory_after_id
        if inventory_after_id:
            window.after_cancel(inventory_after_id)
            inventory_after_id = None
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

    show_frame(sales_frame, "Sales")
    log_action("Logged in")
    return window

if __name__ == "__main__":
    window = create_dashboard_window("test_user")
    window.mainloop()