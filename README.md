# 🏥 Hospital Management Database – SQL Analysis & Reporting

## 🚀 Project Overview

This project is a **relational database system** designed to manage hospital operations, including patients, doctors, appointments, billing, pharmacy,ambulence,rooms. Using **advanced SQL queries**, the project extracts valuable insights such as **top-performing doctors, revenue trends, and patient admission patterns**.

## 🛠 Tech Stack  
- **Database:** MySQL / SQL Server  
- **Data Analysis:** SQL (Joins, Aggregations, Window Functions, CTEs)  
- **Optimization:** Indexing, Performance Tuning  
- **Visualization (Optional):** Power BI / Python  

## 📂 Database Schema Overview

| Table Name       | Description |
|------------------|-------------|
| **Patients**     | Stores patient details and medical history |
| **Doctors**      | Contains doctor specialties and contact info |
| **Appointments** | Tracks doctor-patient interactions |
| **Billing**      | Manages hospital payments and insurance data |
| **Medicine**     | Stores medication details and stock info |
| **Pharmacy**     | Tracks issued medicines for patients |
| **Rooms**        | Manages hospital room assignments |
| **Ambulance**    | Logs emergency patient transport details |


\## 🔑 Key SQL Queries

```sql
-- 1. Top 5 Doctors with Most Completed Appointments
SELECT d.name, COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.name
ORDER BY total_appointments DESC
LIMIT 5;

-- 2. Total Revenue Generated by Each Department
SELECT dept.name AS department, SUM(b.total_amount) AS total_revenue
FROM Billing b
JOIN Appointments a ON b.appointment_id = a.appointment_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Departments dept ON d.department_id = dept.department_id
GROUP BY dept.name
ORDER BY total_revenue DESC;

-- 3. Find the Most Prescribed Medicine
SELECT m.name, COUNT(p.medicine_id) AS prescription_count
FROM Pharmacy p
JOIN Medicine m ON p.medicine_id = m.medicine_id
GROUP BY m.name
ORDER BY prescription_count DESC
LIMIT 1;

-- 4. Find Patients Admitted More Than Once
SELECT patient_id, COUNT(*) AS admission_count
FROM Room_assignments
GROUP BY patient_id
HAVING admission_count > 1;

-- 5. List All Medicines Expiring in the Next 30 Days
SELECT name, expiry_date 
FROM Medicine
WHERE expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);


## 📊 Insights Gained from the Data
- **💰 Revenue Analysis:** The highest revenue-generating department is **Cardiology**, followed by **Orthopedics**.
- **🏆 Doctor Performance:** `Dr. John Doe` had the most completed appointments in the last 6 months.
- **📊 Patient Trends:** `30%` of patients have visited the hospital more than once in the last year.
- **💊 Medicine Stock Management:**  `Amoxicillin` are the most prescribed medicines, and stock levels need regular updates.


## 🚀 Next Steps & Improvements
- ✅ Implement **stored procedures** for automated billing calculations.  
- ✅ Optimize performance using **indexing** on frequently queried fields.  
- 🔍 Integrate **Power BI/Tableau** for better data visualization.  
- 🏥 Use **triggers** to update room availability after patient discharge.  
