# WSiOS Dashboard Example

## Overview

This repository contains a sample iOS project demonstrating the implementation of a dynamic and interactive UITableView in the DashboardVC. The primary focus is on a custom subclass of UITableViewCells, named DashboardTableCell, designed for a unique user interaction experience. The project is structured to showcase advanced UITableView functionalities within a typical iOS dashboard setting.

## Features

- **Clickable Table Rows**: The DashboardTableCells within the tblDashboard are designed to be interactive. When a user taps on a cell, it expands to reveal additional content.
    - **Dynamic Content Display**: Each cell contains a UILabel (lblDefinition) that is initially hidden. Upon tapping the cell, lblDefinition becomes visible, displaying relevant information.
    - **Auto-Resizing Cells**: The cells dynamically adjust their size to accommodate the visibility of lblDefinition. This ensures a seamless user experience where the cell's height changes according to the content displayed.
    - **Toggle Visibility**: A second tap on the cell will hide lblDefinition, returning the cell to its original compact form. This toggle functionality adds an interactive element to the UITableView, making the dashboard more engaging.

The project serves as a practical example for developers looking to implement similar dynamic and interactive features in their UITableViews within an iOS application.

---
Note: This README.md is a basic template. You may want to add additional sections like 'Installation', 'Usage', 'Contributing', and 'License' as per your project's needs.
