CREATE PROCEDURE AssignEmployeeToProject
    @EmployeeID INT,  -- ID del empleado a asignar
    @ProjectID INT    -- ID del proyecto al que se asignará el empleado
AS
BEGIN
    SET NOCOUNT ON;

    -- Manejo de errores y transacciones
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar si el empleado ya está asignado al proyecto
        IF EXISTS (
            SELECT 1 
            FROM ProjectAssignments 
            WHERE EmployeeID = @EmployeeID AND ProjectID = @ProjectID
        )
        BEGIN
            THROW 50002, 'Employee is already assigned to this project.', 1;
        END

        -- Asignar empleado al proyecto
        INSERT INTO ProjectAssignments (EmployeeID, ProjectID, AssignedDate)
        VALUES (@EmployeeID, @ProjectID, GETDATE());

        -- Confirmar la asignación
        PRINT 'Employee assigned successfully.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Revertir la transacción en caso de error
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
