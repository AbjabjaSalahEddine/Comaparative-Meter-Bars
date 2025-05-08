# 🔢 APEX Comparative Meter Bars Plugin
A custom Oracle APEX region plugin for visualizing comparative data using horizontal meter bars, ideal for dashboards that compare values (e.g., KPIs) across regions, departments, or categories.

## 📌 Features
Horizontal meter bars with configurable:
- Color
- Value and maximum
- Tick marker
- Units and number format
- Clickable labels (optional links)
- Supports dynamic data from SQL queries
- Responsive and visually clear layout
- Region subtitle support
- AJAX refresh support

## 🛠️ How It Works
The plugin fetches your query data using APEX plugin APIs and dynamically generates a bar chart using HTML and inline CSS.

Each row of data is converted into:
- A label with a clickable name
- A colored bar indicating the value proportion
- An optional tick marker showing a reference point
- A value display with unit and format

## 🔧 Required SQL Columns
Your SQL query must return these columns and map them via the plugin attributes:

| Column Alias    | Description                                                      |
|-----------------|------------------------------------------------------------------|
| `record_id`     | Unique ID for each row                                           |
| `record_name`   | Display name (e.g., city, product name)                          |
| `record_value`  | Actual value (e.g., 68461)                                       |
| `tick_value`    | Optional reference marker                                        |
| `max_value`     | Maximum possible value for scaling                               |
| `color`         | Bar color (e.g., #4285F4)                                        |
| `unit`          | Unit to display (e.g., Mt)                                       |
| `link`          | Optional URL for label click-through                             |
| `format`        | Number format (e.g., 999G999)                                    |

## 🔌 Plugin Attributes
- **Region Subtitle** – Optional subtitle displayed above the meter bars.
- **Column Mappings** – Map your SQL output columns to the plugin logic.

## 📦 Installation
1. Import the plugin file into your APEX app.
2. Add a new Region and choose this plugin type.
3. Provide a SQL query and map columns accordingly.
4. Customize region subtitle and appearance as needed.

## 🖼️ Screenshot
![How it looks](./how%20it%20looks.gif)

## 🧑‍💻 Author
Built with ❤️ for Oracle APEX by ABJABJA Salah-Eddine.
