-- Procedimiento para desactivar a un empleado aleatoriamente
CREATE PROCEDURE RandomlyDeactivateEmployee
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @RandomEmployeeID INT;
        SELECT TOP 1 @RandomEmployeeID = EmployeeID
        FROM Employees
        WHERE Status = 'Active'
        ORDER BY NEWID();

        IF @RandomEmployeeID IS NOT NULL
        BEGIN
            UPDATE Employees
            SET Status = 'Inactive'
            WHERE EmployeeID = @RandomEmployeeID;

            PRINT 'Empleado desactivado: ' + CAST(@RandomEmployeeID AS NVARCHAR(10));
        END
        ELSE
        BEGIN
            PRINT 'No hay empleados activos disponibles para desactivar.';
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
