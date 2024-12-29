-- Consulta para listar los 5 departamentos con mayores salarios totales
SELECT TOP 5
    d.DepartmentName AS Departamento, 
    SUM(e.Salary) AS TotalSalarios
FROM Employees e
INNER JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalSalarios DESC;
