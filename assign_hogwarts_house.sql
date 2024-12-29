-- Asigna a los empleados una casa de Hogwarts de manera aleatoria
SELECT 
    e.EmployeeID, 
    CONCAT(e.FirstName, ' ', e.LastName) AS NombreCompleto, 
    CASE ABS(CHECKSUM(NEWID())) % 4
        WHEN 0 THEN 'Gryffindor' 
        WHEN 1 THEN 'Hufflepuff' 
        WHEN 2 THEN 'Ravenclaw' 
        WHEN 3 THEN 'Slytherin' 
    END AS CasaHogwarts
FROM Employees e
ORDER BY e.LastName, e.FirstName;
