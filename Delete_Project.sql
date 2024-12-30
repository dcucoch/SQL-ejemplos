CREATE PROCEDURE DeleteProject
    @ProjectID INT -- ID del proyecto a eliminar
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verificar que no haya empleados asignados al proyecto
        IF EXISTS (
            SELECT 1 
            FROM ProjectAssignments 
            WHERE ProjectID = @ProjectID
        )
        BEGIN
            THROW 50003, 'Cannot delete project with assigned employees.', 1;
        END

        -- Eliminar el proyecto
        DELETE FROM Projects
        WHERE ProjectID = @ProjectID;

        PRINT 'Project deleted successfully.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
