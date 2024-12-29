-- Consulta para obtener empleados con mayor antigüedad
SELECT 
    e.EmployeeID, 
    CONCAT(e.FirstName, ' ', e.LastName) AS NombreCompleto, 
    d.DepartmentName AS Departamento, 
    DATEDIFF(YEAR, e.DateOfJoining, GETDATE()) AS AñosDeServicio
FROM Employees e
LEFT JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE e.DateOfJoining IS NOT NULL
ORDER BY AñosDeServicio DESC;
