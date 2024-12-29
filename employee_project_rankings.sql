-- Creamos una tabla de clasificación para los empleados basándonos en la cantidad de proyectos activos en los que trabajan.
SELECT 
    e.EmployeeID, -- ID único del empleado
    CONCAT(e.FirstName, ' ', e.LastName) AS NombreCompleto, -- Combina el nombre y apellido
    d.DepartmentName AS Departamento, -- Nombre del departamento al que pertenece
    COUNT(DISTINCT p.ProjectID) AS CantidadProyectosActivos -- Total de proyectos activos en los que participa
FROM Employees e
LEFT JOIN ProjectAssignments pa 
    ON e.EmployeeID = pa.EmployeeID -- Relacionamos empleados con asignaciones de proyectos
LEFT JOIN Projects p 
    ON pa.ProjectID = p.ProjectID AND p.Status = 'Active' -- Filtramos proyectos que están activos
LEFT JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID -- Relacionamos empleados con departamentos
GROUP BY 
    e.EmployeeID, 
    e.FirstName, 
    e.LastName, 
    d.DepartmentName
HAVING COUNT(DISTINCT p.ProjectID) > 0 -- Solo mostramos empleados que tienen al menos un proyecto activo
ORDER BY CantidadProyectosActivos DESC, NombreCompleto ASC; -- Ordenamos por cantidad de proyectos (descendente)
