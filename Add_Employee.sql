CREATE PROCEDURE AddEmployee
    @FirstName NVARCHAR(50),  -- Nombre del empleado
    @LastName NVARCHAR(50),   -- Apellido del empleado
    @DepartmentID INT,        -- ID del departamento donde se asignará
    @DateOfJoining DATE       -- Fecha de ingreso del empleado
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insertar el nuevo empleado
        INSERT INTO Employees (FirstName, LastName, DepartmentID, DateOfJoining)
        VALUES (@FirstName, @LastName, @DepartmentID, @DateOfJoining);

        -- Retornar el ID del empleado recién creado
        SELECT SCOPE_IDENTITY() AS NewEmployeeID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Revertir transacción y manejar errores
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
