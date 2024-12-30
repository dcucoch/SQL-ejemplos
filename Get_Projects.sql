CREATE PROCEDURE GetProjectsByDepartment
    @DepartmentID INT -- ID del departamento cuyos proyectos se desean obtener
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar entrada
    IF @DepartmentID IS NULL
    BEGIN
        THROW 50001, 'DepartmentID cannot be NULL.', 1;
    END

    -- Consultar proyectos por departamento
    SELECT 
        p.ProjectID,        -- ID del proyecto
        p.ProjectName,      -- Nombre del proyecto
        p.Status,           -- Estado del proyecto
        d.DepartmentName    -- Nombre del departamento
    FROM Projects p
    INNER JOIN Departments d 
        ON p.DepartmentID = d.DepartmentID
    WHERE p.DepartmentID = @DepartmentID
    ORDER BY 
        p.Status ASC,       -- Ordenar por estado
        p.ProjectName ASC;  -- Luego ordenar por nombre del proyecto
END;
