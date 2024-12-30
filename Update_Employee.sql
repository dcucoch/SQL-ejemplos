CREATE PROCEDURE UpdateEmployeeSalary
    @EmployeeID INT,     -- ID del empleado
    @NewSalary DECIMAL(10, 2) -- Nuevo salario
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que el salario sea positivo
        IF @NewSalary <= 0
        BEGIN
            THROW 50004, 'Salary must be greater than 0.', 1;
        END

        -- Actualizar el salario del empleado
        UPDATE Employees
        SET Salary = @NewSalary
        WHERE EmployeeID = @EmployeeID;

        PRINT 'Salary updated successfully.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
