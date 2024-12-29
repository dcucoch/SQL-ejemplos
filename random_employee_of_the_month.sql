-- Selección aleatoria de un empleado como empleado del mes
SELECT TOP 1
    e.EmployeeID, 
    CONCAT(e.FirstName, ' ', e.LastName) AS NombreCompleto, 
    d.DepartmentName AS Departamento
FROM Employees e
LEFT JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
ORDER BY NEWID();
